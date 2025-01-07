module 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::state {
    public fun assert_state(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 0);
    }

    public fun contraction() : u8 {
        1
    }

    public fun expansion() : u8 {
        0
    }

    public fun is_contraction(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_expansion(arg0: u8) : bool {
        arg0 == 0
    }

    // decompiled from Move bytecode v6
}

