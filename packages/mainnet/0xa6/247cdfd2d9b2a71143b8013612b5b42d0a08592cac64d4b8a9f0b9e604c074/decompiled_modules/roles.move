module 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::roles {
    public fun role_admin() : u8 {
        1
    }

    public fun role_burn() : u8 {
        3
    }

    public fun role_mint() : u8 {
        2
    }

    public fun role_receive() : u8 {
        5
    }

    public fun role_transfer() : u8 {
        4
    }

    // decompiled from Move bytecode v6
}

