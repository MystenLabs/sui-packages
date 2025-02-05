module 0x2bd962436a13deb0d102ed5ede297e1797fb8c0c4bdaada4d66e6708a16d90ee::liquidity {
    struct Tick has copy, drop {
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct TickEventSingle has copy, drop {
        data: vector<Tick>,
    }

    struct TickEvent has copy, drop {
        data: vector<vector<Tick>>,
    }

    struct CurrentLiquidity has copy, drop {
        l: u128,
        c: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        id: 0x2::object::ID,
    }

    struct CurrentLiquidityEvent has copy, drop {
        data: vector<CurrentLiquidity>,
    }

    public fun current_liquidity_1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : vector<CurrentLiquidity> {
        let v0 = 0x1::vector::empty<CurrentLiquidity>();
        let v1 = CurrentLiquidity{
            l  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0),
            c  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0),
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
        };
        0x1::vector::push_back<CurrentLiquidity>(&mut v0, v1);
        v0
    }

    public fun current_liquidity_2<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>) : vector<CurrentLiquidity> {
        let v0 = 0x1::vector::empty<CurrentLiquidity>();
        let v1 = CurrentLiquidity{
            l  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0),
            c  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0),
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
        };
        0x1::vector::push_back<CurrentLiquidity>(&mut v0, v1);
        let v2 = CurrentLiquidity{
            l  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T2, T3>(arg1),
            c  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T3>(arg1),
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1),
        };
        0x1::vector::push_back<CurrentLiquidity>(&mut v0, v2);
        v0
    }

    public fun current_liquidity_4<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>) : vector<CurrentLiquidity> {
        let v0 = 0x1::vector::empty<CurrentLiquidity>();
        let v1 = CurrentLiquidity{
            l  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0),
            c  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0),
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
        };
        0x1::vector::push_back<CurrentLiquidity>(&mut v0, v1);
        let v2 = CurrentLiquidity{
            l  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T2, T3>(arg1),
            c  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T3>(arg1),
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1),
        };
        0x1::vector::push_back<CurrentLiquidity>(&mut v0, v2);
        let v3 = CurrentLiquidity{
            l  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T4, T5>(arg2),
            c  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T4, T5>(arg2),
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>>(arg2),
        };
        0x1::vector::push_back<CurrentLiquidity>(&mut v0, v3);
        let v4 = CurrentLiquidity{
            l  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T6, T7>(arg3),
            c  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T6, T7>(arg3),
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>>(arg3),
        };
        0x1::vector::push_back<CurrentLiquidity>(&mut v0, v4);
        v0
    }

    public fun emit_current_liquidity(arg0: vector<CurrentLiquidity>) {
        let v0 = CurrentLiquidityEvent{data: arg0};
        0x2::event::emit<CurrentLiquidityEvent>(v0);
    }

    public fun emit_single_ticks(arg0: vector<Tick>) {
        let v0 = TickEventSingle{data: arg0};
        0x2::event::emit<TickEventSingle>(v0);
    }

    public fun emit_ticks(arg0: vector<vector<Tick>>) {
        let v0 = TickEvent{data: arg0};
        0x2::event::emit<TickEvent>(v0);
    }

    public fun get_entry_ticks(arg0: &vector<Tick>, arg1: u64) : &Tick {
        0x1::vector::borrow<Tick>(arg0, arg1)
    }

    public fun get_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : vector<Tick> {
        let v0 = get_liquidity_directed<T0, T1>(arg0, true);
        0x1::vector::reverse<Tick>(&mut v0);
        0x1::vector::append<Tick>(&mut v0, get_liquidity_directed<T0, T1>(arg0, false));
        v0
    }

    public fun get_liquidity_8<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T8, T9>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T10, T11>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T12, T13>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T14, T15>) : vector<vector<Tick>> {
        let v0 = 0x1::vector::empty<vector<Tick>>();
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity<T0, T1>(arg0));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity<T2, T3>(arg1));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity<T4, T5>(arg2));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity<T6, T7>(arg3));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity<T8, T9>(arg4));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity<T10, T11>(arg5));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity<T12, T13>(arg6));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity<T14, T15>(arg7));
        v0
    }

    public fun get_liquidity_directed<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool) : vector<Tick> {
        let v0 = 0x1::vector::empty<Tick>();
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), arg1);
        while (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v1)) {
            let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick_for_swap(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0), 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1), arg1);
            v1 = v3;
            let v4 = Tick{
                liquidity_net : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v2),
                index         : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(v2),
            };
            0x1::vector::push_back<Tick>(&mut v0, v4);
        };
        v0
    }

    public fun get_tick_index(arg0: &Tick) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.index
    }

    public fun get_tick_liquidity_net(arg0: &Tick) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128 {
        arg0.liquidity_net
    }

    // decompiled from Move bytecode v6
}

