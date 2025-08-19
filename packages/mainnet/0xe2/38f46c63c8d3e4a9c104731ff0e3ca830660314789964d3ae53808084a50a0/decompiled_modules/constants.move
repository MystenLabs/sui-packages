module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants {
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

    public fun payload_type_adl() : vector<u8> {
        b"Bluefin Pro ADL"
    }

    public fun payload_type_authorizing_liquidator() : vector<u8> {
        b"Bluefin Pro Authorizing Liquidator"
    }

    public fun payload_type_liquidate() : vector<u8> {
        b"Bluefin Pro Liquidation"
    }

    public fun payload_type_pruning_table() : vector<u8> {
        b"Bluefin Pro Pruning Table"
    }

    public fun payload_type_setting_account_fee_tier() : vector<u8> {
        b"Bluefin Pro Setting Account Fee Tier"
    }

    public fun payload_type_setting_account_type() : vector<u8> {
        b"Bluefin Pro Setting Account type"
    }

    public fun payload_type_setting_funding_rate() : vector<u8> {
        b"Bluefin Pro Setting Funding Rate"
    }

    public fun payload_type_setting_gas_fee() : vector<u8> {
        b"Bluefin Pro Setting Gas Fee"
    }

    public fun payload_type_setting_gas_pool() : vector<u8> {
        b"Bluefin Pro Setting Gas Pool"
    }

    public fun payload_type_tee_asset_update() : vector<u8> {
        b"Bluefin Pro TEE Asset Update"
    }

    public fun payload_type_tee_position_update() : vector<u8> {
        b"Bluefin Pro TEE Position Update"
    }

    public fun payload_type_tee_user_authorized_accounts_update() : vector<u8> {
        b"Bluefin Pro TEE User Authorized Accounts Update"
    }

    public fun payload_type_tee_user_trade_fee_update() : vector<u8> {
        b"Bluefin Pro TEE User Trade Fee Update"
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

