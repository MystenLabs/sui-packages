module 0xeebf0c41c6adab56f9a7f562512051700d0d0f9fc5e10094807218242c76e111::dvn_feelib_get_fee {
    struct FeelibGetFeeParam has copy, drop, store {
        sender: address,
        dst_eid: u32,
        confirmations: u64,
        options: vector<u8>,
        quorum: u64,
        price_feed: address,
        default_multiplier_bps: u16,
        gas: u256,
        multiplier_bps: u16,
        floor_margin_usd: u128,
    }

    public fun confirmations(arg0: &FeelibGetFeeParam) : u64 {
        arg0.confirmations
    }

    public fun create_param(arg0: address, arg1: u32, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: address, arg6: u16, arg7: u256, arg8: u16, arg9: u128) : FeelibGetFeeParam {
        FeelibGetFeeParam{
            sender                 : arg0,
            dst_eid                : arg1,
            confirmations          : arg2,
            options                : arg3,
            quorum                 : arg4,
            price_feed             : arg5,
            default_multiplier_bps : arg6,
            gas                    : arg7,
            multiplier_bps         : arg8,
            floor_margin_usd       : arg9,
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

    public fun gas(arg0: &FeelibGetFeeParam) : u256 {
        arg0.gas
    }

    public fun multiplier_bps(arg0: &FeelibGetFeeParam) : u16 {
        arg0.multiplier_bps
    }

    public fun options(arg0: &FeelibGetFeeParam) : vector<u8> {
        arg0.options
    }

    public fun price_feed(arg0: &FeelibGetFeeParam) : address {
        arg0.price_feed
    }

    public fun quorum(arg0: &FeelibGetFeeParam) : u64 {
        arg0.quorum
    }

    public fun sender(arg0: &FeelibGetFeeParam) : address {
        arg0.sender
    }

    // decompiled from Move bytecode v6
}

