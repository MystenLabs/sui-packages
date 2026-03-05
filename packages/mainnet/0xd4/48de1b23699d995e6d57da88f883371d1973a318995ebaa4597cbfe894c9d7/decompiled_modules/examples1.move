module 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::examples1 {
    fun example(arg0: &0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Rectangle, arg1: &0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Box) : u64 {
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::rectangle_base(arg0) * 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::rectangle_height(arg0) + 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::box_base(arg1) * 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::box_height(arg1) * 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::box_depth(arg1)
    }

    fun expanded_example(arg0: &0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Rectangle, arg1: &0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Box) : u64 {
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::rectangle_base(arg0) * 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::rectangle_height(arg0) + 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::box_base(arg1) * 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::box_height(arg1) * 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::box_depth(arg1)
    }

    // decompiled from Move bytecode v6
}

