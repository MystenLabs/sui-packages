module 0xdd069eeacf58d6854cb40fc623ac0b1235dda066d3b537a2b6f5fe60c6a563fa::liquidity {
    struct Tick has copy, drop {
        liquidity_net: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::I128,
        index: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
    }

    struct LiquidityWindow has copy, drop {
        current_liquidity: u128,
        current_tick: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        tick_spacing: u32,
        current_sqrt_price: u128,
        window_size: u32,
        ticks: vector<Tick>,
    }

    struct I32Vector has copy, drop {
        data: vector<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32>,
    }

    struct TickEventSingle has copy, drop {
        data: vector<Tick>,
    }

    struct TickEvent has copy, drop {
        data: vector<vector<Tick>>,
    }

    public fun current_tick_spacing_index(arg0: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg1: u32) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::abs_u32(arg0);
        if (v0 % arg1 == 0) {
            arg0
        } else if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::is_neg(arg0)) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::neg_from(v0 / arg1 + 1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(arg1))
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(v0 / arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(arg1))
        }
    }

    public fun emit_integers(arg0: vector<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32>) {
        let v0 = I32Vector{data: arg0};
        0x2::event::emit<I32Vector>(v0);
    }

    public fun emit_liquidity_window(arg0: LiquidityWindow) {
        0x2::event::emit<LiquidityWindow>(arg0);
    }

    public fun emit_single_ticks(arg0: vector<Tick>) {
        let v0 = TickEventSingle{data: arg0};
        0x2::event::emit<TickEventSingle>(v0);
    }

    public fun emit_ticks(arg0: vector<vector<Tick>>) {
        let v0 = TickEvent{data: arg0};
        0x2::event::emit<TickEvent>(v0);
    }

    public fun get_liquidity_window<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u32) : LiquidityWindow {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg0);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0);
        let v2 = 0x1::vector::empty<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32>();
        let v3 = 0;
        while (v3 < 2 * arg1 + 1) {
            0x1::vector::push_back<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32>(&mut v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(current_tick_spacing_index(v0, v1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mul(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(v3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(arg1)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(v1))));
            v3 = v3 + 1;
        };
        LiquidityWindow{
            current_liquidity  : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0),
            current_tick       : v0,
            tick_spacing       : v1,
            current_sqrt_price : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0),
            window_size        : arg1,
            ticks              : get_ticks<T0, T1>(arg0, v2),
        }
    }

    public fun get_tick_index(arg0: &Tick) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32 {
        arg0.index
    }

    public fun get_tick_liquidity_net(arg0: &Tick) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::I128 {
        arg0.liquidity_net
    }

    public fun get_ticks<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: vector<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32>) : vector<Tick> {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0);
        let v1 = 0x1::vector::empty<Tick>();
        0x1::vector::reverse<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32>(&mut arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32>(&arg1)) {
            let v3 = 0x1::vector::pop_back<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32>(&mut arg1);
            if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::is_initialized(v0, v3)) {
                let v4 = Tick{
                    liquidity_net : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(v0, v3),
                    index         : v3,
                };
                0x1::vector::push_back<Tick>(&mut v1, v4);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32>(arg1);
        v1
    }

    // decompiled from Move bytecode v6
}

