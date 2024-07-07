Rails.application.routes.draw do
  get 'profile', to: 'users#show', as: 'user_profile'
end


GET    /articles           articles#index    # Index of articles
GET    /articles/:id       articles#show     # Show a single article
GET    /articles/new       articles#new      # Form for a new article
POST   /articles           articles#create   # Create a new article
GET    /articles/:id/edit  articles#edit     # Form to edit an article
PATCH  /articles/:id       articles#update   # Update an article
DELETE /articles/:id       articles#destroy  # Delete an article

GET    /articles/:article_id/comments          comments#index    # Index of comments for an article
GET    /articles/:article_id/comments/:id      comments#show     # Show a single comment for an article
GET    /articles/:article_id/comments/new      comments#new      # Form for a new comment on an article
POST   /articles/:article_id/comments          comments#create   # Create a new comment on an article
GET    /articles/:article_id/comments/:id/edit comments#edit     # Form to edit a comment on an article
PATCH  /articles/:article_id/comments/:id      comments#update   # Update a comment on an article
DELETE /articles/:article_id/comments/:id      comments#destroy  # Delete a comment on an article


# config/routes.rb

# Custom GET route for publishing an article
get 'articles/:id/publish', to: 'articles#publish', as: 'publish_article'

# Custom POST route for unpublishing an article
post 'articles/:id/unpublish', to: 'articles#unpublish'

# Custom PUT route for archiving an article
put 'articles/:id/archive', to: 'articles#archive', as: 'archive_article'

# Custom DELETE route for removing an article
delete 'articles/:id/remove', to: 'articles#remove', as: 'remove_article'

# Custom route with a named route helper
get 'profile', to: 'users#show', as: 'user_profile'


class ArticlesController < ApplicationController
  def preview
    @article = Article.find(params[:id])
  end

  def publish
    @article = Article.find(params[:id])
    @article.update(published: true)
    redirect_to @article, notice: 'Article was successfully published.'
  end

  def remove
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully removed.'
  end
end


class ArticlesController < ApplicationController
  def archived
    @articles = Article.where(archived: true)
  end

  def recent
    @articles = Article.order(created_at: :desc).limit(10)
  end

  def bulk_delete
    Article.where(id: params[:article_ids]).destroy_all
    redirect_to articles_path, notice: 'Selected articles were successfully deleted.'
  end
end


<table>
  <% @articles.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= link_to 'Show', admin_article_path(article) %></td>
      <td><%= link_to 'Edit', edit_admin_article_path(article) %></td>
      <td><%= link_to 'Delete', admin_article_path(article), method: :delete, data: { confirm: 'Are you sure?' } %></td>
    </tr>
  <% end %>
</table>


<!-- app/views/users/show.html.erb -->

<h1>User Profile</h1>
<p>Viewing profile for <%= @user.name %>.</p>

<%= link_to 'Edit Profile', user_profile_path %>


class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end
end
