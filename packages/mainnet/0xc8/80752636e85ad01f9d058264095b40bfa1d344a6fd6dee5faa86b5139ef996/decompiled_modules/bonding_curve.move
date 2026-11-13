module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::bonding_curve {
    struct Curve<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin: 0x1::ascii::String,
        quote_coin: 0x1::ascii::String,
        p0: u64,
        p1: u64,
        cap: u64,
        sold: u64,
        tokens: 0x2::balance::Balance<T0>,
        raised: 0x2::balance::Balance<T1>,
        raised_total: u64,
        paused: bool,
        graduated: bool,
        withdrawn: bool,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        quote_coin: 0x1::ascii::String,
        p0: u64,
        p1: u64,
        cap: u64,
        target: u64,
    }

    struct CurveFunded has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    struct Bought has copy, drop {
        curve_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        cost: u64,
        sold_after: u64,
        price_after: u64,
    }

    struct Graduated has copy, drop {
        curve_id: 0x2::object::ID,
        raised: u64,
        final_price: u64,
    }

    struct GraduationWithdrawn has copy, drop {
        curve_id: 0x2::object::ID,
        quote: u64,
        lp_soos: u64,
    }

    struct PausedSet has copy, drop {
        curve_id: 0x2::object::ID,
        paused: bool,
    }

    public fun buy<T0, T1>(arg0: &mut Curve<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!arg0.paused, 2);
        assert!(!arg0.graduated, 3);
        assert!(arg1 > 0, 4);
        assert!(arg1 <= arg0.cap - arg0.sold, 5);
        assert!(0x2::balance::value<T0>(&arg0.tokens) >= arg1, 6);
        let v0 = cost_of(arg0.p0, arg0.p1, arg0.cap, arg0.sold, arg1);
        assert!(v0 <= arg3, 7);
        assert!(0x2::coin::value<T1>(&arg2) >= v0, 8);
        0x2::balance::join<T1>(&mut arg0.raised, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v0, arg4)));
        arg0.raised_total = arg0.raised_total + v0;
        arg0.sold = arg0.sold + arg1;
        let v1 = Bought{
            curve_id    : 0x2::object::id<Curve<T0, T1>>(arg0),
            buyer       : 0x2::tx_context::sender(arg4),
            amount      : arg1,
            cost        : v0,
            sold_after  : arg0.sold,
            price_after : price_at(arg0.p0, arg0.p1, arg0.cap, arg0.sold),
        };
        0x2::event::emit<Bought>(v1);
        if (arg0.sold == arg0.cap) {
            arg0.graduated = true;
            let v2 = Graduated{
                curve_id    : 0x2::object::id<Curve<T0, T1>>(arg0),
                raised      : arg0.raised_total,
                final_price : arg0.p1,
            };
            0x2::event::emit<Graduated>(v2);
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, arg1), arg4), arg2)
    }

    public fun cap<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.cap
    }

    public fun cost_of(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg0 as u256);
        let v1 = (arg2 as u256);
        let v2 = (arg4 as u256);
        let v3 = 2 * v1 * 1000000;
        let v4 = (2 * v1 * v0 * v2 + ((arg1 as u256) - v0) * (2 * (arg3 as u256) * v2 + v2 * v2) + v3 - 1) / v3;
        assert!(v4 <= 18446744073709551615, 11);
        (v4 as u64)
    }

    public fun create<T0, T1>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_curve<T0, T1>(arg1, arg2, arg3, arg4);
        0x2::transfer::share_object<Curve<T0, T1>>(v0);
        0x2::object::id<Curve<T0, T1>>(&v0)
    }

    public fun create_funded<T0, T1>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_curve<T0, T1>(arg1, arg2, arg3, arg5);
        0x2::balance::join<T0>(&mut v0.tokens, 0x2::coin::into_balance<T0>(arg4));
        let v1 = 0x2::object::id<Curve<T0, T1>>(&v0);
        let v2 = CurveFunded{
            curve_id : v1,
            amount   : 0x2::coin::value<T0>(&arg4),
        };
        0x2::event::emit<CurveFunded>(v2);
        0x2::transfer::share_object<Curve<T0, T1>>(v0);
        v1
    }

    public fun fund<T0, T1>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Curve<T0, T1>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.tokens, 0x2::coin::into_balance<T0>(arg2));
        let v0 = CurveFunded{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg1),
            amount   : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<CurveFunded>(v0);
    }

    public fun is_graduated<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.graduated
    }

    public fun is_paused<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.paused
    }

    public fun is_withdrawn<T0, T1>(arg0: &Curve<T0, T1>) : bool {
        arg0.withdrawn
    }

    fun name<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    fun new_curve<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Curve<T0, T1> {
        let v0 = if (arg0 > 0) {
            if (arg1 >= arg0) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = Curve<T0, T1>{
            id           : 0x2::object::new(arg3),
            coin         : name<T0>(),
            quote_coin   : name<T1>(),
            p0           : arg0,
            p1           : arg1,
            cap          : arg2,
            sold         : 0,
            tokens       : 0x2::balance::zero<T0>(),
            raised       : 0x2::balance::zero<T1>(),
            raised_total : 0,
            paused       : false,
            graduated    : false,
            withdrawn    : false,
        };
        let v2 = CurveCreated{
            curve_id   : 0x2::object::id<Curve<T0, T1>>(&v1),
            coin       : v1.coin,
            quote_coin : v1.quote_coin,
            p0         : arg0,
            p1         : arg1,
            cap        : arg2,
            target     : cost_of(arg0, arg1, arg2, 0, arg2),
        };
        0x2::event::emit<CurveCreated>(v2);
        v1
    }

    public fun params<T0, T1>(arg0: &Curve<T0, T1>) : (u64, u64, u64) {
        (arg0.p0, arg0.p1, arg0.cap)
    }

    public fun price_at(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (((arg0 as u256) + ((arg1 - arg0) as u256) * (arg3 as u256) / (arg2 as u256)) as u64)
    }

    public fun quote<T0, T1>(arg0: &Curve<T0, T1>, arg1: u64) : u64 {
        cost_of(arg0.p0, arg0.p1, arg0.cap, arg0.sold, arg1)
    }

    public fun raised<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.raised)
    }

    public fun raised_total<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.raised_total
    }

    public fun set_paused<T0, T1>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Curve<T0, T1>, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedSet{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg1),
            paused   : arg2,
        };
        0x2::event::emit<PausedSet>(v0);
    }

    public fun sold<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        arg0.sold
    }

    public fun soos_for_quote(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u256) * 1000000 / (arg1 as u256)) as u64)
    }

    public fun spot_price<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        price_at(arg0.p0, arg0.p1, arg0.cap, arg0.sold)
    }

    public fun target<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        cost_of(arg0.p0, arg0.p1, arg0.cap, 0, arg0.cap)
    }

    public fun tokens<T0, T1>(arg0: &Curve<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun withdraw_graduation<T0, T1>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Curve<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert!(arg1.graduated, 9);
        assert!(!arg1.withdrawn, 10);
        arg1.withdrawn = true;
        let v0 = 0x2::balance::value<T1>(&arg1.raised);
        let v1 = soos_for_quote(v0, arg1.p1);
        let v2 = v1;
        if (v1 > 0x2::balance::value<T0>(&arg1.tokens)) {
            v2 = 0x2::balance::value<T0>(&arg1.tokens);
        };
        let v3 = GraduationWithdrawn{
            curve_id : 0x2::object::id<Curve<T0, T1>>(arg1),
            quote    : v0,
            lp_soos  : v2,
        };
        0x2::event::emit<GraduationWithdrawn>(v3);
        (0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.raised), arg2), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tokens, v2), arg2))
    }

    public fun withdraw_unsold<T0, T1>(arg0: &0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange::AdminCap, arg1: &mut Curve<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (arg1.graduated) {
            if (arg1.withdrawn) {
                0
            } else {
                0x2::balance::value<T0>(&arg1.tokens)
            }
        } else {
            arg1.cap - arg1.sold
        };
        assert!(0x2::balance::value<T0>(&arg1.tokens) >= v0 && arg2 <= 0x2::balance::value<T0>(&arg1.tokens) - v0, 11);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.tokens, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

