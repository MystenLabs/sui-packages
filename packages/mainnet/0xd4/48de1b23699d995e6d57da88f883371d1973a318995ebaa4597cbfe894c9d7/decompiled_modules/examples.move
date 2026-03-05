module 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::examples {
    fun examples<T0>(arg0: 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::cup::Cup<T0>) : T0 {
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::cup::borrow<T0>(&arg0);
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::cup::borrow_mut<T0>(&mut arg0);
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::cup::value<T0>(arg0)
    }

    fun expanded_examples<T0>(arg0: 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::cup::Cup<T0>) : T0 {
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::cup::borrow<T0>(&arg0);
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::cup::borrow_mut<T0>(&mut arg0);
        0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::cup::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

