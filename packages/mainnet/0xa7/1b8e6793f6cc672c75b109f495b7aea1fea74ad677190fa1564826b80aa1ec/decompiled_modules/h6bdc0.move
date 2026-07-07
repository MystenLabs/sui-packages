module 0xa71b8e6793f6cc672c75b109f495b7aea1fea74ad677190fa1564826b80aa1ec::h6bdc0 {
    struct Hc0a3f has copy, drop, store {
        h71ae9: 0x1::string::String,
        hbd0d6: u64,
    }

    public fun h1f071(arg0: &0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        if (!0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h3fe3c<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 3, arg3)) {
            h84e65(0x1::string::utf8(arg2), 0);
            return
        };
        let v0 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2bdbf<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 3, arg3);
        let v1 = if (arg1 < 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::reward_length(v0)) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(v0, arg1)
        } else {
            0
        };
        h84e65(0x1::string::utf8(arg2), v1);
    }

    fun h257ca<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun h42673<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &0x2::tx_context::TxContext) {
        if (!0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h3fe3c<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1, 3, arg2)) {
            h84e65(h257ca<T0>(), 0);
            h84e65(h257ca<T1>(), 0);
            return
        };
        let v0 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2bdbf<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1, 3, arg2);
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(v0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(v0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(v0), true);
        h84e65(h257ca<T0>(), v1 + 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::owed_coin_x(v0));
        h84e65(h257ca<T1>(), v2 + 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::owed_coin_y(v0));
    }

    fun h84e65(arg0: 0x1::string::String, arg1: u64) {
        let v0 = Hc0a3f{
            h71ae9 : arg0,
            hbd0d6 : arg1,
        };
        0x2::event::emit<Hc0a3f>(v0);
    }

    // decompiled from Move bytecode v6
}

