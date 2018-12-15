Title: Collision Systems in PPB
Date: 2018-12-14
Category: PPB
Status: Draft

<style>
.post img {
    float: left;
    margin-right: 1em;
    clear: both;
}

.post .clear {
    clear: both;
}

</style>

Working on [PursuedPyBear](https://github.com/ppb/pursuedpybear), we often face
questions of how much to include. The question has come up about collision
systems. Everyone agrees that something should be included: They involve lots of
math, can be fiddly, and are just boring milestones on the way to actually
making a game.

The question is, though, what sort of collision system to include.

First of all, we're just talking about computing "Do these two sprites touch?"
or "What other sprites does this sprite touch?" We are not including the physics
implications that follow it (eg, jumping, bumping into walls, elastic or
inelastic collisions, or just "physics" in general).

## A Practical Example: Hug the Humans

When I wrote [Hug the Humans](https://gitlab.com/astronouth7303/mutant-games/blob/master/hugs.py),
I wrote a basic point-region collision.

![bear sprite](images/ms-bear.svg)
Quick intro, _Hug the Humans_ is a game where you play as a bear (or one of a
number of other monsters) and run around trying to hug the screaming humans.
Specifically, this bear.

<div class="clear"></div>

![bear sprite with circular region overlay](images/ms-bear-circular-region.svg)
In this case, I decided to use a circular region (shown in blue) because I felt
they better approximate the shape of most sprites (compared to rectangles) while
still keeping the math fairly straight-forward.

<div class="clear"></div>

![bear sprite with rectangular region overlay](images/ms-bear-rectangular-region.svg)
A square region wouldn't fit so well

<div class="clear"></div>

![bear sprite with region overlay and scared face with point overlay](images/ms-bear-region-face-point.svg)
By "region-point system", I mean the sprite in question (the player's bear
sprite) would compare the location points of other sprites to its own region.

As you can see, even though the player sprite (the bear) and the NPC sprite (the
"scared" face) are touching (colliding), since the point (the red dot) is not in
the region (the blue circle), a collision is not detected. For the purposes of
_Hug the Humans_, this was considered a good thing: I wanted the bear to
actually "tackle"/"hug" the NPC for it to count.

## For PursuedPyBear

There's a few proposals for PPB:

1. Just have square regions with a basic `Sprite.collides_with()` method
2. Copy/paste the code from _Hug the Humans_ as `ppb.contrib.collision`
3. Extend the _Hug the Humans_ code



<span style="font-size: smaller; font-style: italic;">Note: This post uses [Mutant Standard emoji](https://mutant.tech), which are licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).</span>
