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

How does this work?
--------------------------

Traditionally, if you were to create a styleguide for you website, you would
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
is a very important change that I made to the CSS itself. YOu may have noticed
that I added 2 new classes: `.pseudo-class-hover` and `.pseudo-class-active`.
These are specific to the KSS Ruby parser and are dynamically created when 
your stylesheets are parsed. These will come in handy, trust me.

So, in our comment block we have specified a description for our button widget,
alternate states that it can have and the styleguide section that we should
look at to see how the button appears. pretty simple right? I mean, you are
probably already commenting your CSS anyway right?

Now onto the magic. You will need to create a new file in
`app/view/flair/styleguide/` called `buttons.html.erb`. This filename can be
anything you want really, but `buttons.html.erb` makes sense since that is
what you are showing. In that file you will want to add the following code.

```erb
<%= styleguide_block '1.0' do %>
  <button class='btn $modifier_class'>I am a button</button>
<%- end -%>
```

That's it! When you create your example HTML you will need to make sure you
add the `$modifier_class` class. This is a special classname that will be
dynamically changed to any of the alternate states that you reference in your
stylesheet. This is also why we had to add those 2 new pseudo class names for
`:hover` and `:active`. The result will look something like this:

Insert Image Here