module 0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::orders {
    struct Leg has copy, drop, store {
        kind: u8,
        amount_in: u64,
        min_out: u64,
        trigger_out: u64,
        trail_bps: u64,
        filled: u64,
        done: bool,
    }

    struct Plan<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        funds: 0x2::balance::Balance<T0>,
        total_in: u64,
        legs: vector<Leg>,
        fee_bps: u64,
        fee_on_input: bool,
        every_ms: u64,
        next_ms: u64,
        filled_in: u64,
        filled_out: u64,
        created_ms: u64,
        expiry_ms: u64,
        filling: bool,
    }

    struct PlanReceipt<phantom T0, phantom T1> {
        plan_id: 0x2::object::ID,
        leg: u64,
        amount_in: u64,
        fee: 0x2::balance::Balance<T0>,
        quote: 0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::Quote,
    }

    struct PlanPlaced has copy, drop {
        plan_id: 0x2::object::ID,
        owner: address,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        total_in: u64,
        legs: vector<Leg>,
        fee_bps: u64,
        fee_on_input: bool,
        every_ms: u64,
        next_ms: u64,
        expiry_ms: u64,
    }

    struct PlanFilled has copy, drop {
        plan_id: 0x2::object::ID,
        owner: address,
        filler: address,
        leg: u64,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        fee_on_input: bool,
        remaining: u64,
        leg_done: bool,
        quote_out: u64,
        next_ms: u64,
    }

    struct PlanClosed has copy, drop {
        plan_id: 0x2::object::ID,
        owner: address,
        refunded: u64,
        reason: u8,
    }

    public fun begin_fill<T0, T1>(arg0: &mut Plan<T0, T1>, arg1: u64, arg2: &0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::Config, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, PlanReceipt<T0, T1>) {
        0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::assert_open(arg2);
        0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::assert_keeper(arg2, 0x2::tx_context::sender(arg9));
        assert!(!arg0.filling, 107);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 < arg0.expiry_ms, 104);
        assert!(arg1 < 0x1::vector::length<Leg>(&arg0.legs), 112);
        let v1 = *0x1::vector::borrow<Leg>(&arg0.legs, arg1);
        assert!(!v1.done, 113);
        let v2 = 0x2::balance::value<T0>(&arg0.funds);
        assert!(v2 > 0, 114);
        if (v1.kind == 3) {
            assert!(v0 >= arg0.next_ms, 115);
            arg0.next_ms = v0 + arg0.every_ms;
        };
        let v3 = take_amount(&v1, v2);
        let v4 = 0x2::object::id<Plan<T0, T1>>(arg0);
        arg0.filling = true;
        let v5 = 0x2::balance::split<T0>(&mut arg0.funds, v3);
        let v6 = if (arg0.fee_on_input) {
            0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::fee_for(v3, arg0.fee_bps)
        } else {
            0
        };
        let v7 = PlanReceipt<T0, T1>{
            plan_id   : v4,
            leg       : arg1,
            amount_in : v3,
            fee       : 0x2::balance::split<T0>(&mut v5, v6),
            quote     : 0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::check_quote(arg2, v4, arg1, v3, arg3, arg4, arg5, arg6, arg7, arg8, arg9),
        };
        (0x2::coin::from_balance<T0>(v5, arg9), v7)
    }

    public fun cancel<T0, T1>(arg0: Plan<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 106);
        close<T0, T1>(arg0, 0, arg1);
    }

    fun check_leg(arg0: &Leg, arg1: u64, arg2: bool) {
        assert!(arg0.kind <= 3, 112);
        assert!(arg0.amount_in > 0 && arg0.amount_in <= arg1, 112);
        assert!(arg0.min_out > 0, 112);
        assert!(!arg0.done && arg0.filled == 0, 112);
        assert!(arg0.kind == 3 == arg2, 117);
        if (arg0.kind == 1) {
            assert!(arg0.trigger_out >= arg0.min_out, 112);
        } else {
            assert!(arg0.trigger_out == 0, 112);
        };
        if (arg0.kind == 2) {
            assert!(arg0.trail_bps > 0 && arg0.trail_bps < 10000, 112);
        } else {
            assert!(arg0.trail_bps == 0, 112);
        };
    }

    public fun check_legs(arg0: &vector<Leg>, arg1: u64, arg2: bool) {
        let v0 = 0x1::vector::length<Leg>(arg0);
        assert!(v0 > 0 && v0 <= 8, 112);
        let v1 = 0;
        while (v1 < v0) {
            check_leg(0x1::vector::borrow<Leg>(arg0, v1), arg1, arg2);
            v1 = v1 + 1;
        };
    }

    public fun check_placement(arg0: &0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::Config, arg1: u64, arg2: u64) : u64 {
        0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::assert_open(arg0);
        let v0 = 0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::fee_bps(arg0);
        assert!(v0 <= 0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::max_fee_bps(), 119);
        assert!(arg1 > arg2 && arg1 - arg2 <= 7776000000, 103);
        v0
    }

    public fun check_price(arg0: &Leg, arg1: u64, arg2: u64, arg3: u64, arg4: &0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::Quote, arg5: u64, arg6: u64) {
        assert!(arg1 > 0, 120);
        assert!(arg3 >= mul_div_up(arg0.min_out, arg1, arg0.amount_in), 110);
        let v0 = if (arg0.kind == 1) {
            mul_div_up(arg0.trigger_out, arg1, arg0.amount_in)
        } else {
            0
        };
        if (arg0.kind == 1) {
            assert!((arg2 as u128) * (10000 as u128) <= (v0 as u128) * ((10000 + 500) as u128), 116);
        };
        if (!0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::quoted(arg4)) {
            return
        };
        let v1 = mul_div(0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::quote_out(arg4), arg5, arg6);
        assert!((arg2 as u128) * (10000 as u128) >= (v1 as u128) * ((10000 - 0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::quote_slack(arg4)) as u128), 122);
        if (arg0.kind == 1) {
            assert!(v1 <= v0, 116);
        };
        if (arg0.kind == 2) {
            let v2 = mul_div(0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::quote_peak_out(arg4), arg5, arg6);
            assert!(v2 > 0 && (v1 as u128) * (10000 as u128) <= (v2 as u128) * ((10000 - arg0.trail_bps) as u128), 123);
        };
    }

    fun close<T0, T1>(arg0: Plan<T0, T1>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.filling, 107);
        let Plan {
            id           : v0,
            owner        : v1,
            funds        : v2,
            total_in     : _,
            legs         : _,
            fee_bps      : _,
            fee_on_input : _,
            every_ms     : _,
            next_ms      : _,
            filled_in    : _,
            filled_out   : _,
            created_ms   : _,
            expiry_ms    : _,
            filling      : _,
        } = arg0;
        let v14 = v2;
        let v15 = v0;
        let v16 = 0x2::balance::value<T0>(&v14);
        if (v16 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v14, arg2), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v14);
        };
        let v17 = PlanClosed{
            plan_id  : 0x2::object::uid_to_inner(&v15),
            owner    : v1,
            refunded : v16,
            reason   : arg1,
        };
        0x2::event::emit<PlanClosed>(v17);
        0x2::object::delete(v15);
    }

    public fun dca_leg(arg0: u64, arg1: u64) : Leg {
        Leg{
            kind        : 3,
            amount_in   : arg0,
            min_out     : arg1,
            trigger_out : 0,
            trail_bps   : 0,
            filled      : 0,
            done        : false,
        }
    }

    public fun every_ms<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.every_ms
    }

    public fun expire_refund<T0, T1>(arg0: Plan<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms, 105);
        close<T0, T1>(arg0, 1, arg2);
    }

    public fun expiry_ms<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.expiry_ms
    }

    public fun fee_on_input<T0, T1>(arg0: &Plan<T0, T1>) : bool {
        arg0.fee_on_input
    }

    public fun filled_in<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.filled_in
    }

    public fun filled_out<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.filled_out
    }

    public fun finish_fill<T0, T1>(arg0: PlanReceipt<T0, T1>, arg1: &mut Plan<T0, T1>, arg2: &0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::Config, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::assert_version(arg2);
        let PlanReceipt {
            plan_id   : v0,
            leg       : v1,
            amount_in : v2,
            fee       : v3,
            quote     : v4,
        } = arg0;
        let v5 = v4;
        let v6 = v3;
        assert!(v0 == 0x2::object::id<Plan<T0, T1>>(arg1), 109);
        assert!(arg1.filling, 108);
        let v7 = *0x1::vector::borrow<Leg>(&arg1.legs, v1);
        let v8 = 0x2::balance::value<T0>(&v6);
        let v9 = v2 - v8;
        let v10 = 0x2::coin::value<T0>(&arg4);
        assert!(v10 < v9, 120);
        assert!(v10 == 0 || v7.kind != 3, 121);
        let v11 = v9 - v10;
        let v12 = if (v10 == 0) {
            v8
        } else {
            mul_div(v8, v11, v9)
        };
        let v13 = v11 + v12;
        0x2::balance::join<T0>(&mut arg1.funds, v6);
        0x2::balance::join<T0>(&mut arg1.funds, 0x2::coin::into_balance<T0>(arg4));
        let v14 = 0x2::coin::value<T1>(&arg3);
        let v15 = if (arg1.fee_on_input) {
            0
        } else {
            0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::fee_for(v14, arg1.fee_bps)
        };
        check_price(&v7, v13, v14, v14 - v15, &v5, v11, v9);
        let v16 = 0x1::vector::borrow_mut<Leg>(&mut arg1.legs, v1);
        note_fill(v16, v13, v10 == 0);
        arg1.filling = false;
        arg1.filled_in = arg1.filled_in + v13;
        arg1.filled_out = arg1.filled_out + v14 - v15;
        let v17 = 0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::fee_recipient(arg2);
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v12), arg5), v17);
        } else {
            0x2::balance::destroy_zero<T0>(0x2::balance::split<T0>(&mut v6, v12));
        };
        if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg3, v15, arg5), v17);
        };
        let v18 = if (arg1.fee_on_input) {
            v12
        } else {
            v15
        };
        let v19 = PlanFilled{
            plan_id      : v0,
            owner        : arg1.owner,
            filler       : 0x2::tx_context::sender(arg5),
            leg          : v1,
            amount_in    : v13,
            amount_out   : v14,
            fee          : v18,
            fee_on_input : arg1.fee_on_input,
            remaining    : 0x2::balance::value<T0>(&arg1.funds),
            leg_done     : 0x1::vector::borrow<Leg>(&arg1.legs, v1).done,
            quote_out    : 0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::quote_out(&v5),
            next_ms      : arg1.next_ms,
        };
        0x2::event::emit<PlanFilled>(v19);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg1.owner);
    }

    public fun leg_amount_in(arg0: &Leg) : u64 {
        arg0.amount_in
    }

    public fun leg_done(arg0: &Leg) : bool {
        arg0.done
    }

    public fun leg_filled(arg0: &Leg) : u64 {
        arg0.filled
    }

    public fun leg_is_dca(arg0: &Leg) : bool {
        arg0.kind == 3
    }

    public fun leg_is_stop(arg0: &Leg) : bool {
        arg0.kind == 1
    }

    public fun leg_is_trail(arg0: &Leg) : bool {
        arg0.kind == 2
    }

    public fun leg_kind(arg0: &Leg) : u8 {
        arg0.kind
    }

    public fun leg_min_out(arg0: &Leg) : u64 {
        arg0.min_out
    }

    public fun leg_trail_bps(arg0: &Leg) : u64 {
        arg0.trail_bps
    }

    public fun leg_trigger_out(arg0: &Leg) : u64 {
        arg0.trigger_out
    }

    public fun legs<T0, T1>(arg0: &Plan<T0, T1>) : vector<Leg> {
        arg0.legs
    }

    public fun max_lifetime_ms() : u64 {
        7776000000
    }

    public fun max_parts() : u64 {
        1000
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    public fun next_ms<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.next_ms
    }

    public fun note_fill(arg0: &mut Leg, arg1: u64, arg2: bool) {
        if (arg0.kind == 3) {
            return
        };
        arg0.filled = arg0.filled + arg1;
        if (arg2) {
            arg0.done = true;
        };
    }

    public fun owner<T0, T1>(arg0: &Plan<T0, T1>) : address {
        arg0.owner
    }

    public fun place<T0, T1>(arg0: &0x5beae54f9c1f1dc0b834249c0823da8a90e0e42c2dcbe153e6e82592ea839b46::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: vector<Leg>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = check_placement(arg0, arg6, v0);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 102);
        check_legs(&arg2, v2, arg4 > 0);
        let v3 = schedule(&arg2, v2, arg4, arg5, v0, arg6, true);
        let v4 = Plan<T0, T1>{
            id           : 0x2::object::new(arg8),
            owner        : 0x2::tx_context::sender(arg8),
            funds        : 0x2::coin::into_balance<T0>(arg1),
            total_in     : v2,
            legs         : arg2,
            fee_bps      : v1,
            fee_on_input : arg3,
            every_ms     : arg4,
            next_ms      : v3,
            filled_in    : 0,
            filled_out   : 0,
            created_ms   : v0,
            expiry_ms    : arg6,
            filling      : false,
        };
        let v5 = 0x2::object::id<Plan<T0, T1>>(&v4);
        let v6 = PlanPlaced{
            plan_id      : v5,
            owner        : v4.owner,
            coin_in      : 0x1::type_name::with_defining_ids<T0>(),
            coin_out     : 0x1::type_name::with_defining_ids<T1>(),
            total_in     : v2,
            legs         : v4.legs,
            fee_bps      : v1,
            fee_on_input : arg3,
            every_ms     : arg4,
            next_ms      : v3,
            expiry_ms    : arg6,
        };
        0x2::event::emit<PlanPlaced>(v6);
        0x2::transfer::share_object<Plan<T0, T1>>(v4);
        v5
    }

    public fun plan_fee_bps<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.fee_bps
    }

    public fun remaining<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun schedule(arg0: &vector<Leg>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : u64 {
        if (arg2 == 0) {
            assert!(arg3 == 0, 117);
            return 0
        };
        assert!(arg2 >= 300000 && arg2 <= 86400000, 117);
        assert!(0x1::vector::length<Leg>(arg0) == 1, 117);
        let v0 = 0x1::vector::borrow<Leg>(arg0, 0).amount_in;
        let v1 = (arg1 + v0 - 1) / v0;
        assert!(v1 >= 2 && v1 <= 1000, 117);
        if (arg6) {
            assert!(v1 * v0 == arg1, 117);
        };
        assert!(arg3 < arg5, 117);
        if (arg3 > arg4) {
            arg3
        } else {
            arg4
        }
    }

    public fun settle<T0, T1>(arg0: Plan<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.funds) == 0, 118);
        close<T0, T1>(arg0, 2, arg1);
    }

    public fun stop_leg(arg0: u64, arg1: u64, arg2: u64) : Leg {
        Leg{
            kind        : 1,
            amount_in   : arg0,
            min_out     : arg1,
            trigger_out : arg2,
            trail_bps   : 0,
            filled      : 0,
            done        : false,
        }
    }

    public fun stop_slack_bps() : u64 {
        500
    }

    public fun take_amount(arg0: &Leg, arg1: u64) : u64 {
        let v0 = if (arg0.kind == 3) {
            arg0.amount_in
        } else {
            arg0.amount_in - arg0.filled
        };
        let v1 = if (v0 < arg1) {
            v0
        } else {
            arg1
        };
        assert!(v1 > 0, 114);
        v1
    }

    public fun take_leg(arg0: u64, arg1: u64) : Leg {
        Leg{
            kind        : 0,
            amount_in   : arg0,
            min_out     : arg1,
            trigger_out : 0,
            trail_bps   : 0,
            filled      : 0,
            done        : false,
        }
    }

    public fun total_in<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.total_in
    }

    public fun trail_leg(arg0: u64, arg1: u64, arg2: u64) : Leg {
        Leg{
            kind        : 2,
            amount_in   : arg0,
            min_out     : arg1,
            trigger_out : 0,
            trail_bps   : arg2,
            filled      : 0,
            done        : false,
        }
    }

    // decompiled from Move bytecode v7
}

