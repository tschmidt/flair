Flair
==========================

Flair is designed to make adding an interactive styleguide to your Rails 3
application a snap.

A little bit about Flair
--------------------------

The idea for Flair came after I discovered [KSS by Kyle Neath](https://github.com/kneath/kss).
Using a very specific commenting style in your stylesheets, Flair will provide
you the ability to quickly create styleguide blocks for the different components
of your website.

Flair depends on the [KSS gem](https://github.com/kneath/kss).

Installation
--------------------------

Since flair is designed to work with a Rails 3 application you can simply add
this line to your `Gemfile`.

```ruby
gem 'flair'
```

Then run the `bundle` command to install it. Once installed, you will have access
to a Rails generator called `flair:install`. This will set up all the necessary
files for you as well as mount the engine in your routes file. If you would like
to have Flair install an example styleguide for you, simply add the `--examples`
option when running the generator.

How does this work?
--------------------------

Traditionally, if you were to create a styleguide for your website, you would
need to create a new element for each variation of your component. Take a
stylized button for example. You would need to have a different HTML block for
it's normal state, hover state, active state, disabled state, etc. That's a lot
of coding (or copy and pasting).

With Flair, all you need to do is comment the code for your button, then add
one block of HTML wrapped in a helper and voila! Flair will automatically create
each of the states you specify.

So how does this happen? Here, let me show you.

Say you have the following in your `app/assets/stylesheets/buttons.css.scss`
file:

```css
.btn {
  background-color: #f9f9f9;
  
  cursor: pointer;
  display: inline-block;
  padding: 4px 10px;
  margin-bottom: 0;
  
  color: #353535;
  font-size: 13px;
  line-height: 1.2;
  text-align: center;
  vertical-align: middle;
  
  border: 1px solid #555;
  border-radius: 3px;
}

.btn:hover {
  background-color: #c9c9c9;
  color: #353535;
  text-decoration: none; // just in case this is a link
}

.btn:active {
  background-color: #666;
  color: #f8f8f8;
}
```

Now, that's just the base styling for this button, but we already have 3
different states that the button can be in: normal, hovered, and active. To
utilize Flair all you need to do is add a comment to the element you want to
show in your styleguide. So in this case, we would add it to the core style, the
`.btn`.

```css
/*
  Turns the element with this class into a stylized button. Typically used on
  <a> or <button> elements.
  
  :hover - sets the style for when the user hover their mouse over the element
  :active - sets the style for when the user click the button
  
  Styleguide 1.0
*/
.btn {
  background-color: #f9f9f9;
  
  cursor: pointer;
  display: inline-block;
  padding: 4px 10px;
  margin-bottom: 0;
  
  color: #353535;
  font-size: 13px;
  line-height: 1.2;
  text-align: center;
  vertical-align: middle;
  
  border: 1px solid #555;
  border-radius: 3px;
}

.btn:hover,
.btn.pseudo-class-hover {
  background-color: #c9c9c9;
  color: #353535;
  text-decoration: none; // just in case this is a link
}

.btn:active,
.btn.pseudo-class-active {
  background-color: #666;
  color: #f8f8f8;
}
```

I won't go into detail as to how you lay out the comments as Kyle does a good
job of that on the [KSS page](http://github.com/kneath/kss). However, there
is a very important change that I made to the CSS itself. You may have noticed
that I added 2 new classes: `.pseudo-class-hover` and `.pseudo-class-active`.
These are specific to the KSS Ruby parser and are dynamically created when 
your stylesheets are parsed. These will come in handy, trust me.

So, in our comment block we have specified a description for our button widget,
alternate states that it can have and the styleguide section that we should
look at to see how the button appears. pretty simple right? I mean, you are
probably already commenting your CSS anyway...right?

Now onto the magic. You will need to create a new file in
`app/view/flair/styleguide/` called `buttons.html.erb`. This filename can be
anything you want really, but `buttons.html.erb` makes sense since that is
what you are showing. In that file you will want to add the following code.

```erb
<%= styleguide_block '1.0' do %>
  <button class='btn $modifier_class'>I am a button</button>
<%- end -%>
```

Then, in your `app/views/flair/stlyeguides/_navigation.html.erb` file add
a link to that styleguide.

```erb
<%= link_to_styleguide '1.0 Buttons', styleguide_path(:buttons) %>
```

Point your browser to `http://yourappurl/flair` and BAM! Instant styleguide
goodness. You may have noticed the `$modifier_class` in the `styleguide_block`.
That is a special string that will be updated with the alternate states that you
specify in your styles comment block. This is also why we had to add those 2 new pseudo class names for
`:hover` and `:active`. The result will look something like this:

![Example Styleguide](https://raw.github.com/tschmidt/flair/master/example/styleguide.png)