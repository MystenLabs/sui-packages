module 0x5f0169c8b5e528f32edaf9c11e038ee337a780130273966e55c0a279e4184cbe::mmt {
    struct TickInfo has copy, drop, store {
        index: u32,
        liquidity_net: u128,
    }

    public fun get_ticks<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: vector<u32>) : vector<TickInfo> {
        if (0x1::vector::is_empty<u32>(&arg1)) {
            abort 0
        };
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0);
        let v1 = 0x1::vector::empty<TickInfo>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&arg1)) {
            let v3 = *0x1::vector::borrow<u32>(&arg1, v2);
            let v4 = TickInfo{
                index         : v3,
                liquidity_net : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::as_u128(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(v3))),
            };
            0x1::vector::push_back<TickInfo>(&mut v1, v4);
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

