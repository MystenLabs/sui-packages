module 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders {
    struct Keepers has key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    struct Leg has copy, drop, store {
        kind: u8,
        amount_in: u64,
        min_out: u64,
        trigger_out: u64,
        trail_bps: u64,
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
        input_fee: u64,
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
    }

    struct PlanClosed has copy, drop {
        plan_id: 0x2::object::ID,
        owner: address,
        refunded: u64,
        reason: u8,
    }

    public fun add_keeper(arg0: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::AdminCap, arg1: &mut Keepers, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.list, &arg2), 120);
        0x1::vector::push_back<address>(&mut arg1.list, arg2);
    }

    public fun begin_fill<T0, T1>(arg0: &mut Plan<T0, T1>, arg1: u64, arg2: &Keepers, arg3: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, PlanReceipt<T0, T1>) {
        assert!(!0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::paused(arg3), 101);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&arg2.list, &v0), 111);
        assert!(!arg0.filling, 107);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 < arg0.expiry_ms, 104);
        assert!(arg1 < 0x1::vector::length<Leg>(&arg0.legs), 112);
        let v2 = *0x1::vector::borrow<Leg>(&arg0.legs, arg1);
        assert!(!v2.done, 113);
        let v3 = 0x2::balance::value<T0>(&arg0.funds);
        assert!(v3 > 0, 114);
        if (v2.kind == 3) {
            assert!(v1 >= arg0.next_ms, 115);
            arg0.next_ms = v1 + arg0.every_ms;
        };
        arg0.filling = true;
        let v4 = if (v2.amount_in < v3) {
            v2.amount_in
        } else {
            v3
        };
        let v5 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v4), arg5);
        let v6 = if (arg0.fee_on_input) {
            0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_for(v4, arg0.fee_bps)
        } else {
            0
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, v6, arg5), 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_recipient(arg3));
        };
        let v7 = PlanReceipt<T0, T1>{
            plan_id   : 0x2::object::id<Plan<T0, T1>>(arg0),
            leg       : arg1,
            amount_in : v4,
            input_fee : v6,
        };
        (v5, v7)
    }

    public fun cancel<T0, T1>(arg0: Plan<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 106);
        close<T0, T1>(arg0, 0, arg1);
    }

    fun check_leg(arg0: &Leg, arg1: u64, arg2: bool) {
        assert!(arg0.amount_in > 0 && arg0.amount_in <= arg1, 112);
        assert!(arg0.min_out > 0, 112);
        assert!(!arg0.done, 112);
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
        assert!(arg0.kind <= 3, 112);
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

    public fun create_keepers(arg0: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Keepers{
            id   : 0x2::object::new(arg1),
            list : vector[],
        };
        0x2::transfer::share_object<Keepers>(v0);
    }

    public fun dca_leg(arg0: u64, arg1: u64) : Leg {
        Leg{
            kind        : 3,
            amount_in   : arg0,
            min_out     : arg1,
            trigger_out : 0,
            trail_bps   : 0,
            done        : false,
        }
    }

    public fun expire_refund<T0, T1>(arg0: Plan<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms, 105);
        close<T0, T1>(arg0, 1, arg2);
    }

    public fun filled_in<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.filled_in
    }

    public fun filled_out<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.filled_out
    }

    public fun finish_fill<T0, T1>(arg0: PlanReceipt<T0, T1>, arg1: &mut Plan<T0, T1>, arg2: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let PlanReceipt {
            plan_id   : v0,
            leg       : v1,
            amount_in : v2,
            input_fee : v3,
        } = arg0;
        assert!(v0 == 0x2::object::id<Plan<T0, T1>>(arg1), 109);
        assert!(arg1.filling, 108);
        let v4 = *0x1::vector::borrow<Leg>(&arg1.legs, v1);
        let v5 = 0x2::coin::value<T1>(&arg3);
        let v6 = if (arg1.fee_on_input) {
            0
        } else {
            0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_for(v5, arg1.fee_bps)
        };
        assert!(v5 - v6 >= mul_div_up(v4.min_out, v2, v4.amount_in), 110);
        if (v4.kind == 1) {
            assert!((v5 as u128) * (10000 as u128) <= (mul_div_up(v4.trigger_out, v2, v4.amount_in) as u128) * ((10000 + 500) as u128), 116);
        };
        if (v4.kind != 3) {
            0x1::vector::borrow_mut<Leg>(&mut arg1.legs, v1).done = true;
        };
        arg1.filling = false;
        arg1.filled_in = arg1.filled_in + v2;
        arg1.filled_out = arg1.filled_out + v5 - v6;
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg3, v6, arg4), 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_recipient(arg2));
        };
        let v7 = if (arg1.fee_on_input) {
            v3
        } else {
            v6
        };
        let v8 = PlanFilled{
            plan_id      : v0,
            owner        : arg1.owner,
            filler       : 0x2::tx_context::sender(arg4),
            leg          : v1,
            amount_in    : v2,
            amount_out   : v5,
            fee          : v7,
            fee_on_input : arg1.fee_on_input,
            remaining    : 0x2::balance::value<T0>(&arg1.funds),
        };
        0x2::event::emit<PlanFilled>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg1.owner);
    }

    public fun is_keeper(arg0: &Keepers, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.list, &arg1)
    }

    public fun leg_done(arg0: &Leg) : bool {
        arg0.done
    }

    public fun leg_kind(arg0: &Leg) : u8 {
        arg0.kind
    }

    public fun legs<T0, T1>(arg0: &Plan<T0, T1>) : vector<Leg> {
        arg0.legs
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    public fun next_ms<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.next_ms
    }

    public fun owner<T0, T1>(arg0: &Plan<T0, T1>) : address {
        arg0.owner
    }

    public fun place<T0, T1>(arg0: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg1: 0x2::coin::Coin<T0>, arg2: vector<Leg>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::paused(arg0), 101);
        let v0 = 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_bps(arg0);
        assert!(v0 <= 100, 119);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 102);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg6 > v2 && arg6 - v2 <= 7776000000, 103);
        let v3 = 0x1::vector::length<Leg>(&arg2);
        assert!(v3 > 0 && v3 <= 8, 112);
        let v4 = 0;
        while (v4 < v3) {
            check_leg(0x1::vector::borrow<Leg>(&arg2, v4), v1, arg4 > 0);
            v4 = v4 + 1;
        };
        let v5 = if (arg4 > 0) {
            assert!(v3 == 1, 117);
            assert!(arg4 >= 300000 && arg4 <= 86400000, 117);
            let v6 = 0x1::vector::borrow<Leg>(&arg2, 0).amount_in;
            let v7 = v1 / v6;
            let v8 = if (v7 >= 2) {
                if (v7 <= 1000) {
                    v7 * v6 == v1
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v8, 117);
            assert!(arg5 < arg6, 117);
            if (arg5 > v2) {
                arg5
            } else {
                v2
            }
        } else {
            assert!(arg5 == 0, 117);
            0
        };
        let v9 = Plan<T0, T1>{
            id           : 0x2::object::new(arg8),
            owner        : 0x2::tx_context::sender(arg8),
            funds        : 0x2::coin::into_balance<T0>(arg1),
            total_in     : v1,
            legs         : arg2,
            fee_bps      : v0,
            fee_on_input : arg3,
            every_ms     : arg4,
            next_ms      : v5,
            filled_in    : 0,
            filled_out   : 0,
            created_ms   : v2,
            expiry_ms    : arg6,
            filling      : false,
        };
        let v10 = 0x2::object::id<Plan<T0, T1>>(&v9);
        let v11 = PlanPlaced{
            plan_id      : v10,
            owner        : v9.owner,
            coin_in      : 0x1::type_name::with_defining_ids<T0>(),
            coin_out     : 0x1::type_name::with_defining_ids<T1>(),
            total_in     : v1,
            legs         : v9.legs,
            fee_bps      : v0,
            fee_on_input : arg3,
            every_ms     : arg4,
            next_ms      : v5,
            expiry_ms    : arg6,
        };
        0x2::event::emit<PlanPlaced>(v11);
        0x2::transfer::share_object<Plan<T0, T1>>(v9);
        v10
    }

    public fun plan_fee_bps<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        arg0.fee_bps
    }

    public fun remaining<T0, T1>(arg0: &Plan<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun remove_keeper(arg0: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::AdminCap, arg1: &mut Keepers, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.list, &arg2);
        assert!(v0, 121);
        0x1::vector::remove<address>(&mut arg1.list, v1);
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
            done        : false,
        }
    }

    public fun take_leg(arg0: u64, arg1: u64) : Leg {
        Leg{
            kind        : 0,
            amount_in   : arg0,
            min_out     : arg1,
            trigger_out : 0,
            trail_bps   : 0,
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
            done        : false,
        }
    }

    // decompiled from Move bytecode v7
}

