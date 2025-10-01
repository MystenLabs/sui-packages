module 0xe0bee4ca2391b73abc182744d5a4cda66fd5822150ea652de6da4ddf691b5e3a::executor_feelib_get_fee {
    struct FeelibGetFeeParam has copy, drop, store {
        sender: address,
        dst_eid: u32,
        call_data_size: u64,
        options: vector<u8>,
        price_feed: address,
        default_multiplier_bps: u16,
        lz_receive_base_gas: u64,
        lz_compose_base_gas: u64,
        floor_margin_usd: u128,
        native_cap: u128,
        multiplier_bps: u16,
    }

    public fun call_data_size(arg0: &FeelibGetFeeParam) : u64 {
        arg0.call_data_size
    }

    public fun create_param(arg0: address, arg1: u32, arg2: u64, arg3: vector<u8>, arg4: address, arg5: u16, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u16) : FeelibGetFeeParam {
        FeelibGetFeeParam{
            sender                 : arg0,
            dst_eid                : arg1,
            call_data_size         : arg2,
            options                : arg3,
            price_feed             : arg4,
            default_multiplier_bps : arg5,
            lz_receive_base_gas    : arg6,
            lz_compose_base_gas    : arg7,
            floor_margin_usd       : arg8,
            native_cap             : arg9,
            multiplier_bps         : arg10,
        }
    }

    public fun default_multiplier_bps(arg0: &FeelibGetFeeParam) : u16 {
        arg0.default_multiplier_bps
    }

    public fun dst_eid(arg0: &FeelibGetFeeParam) : u32 {
        arg0.dst_eid
    }

    public fun floor_margin_usd(arg0: &FeelibGetFeeParam) : u128 {
        arg0.floor_margin_usd
    }

    public fun lz_compose_base_gas(arg0: &FeelibGetFeeParam) : u64 {
        arg0.lz_compose_base_gas
    }

    public fun lz_receive_base_gas(arg0: &FeelibGetFeeParam) : u64 {
        arg0.lz_receive_base_gas
    }

    public fun multiplier_bps(arg0: &FeelibGetFeeParam) : u16 {
        arg0.multiplier_bps
    }

    public fun native_cap(arg0: &FeelibGetFeeParam) : u128 {
        arg0.native_cap
    }

    public fun options(arg0: &FeelibGetFeeParam) : &vector<u8> {
        &arg0.options
    }

    public fun price_feed(arg0: &FeelibGetFeeParam) : address {
        arg0.price_feed
    }

    public fun sender(arg0: &FeelibGetFeeParam) : address {
        arg0.sender
    }

    // decompiled from Move bytecode v6
}

