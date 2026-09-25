module 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::market {
    public fun collect_lp_fees<T0, T1, T2, T3>(arg0: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T1>, arg2: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock::LockedLiquidity<T2, T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::cetus_graduation::collect_lp_fees<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun create<T0, T1>(arg0: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::factory::LaunchTicket<T0>, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1> {
        let v0 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::factory::consume<T0>(arg3);
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::create<T0, T1>(arg0, 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::cetus_graduation::reserve_pair<T0, T1>(arg1, arg2, 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::tick_spacing<T1>(arg0), &mut v0, arg8), v0, arg4, arg5, arg6, arg7, arg8)
    }

    public fun set_protocol_recipient<T0>(arg0: &0x884a8aceda89be24b53443769e868106084628dc2eb140ebc7059a8be21125f4::admin::AdminCap, arg1: &mut 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T0>, arg2: address) {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::set_protocol_recipient<T0>(arg0, arg1, arg2);
    }

    public fun buy<T0, T1>(arg0: &mut 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::buy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        assert!(!v2, 0);
        (v0, v1)
    }

    public fun buy_and_graduate<T0, T1>(arg0: &mut 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::buy<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7);
        if (v2) {
            0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::cetus_graduation::graduate<T0, T1>(arg0, arg1, arg2, arg6, arg7);
        };
        (v0, v1)
    }

    public fun claim_creator<T0, T1>(arg0: &mut 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::claim_creator<T0, T1>(arg0, arg1, arg2);
    }

    public fun claim_protocol<T0, T1>(arg0: &mut 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::claim_protocol<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun create_config<T0>(arg0: &0x884a8aceda89be24b53443769e868106084628dc2eb140ebc7059a8be21125f4::admin::AdminCap, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u32, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::create<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun create_currency<T0: drop>(arg0: T0, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::factory::create<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun sell<T0, T1>(arg0: &mut 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::sell<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun set_config_enabled<T0>(arg0: &0x884a8aceda89be24b53443769e868106084628dc2eb140ebc7059a8be21125f4::admin::AdminCap, arg1: &mut 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T0>, arg2: bool) {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::set_enabled<T0>(arg0, arg1, arg2);
    }

    public fun set_creator_recipient<T0, T1>(arg0: &mut 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::set_creator_recipient<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun share<T0, T1>(arg0: 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>) {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::share<T0, T1>(arg0);
    }

    // decompiled from Move bytecode v7
}

