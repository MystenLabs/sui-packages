module 0x4f6628a66fc08057001de96977dea8e8ab3ac2db814807b0c3521ae14cba86ac::fetcher {
    struct TickData {
        index: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        sqrt_price: u128,
        liquidity_gross: u128,
        liquidity_net: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::I128,
    }

    public fun fetch_ticks<T0, T1>(arg0: vector<u32>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : vector<TickData> {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg1);
        let v1 = 0x1::vector::empty<TickData>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&arg0)) {
            let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(*0x1::vector::borrow<u32>(&arg0, v2));
            let v4 = TickData{
                index           : v3,
                sqrt_price      : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v3),
                liquidity_gross : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_gross(v0, v3),
                liquidity_net   : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v0, v3),
            };
            0x1::vector::push_back<TickData>(&mut v1, v4);
            v2 = v2 + 1;
        };
        v1
    }

    public fun fetch_update<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : (u64, u64, u128, u128, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::reserves<T0, T1>(arg0);
        (v0, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg0))
    }

    // decompiled from Move bytecode v6
}

