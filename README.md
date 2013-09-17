# Ruby-ERD

This gem is in its nascent stages.

Please bear with me while I flesh out the interface.

TODO

## Purpose

TODO

## Dependencies

TODO

## Example: NAME

TODO

```ruby
erd = ERDBuilder.new
erd.begin_system("Learning Ruby-ERD")

group = erd.add_entity("Group")
group.attributes = {name: :string, bio: :string}

media = erd.add_entity("Media")
media.attributes = {name: :string, description: :string}

notification = erd.add_entity("Notification")
notification.attributes = {activity_id: :integer, user_id: :integer}

package = erd.add_entity("Package")
package.attributes = {name: :string, description: :string}

question = erd.add_entity("Question")
question.attributes = {name: :string}

activity = erd.add_entity("Activity")
activity.attributes = {owner_id: :integer, actionable_id: :integer, actionable_type: :string}

test = erd.add_entity("Test")
test.attributes = {name: :string, description: :string}

comment = erd.add_entity("Comments")
comment.attributes = {author_id: :integer, comment: :string}

user = erd.add_entity("User")
user.attributes = {email: :string, password: :string}

erd.associate(activity, notification, {association: :one_to_one, name: "causes"})

erd.associate(package, [media, group, question, test], {association: :many_to_many, name: "contains"})

erd.associate(user, media, {association: :one_to_many, name: "uploads"})
erd.associate(user, group, {association: :many_to_many, name: "manages"})
erd.associate(user, group, {association: :many_to_many, name: "member of"})
erd.associate(user, package, {association: :one_to_many, name: "builds"})
erd.associate(user, notification, {association: :one_to_many, name: "receives"})
erd.associate(user, question, {association: :one_to_many, name: "answers"})
erd.associate(user, activity, {association: :one_to_many, name: "causes"})
erd.associate(user, test, {association: :one_to_many, name: "undertakes"})
erd.associate(user, comment, {association: :one_to_many, name: "authors"})

erd.join(test, question, "compiled from")

erd.export_as_png
```