module 0xd482532fa789eca8be57a4849ac46eccda418e2f1964024973fac6ab46539072::move_pump {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        platform_fee: u64,
        graduated_fee: u64,
        initial_virtual_sui_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
    }

    // decompiled from Move bytecode v6
}

