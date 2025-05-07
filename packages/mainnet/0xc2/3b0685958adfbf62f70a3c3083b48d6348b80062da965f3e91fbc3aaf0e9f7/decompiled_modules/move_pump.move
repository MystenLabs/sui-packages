module 0xc23b0685958adfbf62f70a3c3083b48d6348b80062da965f3e91fbc3aaf0e9f7::move_pump {
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

