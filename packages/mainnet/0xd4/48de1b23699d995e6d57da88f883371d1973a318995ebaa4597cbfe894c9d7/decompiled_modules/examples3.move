module 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::examples3 {
    fun example(arg0: &0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Rectangle) : u64 {
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::rectangle_base(arg0) * 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::rectangle_height(arg0)
    }

    fun expanded_example(arg0: &0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::Rectangle) : u64 {
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::rectangle_base(arg0) * 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::shapes::rectangle_height(arg0)
    }

    // decompiled from Move bytecode v6
}

