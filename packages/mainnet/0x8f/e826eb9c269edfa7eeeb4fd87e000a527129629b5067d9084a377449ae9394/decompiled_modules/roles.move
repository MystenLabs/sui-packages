module 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles {
    public fun role_blacklist_manager() : u8 {
        5
    }

    public fun role_collateral_manager() : u8 {
        2
    }

    public fun role_gate_keeper() : u8 {
        3
    }

    public fun role_minter() : u8 {
        0
    }

    public fun role_redeemer() : u8 {
        1
    }

    public fun role_rewarder() : u8 {
        4
    }

    // decompiled from Move bytecode v6
}

