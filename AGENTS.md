Context and conventions for AI coding agents working in this repository.

## Project

A mini ERP built with Ruby on Rails. Multi-tenant from the ground up: every
resource belongs to an `Organization` and must be scoped accordingly.

## Stack

- Ruby on Rails (full stack)
- PostgreSQL
- RSpec for tests (`bundle exec rspec`)
- Rubocop for linting (`bundle exec rubocop`)
- Devise for authentication
- `acts_as_tenant` for multi-tenancy

## Multi-tenancy rules

- Every tenant-scoped model must have an `organization_id` column and declare
  `acts_as_tenant(:organization)`.
- Never query tenant-scoped models without going through the current tenant
  scope. Do not add manual `where(organization_id: ...)` filters — that's
  what `acts_as_tenant` is for.
- New migrations that add a tenant-scoped table must include a not-null
  `organization_id` foreign key from the start.

## Authentication rules

- Users authenticate through Devise using email and password.
- Keep `acts_as_tenant(:organization)` on `User` and preserve the current
  organization when handling authenticated requests.
- Protect authenticated application routes with `authenticate_user!`.
- Use `/login` and `/logout` for the Devise session endpoints.

## Workflow expected from the agent

1. Read the linked GitHub issue in full, including acceptance criteria.
2. Plan the change before writing code — list the files you expect to touch.
3. Implement, then run `bundle exec rspec` in a loop, fixing failures until
   green.
4. Run `bundle exec rubocop` and fix offenses before finishing.
5. Do not push or open a PR unless explicitly asked to — leave changes for
   local review first.

## Code style

- Follow standard Rails conventions (fat models are fine, skinny
  controllers, no business logic in views).
- Prefer explicit, boring code over clever metaprogramming.
- Every new model, service, or job needs at least one spec.
- RSpec examples belong under `spec/`; request specs should cover authentication
  redirects and protected routes.

## Commits and PRs

- Reference the issue number in commits and PR descriptions
  (`Closes #N`).
- One ticket = one PR. Don't bundle unrelated changes.
