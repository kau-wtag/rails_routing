# app/controllers/welcome_controller.rb
class WelcomeController < ApplicationController
  def index
    # action code here
  end
end


<%= link_to 'Publish', publish_article_path(@article), method: :get %>
<%= link_to 'Unpublish', articles_unpublish_path(@article), method: :post %>
<%= link_to 'Archive', archive_article_path(@article), method: :put %>
<%= link_to 'Remove', remove_article_path(@article), method: :delete, data: { confirm: 'Are you sure?' } %>

class ArticlesController < ApplicationController
  def publish
    @article = Article.find(params[:id])
    @article.update(published: true)
    redirect_to @article, notice: 'Article was successfully published.'
  end

  def unpublish
    @article = Article.find(params[:id])
    @article.update(published: false)
    redirect_to @article, notice: 'Article was successfully unpublished.'
  end

  def archive
    @article = Article.find(params[:id])
    @article.update(archived: true)
    redirect_to @article, notice: 'Article was successfully archived.'
  end

  def remove
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully removed.'
  end
end

<table>
  <% @articles.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= link_to 'Preview', preview_article_path(article) %></td>
      <td><%= link_to 'Publish', publish_article_path(article), method: :post %></td>
      <td><%= link_to 'Remove', remove_article_path(article), method: :delete, data: { confirm: 'Are you sure?' } %></td>
    </tr>
  <% end %>
</table>


