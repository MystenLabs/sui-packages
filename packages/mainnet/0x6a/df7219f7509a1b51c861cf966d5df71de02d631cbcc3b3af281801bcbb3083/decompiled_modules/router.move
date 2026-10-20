module 0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun bound(arg0: u128, arg1: u128, arg2: bool) : u128 {
        if (arg2) {
            assert!(arg0 < arg1, 100);
            0x1::u128::max(arg0, 4295048016)
        } else {
            assert!(arg0 > arg1, 100);
            0x1::u128::min(arg0, 79226673515401279992447579055)
        }
    }

    public(friend) fun witness() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

