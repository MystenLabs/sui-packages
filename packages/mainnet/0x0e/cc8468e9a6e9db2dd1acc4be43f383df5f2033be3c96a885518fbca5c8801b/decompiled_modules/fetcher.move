module 0xecc8468e9a6e9db2dd1acc4be43f383df5f2033be3c96a885518fbca5c8801b::fetcher {
    struct CetusTick has copy, drop {
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
        liquidity_gross: u128,
    }

    struct CetusStatus has copy, drop {
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_price: u128,
        liquidity: u128,
    }

    public entry fun fetcher<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: vector<u32>) {
        let v0 = 0;
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0);
        while (v0 < 0x1::vector::length<u32>(&arg1)) {
            let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, v0));
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick(v1, v2);
            let v4 = CetusTick{
                index           : v2,
                sqrt_price      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::sqrt_price(v3),
                liquidity_net   : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v3),
                liquidity_gross : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_gross(v3),
            };
            0x2::event::emit<CetusTick>(v4);
            v0 = v0 + 1;
        };
        let v5 = CetusStatus{
            index      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0),
            sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
            liquidity  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0),
        };
        0x2::event::emit<CetusStatus>(v5);
    }

    // decompiled from Move bytecode v6
}

