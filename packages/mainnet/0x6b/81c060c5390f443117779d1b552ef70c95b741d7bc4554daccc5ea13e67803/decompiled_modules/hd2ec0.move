module 0x6b81c060c5390f443117779d1b552ef70c95b741d7bc4554daccc5ea13e67803::hd2ec0 {
    struct He4404 has copy, drop, store {
        h1f909: 0x1::string::String,
        h01647: u64,
    }

    public fun h0556e<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &0x2::tx_context::TxContext) {
        if (!0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h3fe3c<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, 4, arg2)) {
            hd6f63(hbbd6c<T0>(), 0);
            hd6f63(hbbd6c<T1>(), 0);
            return
        };
        let v0 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2bdbf<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, 4, arg2);
        let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::tick_range(v0);
        let (v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::get_amount_by_liquidity(v1, v2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(v0), true);
        let (v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::info_fee_owned(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::borrow_position_info<T0, T1>(arg0, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(v0)));
        hd6f63(hbbd6c<T0>(), v3 + v5);
        hd6f63(hbbd6c<T1>(), v4 + v6);
    }

    public fun h53d08<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        if (!0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h3fe3c<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, 4, arg4)) {
            hd6f63(0x1::string::utf8(arg3), 0);
            return
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::get_position_rewards<T0, T1>(arg0, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2bdbf<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, 4, arg4)));
        let v1 = if (arg2 < 0x1::vector::length<u64>(&v0)) {
            *0x1::vector::borrow<u64>(&v0, arg2)
        } else {
            0
        };
        hd6f63(0x1::string::utf8(arg3), v1);
    }

    fun hbbd6c<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    fun hd6f63(arg0: 0x1::string::String, arg1: u64) {
        let v0 = He4404{
            h1f909 : arg0,
            h01647 : arg1,
        };
        0x2::event::emit<He4404>(v0);
    }

    // decompiled from Move bytecode v6
}

