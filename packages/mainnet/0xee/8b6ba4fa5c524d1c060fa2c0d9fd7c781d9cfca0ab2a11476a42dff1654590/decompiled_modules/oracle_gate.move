module 0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::oracle_gate {
    public fun assert_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::guard::require_deadline(arg0, arg1);
    }

    public fun needs_update(arg0: u64, arg1: u64) : bool {
        arg0 < arg1
    }

    public fun needs_update_or(arg0: bool, arg1: u64, arg2: u64) : bool {
        arg0 || needs_update(arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

