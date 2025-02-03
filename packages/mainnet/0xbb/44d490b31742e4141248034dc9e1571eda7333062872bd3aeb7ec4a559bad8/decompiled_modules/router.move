module 0xbb44d490b31742e4141248034dc9e1571eda7333062872bd3aeb7ec4a559bad8::router {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
    }

    public fun cetus_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: u64, arg12: u8, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xbb44d490b31742e4141248034dc9e1571eda7333062872bd3aeb7ec4a559bad8::cetus_adapter::router_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13);
        let v2 = OrderRecord{
            order_id : arg11,
            decimal  : arg12,
        };
        0x2::event::emit<OrderRecord>(v2);
        (v0, v1)
    }

    public fun cetus_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xbb44d490b31742e4141248034dc9e1571eda7333062872bd3aeb7ec4a559bad8::cetus_adapter::swap<T0, T1>(arg0, arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg3, arg4, arg5, arg6, arg7, arg10);
        let v2 = OrderRecord{
            order_id : arg8,
            decimal  : arg9,
        };
        0x2::event::emit<OrderRecord>(v2);
        (v0, v1)
    }

    public fun cetus_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xbb44d490b31742e4141248034dc9e1571eda7333062872bd3aeb7ec4a559bad8::cetus_adapter::swap<T0, T1>(arg0, arg1, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg2, false, arg3, arg4, arg5, arg6, arg7, arg10);
        let v2 = OrderRecord{
            order_id : arg8,
            decimal  : arg9,
        };
        0x2::event::emit<OrderRecord>(v2);
        (v0, v1)
    }

    public fun cetus_swap_mutil<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T2>, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: u64, arg14: u64, arg15: u64, arg16: u8, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        let (v0, v1) = 0xbb44d490b31742e4141248034dc9e1571eda7333062872bd3aeb7ec4a559bad8::cetus_adapter::swap_mutil<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg17);
        let v2 = OrderRecord{
            order_id : arg15,
            decimal  : arg16,
        };
        0x2::event::emit<OrderRecord>(v2);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

