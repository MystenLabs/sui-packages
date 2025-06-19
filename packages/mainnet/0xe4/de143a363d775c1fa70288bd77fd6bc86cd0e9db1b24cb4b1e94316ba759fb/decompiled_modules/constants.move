module 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants {
    public fun action_add_margin() : u8 {
        5
    }

    public fun action_adjust_leverage() : u8 {
        7
    }

    public fun action_close_position() : u8 {
        8
    }

    public fun action_deleverage() : u8 {
        3
    }

    public fun action_isolated_trade() : u8 {
        9
    }

    public fun action_liquidate() : u8 {
        2
    }

    public fun action_remove_margin() : u8 {
        6
    }

    public fun action_trade() : u8 {
        1
    }

    public fun action_withdraw() : u8 {
        4
    }

    public fun base_uint() : u64 {
        1000000000
    }

    public fun deposit_type() : u8 {
        0
    }

    public fun ed25519_scheme() : u8 {
        0
    }

    public fun empty_string() : 0x1::string::String {
        0x1::string::utf8(b"")
    }

    public fun fills_table() : u8 {
        2
    }

    public fun get_supported_operators() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"funding"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"fee"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"guardian"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"adl"));
        v0
    }

    public fun get_version() : u64 {
        1
    }

    public fun history_table() : u8 {
        1
    }

    public fun imr_threshold() : u8 {
        0
    }

    public fun lifespan() : u64 {
        7776000000
    }

    public fun max_value_u64() : u64 {
        18446744073709551615
    }

    public fun mmr_threshold() : u8 {
        1
    }

    public fun position_cross() : 0x1::string::String {
        0x1::string::utf8(b"CROSS")
    }

    public fun position_isolated() : 0x1::string::String {
        0x1::string::utf8(b"ISOLATED")
    }

    public fun position_long() : 0x1::string::String {
        0x1::string::utf8(b"LONG")
    }

    public fun position_short() : 0x1::string::String {
        0x1::string::utf8(b"SHORT")
    }

    public fun protocol_decimals() : u8 {
        9
    }

    public fun secp256k1_scheme() : u8 {
        1
    }

    public fun usdc_token_symbol() : 0x1::string::String {
        0x1::string::utf8(b"USDC")
    }

    public fun withdraw_type() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

