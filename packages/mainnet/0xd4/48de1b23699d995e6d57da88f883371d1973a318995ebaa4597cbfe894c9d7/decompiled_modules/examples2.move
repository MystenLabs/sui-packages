module 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::examples2 {
    fun example(arg0: &0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Rectangle) : 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Box {
        into_box(arg0, 1)
    }

    fun expanded_example(arg0: &0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Rectangle) : 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Box {
        into_box(arg0, 1)
    }

    fun into_box(arg0: &0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Rectangle, arg1: u64) : 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Box {
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::box(0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::rectangle_base(arg0), 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::rectangle_height(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

