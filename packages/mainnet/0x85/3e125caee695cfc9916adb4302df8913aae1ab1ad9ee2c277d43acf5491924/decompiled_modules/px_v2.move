module 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::px_v2 {
    struct PxPlan<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        pool: 0x2::object::ID,
        buy: bool,
        receipts: vector<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>,
        funds: 0x2::balance::Balance<T1>,
        total_in: u64,
        legs: vector<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>,
        fee_bps: u64,
        every_ms: u64,
        next_ms: u64,
        filled_in: u64,
        filled_out: u64,
        created_ms: u64,
        expiry_ms: u64,
        filling: bool,
    }

    struct PxReceipt<phantom T0, phantom T1> {
        plan_id: 0x2::object::ID,
        leg: u64,
        allowance: u64,
        before: u64,
        ids: vector<0x2::object::ID>,
        input_fee: u64,
    }

    struct PxPlanPlaced has copy, drop {
        plan_id: 0x2::object::ID,
        owner: address,
        pool: 0x2::object::ID,
        buy: bool,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        total_in: u64,
        legs: vector<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>,
        fee_bps: u64,
        fee_on_input: bool,
        every_ms: u64,
        next_ms: u64,
        expiry_ms: u64,
        receipts: vector<0x2::object::ID>,
    }

    struct PxPlanFilled has copy, drop {
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

    struct PxPlanClosed has copy, drop {
        plan_id: 0x2::object::ID,
        owner: address,
        refunded: u64,
        reason: u8,
    }

    fun begin<T0, T1>(arg0: &mut PxPlan<T0, T1>, arg1: u64, arg2: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Keepers, arg3: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg {
        assert!(!0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::paused(arg3), 301);
        assert!(0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::is_keeper(arg2, 0x2::tx_context::sender(arg5)), 311);
        assert!(!arg0.filling, 307);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg0.expiry_ms, 304);
        assert!(arg1 < 0x1::vector::length<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>(&arg0.legs), 312);
        let v1 = *0x1::vector::borrow<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>(&arg0.legs, arg1);
        assert!(!0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_done(&v1), 313);
        if (0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_is_dca(&v1)) {
            assert!(v0 >= arg0.next_ms, 315);
            arg0.next_ms = v0 + arg0.every_ms;
        };
        arg0.filling = true;
        v1
    }

    public fun begin_buy<T0, T1>(arg0: &mut PxPlan<T0, T1>, arg1: u64, arg2: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Keepers, arg3: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, PxReceipt<T0, T1>) {
        assert!(arg0.buy, 323);
        let v0 = begin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::balance::value<T1>(&arg0.funds);
        assert!(v1 > 0, 314);
        let v2 = 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_amount_in(&v0);
        let v3 = if (v2 < v1) {
            v2
        } else {
            v1
        };
        let v4 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.funds, v3), arg5);
        let v5 = 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_for(v3, arg0.fee_bps);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v4, v5, arg5), 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_recipient(arg3));
        };
        let v6 = PxReceipt<T0, T1>{
            plan_id   : 0x2::object::id<PxPlan<T0, T1>>(arg0),
            leg       : arg1,
            allowance : v3,
            before    : v1,
            ids       : 0x1::vector::empty<0x2::object::ID>(),
            input_fee : v5,
        };
        (v4, v6)
    }

    public fun begin_sell<T0, T1>(arg0: &mut PxPlan<T0, T1>, arg1: u64, arg2: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Keepers, arg3: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : PxReceipt<T0, T1> {
        assert!(!arg0.buy, 323);
        let v0 = begin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = tokens_of<T0>(&arg0.receipts);
        assert!(v1 > 0, 314);
        let v2 = 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_amount_in(&v0);
        let v3 = if (v2 < v1) {
            v2
        } else {
            v1
        };
        PxReceipt<T0, T1>{
            plan_id   : 0x2::object::id<PxPlan<T0, T1>>(arg0),
            leg       : arg1,
            allowance : v3,
            before    : v1,
            ids       : 0x1::vector::empty<0x2::object::ID>(),
            input_fee : 0,
        }
    }

    public fun cancel<T0, T1>(arg0: PxPlan<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 306);
        close<T0, T1>(arg0, 0, arg1);
    }

    fun check_common(arg0: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg1: u64, arg2: u64) : u64 {
        assert!(!0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::paused(arg0), 301);
        let v0 = 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_bps(arg0);
        assert!(v0 <= 100, 324);
        assert!(arg1 > arg2 && arg1 - arg2 <= 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::max_lifetime_ms(), 303);
        v0
    }

    fun close<T0, T1>(arg0: PxPlan<T0, T1>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.filling, 307);
        let PxPlan {
            id         : v0,
            owner      : v1,
            pool       : _,
            buy        : _,
            receipts   : v4,
            funds      : v5,
            total_in   : _,
            legs       : _,
            fee_bps    : _,
            every_ms   : _,
            next_ms    : _,
            filled_in  : _,
            filled_out : _,
            created_ms : _,
            expiry_ms  : _,
            filling    : _,
        } = arg0;
        let v16 = v5;
        let v17 = v4;
        let v18 = v0;
        while (!0x1::vector::is_empty<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&v17)) {
            0x2::transfer::public_transfer<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(0x1::vector::pop_back<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&mut v17), v1);
        };
        0x1::vector::destroy_empty<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(v17);
        if (0x2::balance::value<T1>(&v16) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg2), v1);
        } else {
            0x2::balance::destroy_zero<T1>(v16);
        };
        let v19 = PxPlanClosed{
            plan_id  : 0x2::object::uid_to_inner(&v18),
            owner    : v1,
            refunded : tokens_of<T0>(&v17) + 0x2::balance::value<T1>(&v16),
            reason   : arg1,
        };
        0x2::event::emit<PxPlanClosed>(v19);
        0x2::object::delete(v18);
    }

    fun emit_placed<T0, T1>(arg0: &PxPlan<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: bool, arg4: vector<0x2::object::ID>) {
        let v0 = PxPlanPlaced{
            plan_id      : 0x2::object::id<PxPlan<T0, T1>>(arg0),
            owner        : arg0.owner,
            pool         : arg0.pool,
            buy          : arg0.buy,
            coin_in      : arg1,
            coin_out     : arg2,
            total_in     : arg0.total_in,
            legs         : arg0.legs,
            fee_bps      : arg0.fee_bps,
            fee_on_input : arg3,
            every_ms     : arg0.every_ms,
            next_ms      : arg0.next_ms,
            expiry_ms    : arg0.expiry_ms,
            receipts     : arg4,
        };
        0x2::event::emit<PxPlanPlaced>(v0);
    }

    public fun expire_refund<T0, T1>(arg0: PxPlan<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms, 305);
        close<T0, T1>(arg0, 1, arg2);
    }

    public fun finish_buy<T0, T1>(arg0: PxReceipt<T0, T1>, arg1: &mut PxPlan<T0, T1>, arg2: 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let PxReceipt {
            plan_id   : v0,
            leg       : v1,
            allowance : v2,
            before    : _,
            ids       : _,
            input_fee : v5,
        } = arg0;
        assert!(v0 == 0x2::object::id<PxPlan<T0, T1>>(arg1), 309);
        assert!(arg1.filling, 308);
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(&arg2) == arg1.pool, 319);
        assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks::unlock_ms(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::lock<T0>(&arg2)) <= 0x2::clock::timestamp_ms(arg3), 322);
        let v6 = *0x1::vector::borrow<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>(&arg1.legs, v1);
        let v7 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(&arg2);
        assert!(v7 >= mul_div_up(0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_min_out(&v6), v2, 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_amount_in(&v6)), 310);
        if (!0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_is_dca(&v6)) {
            0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::set_leg_done(0x1::vector::borrow_mut<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>(&mut arg1.legs, v1));
        };
        arg1.filling = false;
        arg1.filled_in = arg1.filled_in + v2;
        arg1.filled_out = arg1.filled_out + v7;
        let v8 = PxPlanFilled{
            plan_id      : v0,
            owner        : arg1.owner,
            filler       : 0x2::tx_context::sender(arg4),
            leg          : v1,
            amount_in    : v2,
            amount_out   : v7,
            fee          : v5,
            fee_on_input : true,
            remaining    : 0x2::balance::value<T1>(&arg1.funds),
        };
        0x2::event::emit<PxPlanFilled>(v8);
        0x2::transfer::public_transfer<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg2, arg1.owner);
    }

    public fun finish_sell<T0, T1>(arg0: PxReceipt<T0, T1>, arg1: &mut PxPlan<T0, T1>, arg2: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg3: vector<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let PxReceipt {
            plan_id   : v0,
            leg       : v1,
            allowance : v2,
            before    : v3,
            ids       : v4,
            input_fee : _,
        } = arg0;
        let v6 = v4;
        assert!(v0 == 0x2::object::id<PxPlan<T0, T1>>(arg1), 309);
        assert!(arg1.filling, 308);
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg3)) {
            let v9 = 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(0x1::vector::borrow<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg3, v8));
            assert!(0x1::vector::contains<0x2::object::ID>(&v6, &v9) && !0x1::vector::contains<0x2::object::ID>(&v7, &v9), 320);
            0x1::vector::push_back<0x2::object::ID>(&mut v7, v9);
            v8 = v8 + 1;
        };
        let v10 = tokens_of<T0>(&arg1.receipts) + tokens_of<T0>(&arg3);
        assert!(v10 < v3, 302);
        let v11 = v3 - v10;
        assert!(v11 <= v2, 321);
        let v12 = *0x1::vector::borrow<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>(&arg1.legs, v1);
        let v13 = 0x2::coin::value<T1>(&arg4);
        let v14 = 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_for(v13, arg1.fee_bps);
        assert!(v13 - v14 >= mul_div_up(0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_min_out(&v12), v11, 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_amount_in(&v12)), 310);
        if (0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_is_stop(&v12)) {
            assert!((v13 as u128) * (10000 as u128) <= (mul_div_up(0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_trigger_out(&v12), v11, 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_amount_in(&v12)) as u128) * ((10000 + 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::stop_slack_bps()) as u128), 316);
        };
        if (!0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_is_dca(&v12)) {
            0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::set_leg_done(0x1::vector::borrow_mut<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>(&mut arg1.legs, v1));
        };
        while (!0x1::vector::is_empty<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg3)) {
            0x1::vector::push_back<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&mut arg1.receipts, 0x1::vector::pop_back<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&mut arg3));
        };
        0x1::vector::destroy_empty<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg3);
        arg1.filling = false;
        arg1.filled_in = arg1.filled_in + v11;
        arg1.filled_out = arg1.filled_out + v13 - v14;
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg4, v14, arg5), 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_recipient(arg2));
        };
        let v15 = PxPlanFilled{
            plan_id      : v0,
            owner        : arg1.owner,
            filler       : 0x2::tx_context::sender(arg5),
            leg          : v1,
            amount_in    : v11,
            amount_out   : v13,
            fee          : v14,
            fee_on_input : false,
            remaining    : v10,
        };
        0x2::event::emit<PxPlanFilled>(v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, arg1.owner);
    }

    public fun is_buy<T0, T1>(arg0: &PxPlan<T0, T1>) : bool {
        arg0.buy
    }

    public fun legs<T0, T1>(arg0: &PxPlan<T0, T1>) : vector<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg> {
        arg0.legs
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    public fun owner<T0, T1>(arg0: &PxPlan<T0, T1>) : address {
        arg0.owner
    }

    public fun place_buy<T0, T1>(arg0: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: vector<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 302);
        0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::check_legs(&arg3, v1, arg4 > 0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>(&arg3)) {
            let v3 = 0x1::vector::borrow<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>(&arg3, v2);
            assert!(!0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_is_stop(v3) && 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_trigger_out(v3) == 0, 323);
            v2 = v2 + 1;
        };
        let v4 = PxPlan<T0, T1>{
            id         : 0x2::object::new(arg8),
            owner      : 0x2::tx_context::sender(arg8),
            pool       : arg1,
            buy        : true,
            receipts   : 0x1::vector::empty<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(),
            funds      : 0x2::coin::into_balance<T1>(arg2),
            total_in   : v1,
            legs       : arg3,
            fee_bps    : check_common(arg0, arg6, v0),
            every_ms   : arg4,
            next_ms    : schedule(&arg3, v1, arg4, arg5, v0, arg6, true),
            filled_in  : 0,
            filled_out : 0,
            created_ms : v0,
            expiry_ms  : arg6,
            filling    : false,
        };
        emit_placed<T0, T1>(&v4, 0x1::type_name::with_defining_ids<T1>(), 0x1::type_name::with_defining_ids<T0>(), true, 0x1::vector::empty<0x2::object::ID>());
        0x2::transfer::share_object<PxPlan<T0, T1>>(v4);
        0x2::object::id<PxPlan<T0, T1>>(&v4)
    }

    public fun place_sell<T0, T1>(arg0: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg1: vector<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>, arg2: vector<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x1::vector::length<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg1);
        assert!(v1 > 0, 302);
        assert!(v1 <= 32, 325);
        let v2 = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(0x1::vector::borrow<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg1, 0));
        let v3 = 0;
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        let v5 = 0;
        while (v5 < v1) {
            let v6 = 0x1::vector::borrow<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg1, v5);
            assert!(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::pool_id<T0>(v6) == v2, 319);
            v3 = v3 + 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(v6);
            0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(v6));
            v5 = v5 + 1;
        };
        assert!(v3 > 0, 302);
        0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::check_legs(&arg2, v3, arg3 > 0);
        let v7 = PxPlan<T0, T1>{
            id         : 0x2::object::new(arg7),
            owner      : 0x2::tx_context::sender(arg7),
            pool       : v2,
            buy        : false,
            receipts   : arg1,
            funds      : 0x2::balance::zero<T1>(),
            total_in   : v3,
            legs       : arg2,
            fee_bps    : check_common(arg0, arg5, v0),
            every_ms   : arg3,
            next_ms    : schedule(&arg2, v3, arg3, arg4, v0, arg5, false),
            filled_in  : 0,
            filled_out : 0,
            created_ms : v0,
            expiry_ms  : arg5,
            filling    : false,
        };
        emit_placed<T0, T1>(&v7, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), false, v4);
        0x2::transfer::share_object<PxPlan<T0, T1>>(v7);
        0x2::object::id<PxPlan<T0, T1>>(&v7)
    }

    public fun pool<T0, T1>(arg0: &PxPlan<T0, T1>) : 0x2::object::ID {
        arg0.pool
    }

    public fun receipt_count<T0, T1>(arg0: &PxPlan<T0, T1>) : u64 {
        0x1::vector::length<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg0.receipts)
    }

    public fun receipt_ids<T0, T1>(arg0: &PxPlan<T0, T1>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg0.receipts)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(0x1::vector::borrow<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg0.receipts, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun remaining<T0, T1>(arg0: &PxPlan<T0, T1>) : u64 {
        if (arg0.buy) {
            0x2::balance::value<T1>(&arg0.funds)
        } else {
            tokens_of<T0>(&arg0.receipts)
        }
    }

    fun schedule(arg0: &vector<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : u64 {
        if (arg2 == 0) {
            assert!(arg3 == 0, 317);
            return 0
        };
        0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::check_every(arg2);
        assert!(0x1::vector::length<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>(arg0) == 1, 317);
        let v0 = 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::leg_amount_in(0x1::vector::borrow<0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::orders::Leg>(arg0, 0));
        let v1 = (arg1 + v0 - 1) / v0;
        assert!(v1 >= 2 && v1 <= 1000, 317);
        if (arg6) {
            assert!(v1 * v0 == arg1, 317);
        };
        assert!(arg3 < arg5, 317);
        if (arg3 > arg4) {
            arg3
        } else {
            arg4
        }
    }

    public fun settle<T0, T1>(arg0: PxPlan<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::is_empty<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg0.receipts) && 0x2::balance::value<T1>(&arg0.funds) == 0, 318);
        close<T0, T1>(arg0, 2, arg1);
    }

    public fun take<T0, T1>(arg0: &mut PxPlan<T0, T1>, arg1: &mut PxReceipt<T0, T1>, arg2: 0x2::object::ID) : 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0> {
        assert!(arg1.plan_id == 0x2::object::id<PxPlan<T0, T1>>(arg0), 309);
        assert!(arg0.filling, 308);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg0.receipts)) {
            if (0x2::object::id<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(0x1::vector::borrow<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&arg0.receipts, v0)) == arg2) {
                0x1::vector::push_back<0x2::object::ID>(&mut arg1.ids, arg2);
                return 0x1::vector::swap_remove<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(&mut arg0.receipts, v0)
            };
            v0 = v0 + 1;
        };
        abort 320
    }

    fun tokens_of<T0>(arg0: &vector<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg0)) {
            v0 = v0 + 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::amount<T0>(0x1::vector::borrow<0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::position::Position<T0>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

