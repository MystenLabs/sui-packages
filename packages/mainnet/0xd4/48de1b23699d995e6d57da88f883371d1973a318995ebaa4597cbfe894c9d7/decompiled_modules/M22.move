module 0xd448de1b23699d995e6d57da88f883371d1973a318995ebaa4597cbfe894c9d7::M22 {
    struct Foo has copy, drop {
        pos0: u64,
    }

    fun x() {
        Foo{pos0: 0};
        abort 0
    }

    // decompiled from Move bytecode v6
}

