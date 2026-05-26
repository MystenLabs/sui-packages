module 0xb92078d1a32be59fd60897d39911cfffb442ec195a445b7a1866e68837aa4291::h67a70 {
    struct H6066c has copy, drop, store {
        h81ed1: 0x1::string::String,
        h5533d: u64,
    }

    fun h0f68d(arg0: 0x1::string::String, arg1: u64) {
        let v0 = H6066c{
            h81ed1 : arg0,
            h5533d : arg1,
        };
        0x2::event::emit<H6066c>(v0);
    }

    public fun h324be<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_rewards<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2bdbf<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, 0, arg4)));
        let v1 = if (arg2 < 0x1::vector::length<u64>(&v0)) {
            *0x1::vector::borrow<u64>(&v0, arg2)
        } else {
            0
        };
        h0f68d(0x1::string::utf8(arg3), v1);
    }

    fun h509fd<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun h7769d<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2bdbf<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, 0, arg2);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v0);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0), true);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_fee_owned(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0)));
        h0f68d(h509fd<T0>(), v3 + v5);
        h0f68d(h509fd<T1>(), v4 + v6);
    }

    // decompiled from Move bytecode v6
}

