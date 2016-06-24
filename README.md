# Instagram

# Project 3 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **23** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign up to create a new account using Parse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [X] User can take a photo, add a caption, and post it to "Instagram"
- [X] User can view the last 20 posts submitted to "Instagram"
- [X] User can pull to refresh the last 20 posts submitted to "Instagram"
- [X] User can load more posts once he or she reaches the bottom of the feed using infinite Scrolling
- [X] User can tap a post to view post details, including timestamp and creation
- [X] User can use a tab bar to switch between all "Instagram" posts and posts published only by the user.

The following **optional** features are implemented:

- [X] Show the username and creation time for each post
- [X] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse.
- [ ] User Profiles:
   - [ ] Allow the logged in user to add a profile photo
   - [ ] Display the profile photo with each post
   - [ ] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [ ] User can like a post and see number of likes for each post in the post details screen.
- [ ] Run your app on your phone and use the camera to take the photo


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I want to discuss how to add new fields to the parse database (like number of likes, comments, etc)
2. How to obtain images and other data between views without uploading them to parse or another database

## Video Walkthrough

Here's a walkthrough of implemented user stories:


Signing up for Instagram:

<img src='https://i.imgur.com/UnofRKP.gif' title='Video Walkthrough of Sign Up' width='' alt='Video Walkthrough of Sign Up' />


Accessing detail views:

<img src='https://i.imgur.com/8wjSmcf.gif' title='Video Walkthrough of Detail Views' width='' alt='Video Walkthrough of Detail Views' />

Infinite Scroll:

<img src='https://i.imgur.com/DNepDNc.gif' title='Video Walkthrough of Infinite Scroll' width='' alt='Video Walkthrough of Infinite Scroll' />



GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- Parse


## Notes

Describe any challenges encountered while building the app.

I spent most of my time trying to fix bugs and crashes, which left less time for me to work on optionals and UI features.

## License

    Copyright [2016] [Dominique Macias]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
