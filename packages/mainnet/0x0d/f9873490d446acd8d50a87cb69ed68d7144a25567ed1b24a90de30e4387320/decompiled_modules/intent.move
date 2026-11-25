module 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::intent {
    struct Hold<phantom T0> has store {
        seller_id: 0x2::object::ID,
        payout: address,
        amount: u64,
        kind: u8,
        state: u8,
        ref_hash: vector<u8>,
        result_hash: vector<u8>,
        accept_by_ms: u64,
        funds: 0x2::balance::Balance<T0>,
        external: 0x1::option::Option<External>,
    }

    struct External has copy, drop, store {
        adapter: 0x1::type_name::TypeName,
        challenge_id: vector<u8>,
        expires_at_ms: u64,
    }

    struct ExternalPayout<phantom T0> {
        index: u64,
        seller_id: 0x2::object::ID,
        recipient: address,
        external: External,
        funds: 0x2::balance::Balance<T0>,
    }

    struct ExternalPayouts<phantom T0> {
        intent_id: 0x2::object::ID,
        payouts: vector<ExternalPayout<T0>>,
    }

    struct Intent<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        policy_id: 0x2::object::ID,
        approved: bool,
        owner: address,
        agent: address,
        budget: u64,
        mode: u8,
        deadline_ms: u64,
        reject_window_ms: u64,
        status: u8,
        held: u64,
        paid: u64,
        holds: vector<Hold<T0>>,
    }

    struct Planned has copy, drop, store {
        seller_id: 0x2::object::ID,
        amount: u64,
    }

    struct PlanKey has copy, drop, store {
        dummy_field: bool,
    }

    struct IntentOpened has copy, drop {
        intent_id: 0x2::object::ID,
        agent: address,
        budget: u64,
        mode: u8,
        deadline_ms: u64,
        awaiting_approval: bool,
    }

    struct IntentApproved has copy, drop {
        intent_id: 0x2::object::ID,
    }

    struct PlanApproved has copy, drop {
        intent_id: 0x2::object::ID,
        seller_ids: vector<0x2::object::ID>,
        amounts: vector<u64>,
    }

    struct HoldPlaced has copy, drop {
        intent_id: 0x2::object::ID,
        index: u64,
        seller_id: 0x2::object::ID,
        amount: u64,
        kind: u8,
    }

    struct HoldReady has copy, drop {
        intent_id: 0x2::object::ID,
        index: u64,
    }

    struct HoldDeclined has copy, drop {
        intent_id: 0x2::object::ID,
        index: u64,
    }

    struct HoldSubmitted has copy, drop {
        intent_id: 0x2::object::ID,
        index: u64,
        accept_by_ms: u64,
    }

    struct HoldRejected has copy, drop {
        intent_id: 0x2::object::ID,
        index: u64,
    }

    struct HoldPaid has copy, drop {
        intent_id: 0x2::object::ID,
        index: u64,
        seller_id: 0x2::object::ID,
        payout: address,
        amount: u64,
    }

    struct IntentCommitted has copy, drop {
        intent_id: 0x2::object::ID,
        paid: u64,
        returned: u64,
    }

    struct HoldOutcome has copy, drop, store {
        index: u64,
        seller_id: 0x2::object::ID,
        paid: u64,
        returned: u64,
    }

    struct IntentAborted has copy, drop {
        intent_id: 0x2::object::ID,
        returned: u64,
        paid: u64,
        outcomes: vector<HoldOutcome>,
    }

    struct IntentExpired has copy, drop {
        intent_id: 0x2::object::ID,
        returned: u64,
        paid: u64,
        outcomes: vector<HoldOutcome>,
    }

    struct Draw<phantom T0> {
        intent_id: 0x2::object::ID,
        funds: 0x2::balance::Balance<T0>,
    }

    public fun accept<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        abort 63
    }

    public fun accept_with_policy<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert_open<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.agent, 29);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg2) == arg0.policy_id, 31);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::assert_can_spend(arg2, 0x2::tx_context::sender(arg4));
        let v0 = 0x1::vector::borrow_mut<Hold<T0>>(&mut arg0.holds, arg3);
        assert!(v0.state == 3, 25);
        v0.state = 1;
        let v1 = HoldReady{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            index     : arg3,
        };
        0x2::event::emit<HoldReady>(v1);
    }

    public fun approve<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg2) == arg0.policy_id, 31);
        assert!(0x2::tx_context::sender(arg4) == 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::owner(arg2), 35);
        assert!(arg0.status == 0, 25);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.deadline_ms, 27);
        arg0.status = 1;
        arg0.approved = true;
        let v0 = IntentApproved{intent_id: 0x2::object::id<Intent<T0>>(arg0)};
        0x2::event::emit<IntentApproved>(v0);
    }

    public fun approve_with_plan<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4) && v0 <= 100, 55);
        let v1 = 0x1::vector::empty<Planned>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg4, v3);
            assert!(v4 > 0, 33);
            v2 = v2 + v4;
            let v5 = Planned{
                seller_id : *0x1::vector::borrow<0x2::object::ID>(&arg3, v3),
                amount    : v4,
            };
            0x1::vector::push_back<Planned>(&mut v1, v5);
            v3 = v3 + 1;
        };
        assert!(v2 <= arg0.budget, 23);
        approve<T0>(arg0, arg1, arg2, arg5, arg6);
        if (v0 > 0) {
            let v6 = PlanKey{dummy_field: false};
            0x2::dynamic_field::add<PlanKey, vector<Planned>>(&mut arg0.id, v6, v1);
            let v7 = PlanApproved{
                intent_id  : 0x2::object::id<Intent<T0>>(arg0),
                seller_ids : arg3,
                amounts    : arg4,
            };
            0x2::event::emit<PlanApproved>(v7);
        };
    }

    public fun approved<T0>(arg0: &Intent<T0>) : bool {
        arg0.approved
    }

    public fun assert_final<T0>(arg0: &Intent<T0>) {
        assert!(is_final<T0>(arg0), 34);
    }

    fun assert_open<T0>(arg0: &Intent<T0>) {
        assert!(arg0.status == 1, 22);
    }

    public fun budget<T0>(arg0: &Intent<T0>) : u64 {
        arg0.budget
    }

    public fun cancel<T0>(arg0: &mut Intent<T0>, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.agent || 0x2::tx_context::sender(arg3) == arg0.owner, 29);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg1) == arg0.policy_id, 31);
        let (v0, v1, v2) = end_all<T0>(arg0, arg2);
        let v3 = v2;
        settle(0x2::object::id<Intent<T0>>(arg0), arg1, &v3, v0, v1, arg2);
        arg0.paid = v1;
        arg0.status = 3;
        let v4 = IntentAborted{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            returned  : v0,
            paid      : v1,
            outcomes  : v3,
        };
        0x2::event::emit<IntentAborted>(v4);
    }

    public fun commit<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: &0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = do_commit<T0>(arg0, arg2, arg3, arg4, arg5);
        assert!(0x1::vector::is_empty<ExternalPayout<T0>>(&v0), 38);
        0x1::vector::destroy_empty<ExternalPayout<T0>>(v0);
    }

    public fun commit_with_external<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: &0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : ExternalPayouts<T0> {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = do_commit<T0>(arg0, arg2, arg3, arg4, arg5);
        0x1::vector::reverse<ExternalPayout<T0>>(&mut v0);
        ExternalPayouts<T0>{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            payouts   : v0,
        }
    }

    public fun confirm<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::SellerCap, arg3: u64, arg4: &0x2::clock::Clock) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert_open<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.deadline_ms, 27);
        let v0 = 0x1::vector::borrow_mut<Hold<T0>>(&mut arg0.holds, arg3);
        assert!(v0.seller_id == 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::cap_seller_id(arg2), 24);
        assert!(v0.kind == 0, 21);
        assert!(v0.state == 0, 25);
        v0.state = 1;
        let v1 = HoldReady{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            index     : arg3,
        };
        0x2::event::emit<HoldReady>(v1);
    }

    fun consume_plan<T0>(arg0: &mut Intent<T0>, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PlanKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PlanKey>(&arg0.id, v0)) {
            return
        } else {
            let v1 = PlanKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<PlanKey, vector<Planned>>(&mut arg0.id, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<Planned>(v2)) {
                let v4 = 0x1::vector::borrow<Planned>(v2, v3);
                if (v4.seller_id == arg1 && v4.amount == arg2) {
                    0x1::vector::swap_remove<Planned>(v2, v3);
                    return
                };
                v3 = v3 + 1;
            };
            abort 54
        };
    }

    public fun deadline_ms<T0>(arg0: &Intent<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun decline<T0>(arg0: &mut Intent<T0>, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::SellerCap, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_open<T0>(arg0);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg1) == arg0.policy_id, 31);
        let v0 = 0x1::vector::borrow_mut<Hold<T0>>(&mut arg0.holds, arg3);
        assert!(v0.seller_id == 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::cap_seller_id(arg2), 24);
        assert!(v0.state == 0, 25);
        v0.state = 2;
        let v1 = 0x2::balance::value<T0>(&v0.funds);
        0x2::balance::send_funds<T0>(0x2::balance::withdraw_all<T0>(&mut v0.funds), arg0.owner);
        settle_one(0x2::object::id<Intent<T0>>(arg0), arg1, arg3, v1, arg4);
        arg0.held = arg0.held - v1;
        let v2 = HoldDeclined{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            index     : arg3,
        };
        0x2::event::emit<HoldDeclined>(v2);
    }

    public fun deny<T0>(arg0: &mut Intent<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 35);
        assert!(arg0.status == 0, 25);
        arg0.status = 3;
        let v0 = IntentAborted{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            returned  : 0,
            paid      : 0,
            outcomes  : 0x1::vector::empty<HoldOutcome>(),
        };
        0x2::event::emit<IntentAborted>(v0);
    }

    fun do_commit<T0>(arg0: &mut Intent<T0>, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: &0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : vector<ExternalPayout<T0>> {
        assert_open<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.agent, 29);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg1) == arg0.policy_id, 31);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::assert_can_spend(arg1, 0x2::tx_context::sender(arg4));
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::assert_allowance<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::allowance::expiration_timestamp_ms(0x2::allowance::allowance_settings<0x2::balance::Balance<T0>>(arg2));
        if (0x1::option::is_some<u64>(&v1)) {
            assert!(v0 < 0x1::option::destroy_some<u64>(v1), 36);
        } else {
            0x1::option::destroy_none<u64>(v1);
        };
        assert!(v0 < arg0.deadline_ms, 27);
        let v2 = 0x1::vector::length<Hold<T0>>(&arg0.holds);
        if (arg0.mode == 0) {
            assert!(v2 > 0, 26);
            assert!(plan_left<T0>(arg0) == 0, 56);
            let v3 = 0;
            while (v3 < v2) {
                assert!(is_ready<T0>(0x1::vector::borrow<Hold<T0>>(&arg0.holds, v3), v0), 26);
                v3 = v3 + 1;
            };
        };
        let v4 = 0x2::object::id<Intent<T0>>(arg0);
        let v5 = 0x2::balance::zero<T0>();
        let v6 = 0;
        let v7 = 0x1::vector::empty<ExternalPayout<T0>>();
        let v8 = 0x1::vector::empty<HoldOutcome>();
        let v9 = 0;
        while (v9 < v2) {
            let v10 = 0x1::vector::borrow_mut<Hold<T0>>(&mut arg0.holds, v9);
            assert!(v10.state != 3 || v0 >= v10.accept_by_ms, 61);
            if (is_ready<T0>(v10, v0)) {
                let v11 = 0x2::balance::value<T0>(&v10.funds);
                v6 = v6 + v11;
                v10.state = 5;
                if (0x1::option::is_some<External>(&v10.external)) {
                    let v12 = ExternalPayout<T0>{
                        index     : v9,
                        seller_id : v10.seller_id,
                        recipient : v10.payout,
                        external  : *0x1::option::borrow<External>(&v10.external),
                        funds     : 0x2::balance::withdraw_all<T0>(&mut v10.funds),
                    };
                    0x1::vector::push_back<ExternalPayout<T0>>(&mut v7, v12);
                } else {
                    0x2::balance::send_funds<T0>(0x2::balance::withdraw_all<T0>(&mut v10.funds), v10.payout);
                    let v13 = HoldPaid{
                        intent_id : v4,
                        index     : v9,
                        seller_id : v10.seller_id,
                        payout    : v10.payout,
                        amount    : v11,
                    };
                    0x2::event::emit<HoldPaid>(v13);
                };
            } else if (v10.state == 0) {
                v10.state = 6;
                let v14 = HoldOutcome{
                    index     : v9,
                    seller_id : v10.seller_id,
                    paid      : 0,
                    returned  : 0x2::balance::value<T0>(&v10.funds),
                };
                0x1::vector::push_back<HoldOutcome>(&mut v8, v14);
                0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(&mut v10.funds));
            };
            v9 = v9 + 1;
        };
        let v15 = 0x2::balance::value<T0>(&v5);
        send_or_destroy<T0>(v5, arg0.owner);
        settle(v4, arg1, &v8, v15, v6, arg3);
        arg0.paid = v6;
        arg0.status = 2;
        let v16 = IntentCommitted{
            intent_id : v4,
            paid      : v6,
            returned  : v15,
        };
        0x2::event::emit<IntentCommitted>(v16);
        v7
    }

    public fun draw<T0>(arg0: &Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : Draw<T0> {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        Draw<T0>{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            funds     : spend<T0>(arg0, arg2, arg3, arg4, arg5, arg6),
        }
    }

    fun end_all<T0>(arg0: &mut Intent<T0>, arg1: &0x2::clock::Clock) : (u64, u64, vector<HoldOutcome>) {
        assert!(arg0.status == 1 || arg0.status == 0, 22);
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = 0x1::vector::empty<HoldOutcome>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<Hold<T0>>(&arg0.holds)) {
            let v4 = 0x1::vector::borrow_mut<Hold<T0>>(&mut arg0.holds, v3);
            if (v4.kind == 1 && (v4.state == 1 || v4.state == 3)) {
                assert!(v4.state == 1 || 0x2::clock::timestamp_ms(arg1) >= v4.accept_by_ms, 61);
                let v5 = 0x2::balance::value<T0>(&v4.funds);
                v1 = v1 + v5;
                v4.state = 5;
                0x2::balance::send_funds<T0>(0x2::balance::withdraw_all<T0>(&mut v4.funds), v4.payout);
                let v6 = HoldPaid{
                    intent_id : 0x2::object::id<Intent<T0>>(arg0),
                    index     : v3,
                    seller_id : v4.seller_id,
                    payout    : v4.payout,
                    amount    : v5,
                };
                0x2::event::emit<HoldPaid>(v6);
                let v7 = HoldOutcome{
                    index     : v3,
                    seller_id : v4.seller_id,
                    paid      : v5,
                    returned  : 0,
                };
                0x1::vector::push_back<HoldOutcome>(&mut v2, v7);
            } else {
                let v8 = if (v4.state == 0) {
                    true
                } else if (v4.state == 1) {
                    true
                } else {
                    v4.state == 3
                };
                if (v8) {
                    v4.state = 6;
                    let v9 = HoldOutcome{
                        index     : v3,
                        seller_id : v4.seller_id,
                        paid      : 0,
                        returned  : 0x2::balance::value<T0>(&v4.funds),
                    };
                    0x1::vector::push_back<HoldOutcome>(&mut v2, v9);
                    0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut v4.funds));
                };
            };
            v3 = v3 + 1;
        };
        send_or_destroy<T0>(v0, arg0.owner);
        (0x2::balance::value<T0>(&v0), v1, v2)
    }

    public fun expire<T0>(arg0: &mut Intent<T0>, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.deadline_ms, 28);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg1) == arg0.policy_id, 31);
        let (v0, v1, v2) = end_all<T0>(arg0, arg2);
        let v3 = v2;
        settle(0x2::object::id<Intent<T0>>(arg0), arg1, &v3, v0, v1, arg2);
        arg0.paid = v1;
        arg0.status = 4;
        let v4 = IntentExpired{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            returned  : v0,
            paid      : v1,
            outcomes  : v3,
        };
        0x2::event::emit<IntentExpired>(v4);
    }

    fun external_terms(arg0: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller, arg1: vector<u8>, arg2: u64) : External {
        let v0 = 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::adapter(arg0);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&v0), 39);
        let v1 = 0x1::vector::length<u8>(&arg1);
        assert!(v1 > 0 && v1 <= 128, 45);
        External{
            adapter       : 0x1::option::destroy_some<0x1::type_name::TypeName>(v0),
            challenge_id  : arg1,
            expires_at_ms : arg2,
        }
    }

    public fun finish_draw<T0>(arg0: Draw<T0>) {
        let Draw {
            intent_id : _,
            funds     : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x2::balance::value<T0>(&v2) == 0, 47);
        0x2::balance::destroy_zero<T0>(v2);
    }

    public fun finish_external<T0>(arg0: ExternalPayouts<T0>) {
        let ExternalPayouts {
            intent_id : _,
            payouts   : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x1::vector::is_empty<ExternalPayout<T0>>(&v2), 44);
        0x1::vector::destroy_empty<ExternalPayout<T0>>(v2);
    }

    public fun has_plan<T0>(arg0: &Intent<T0>) : bool {
        let v0 = PlanKey{dummy_field: false};
        0x2::dynamic_field::exists<PlanKey>(&arg0.id, v0)
    }

    public fun held<T0>(arg0: &Intent<T0>) : u64 {
        arg0.held
    }

    public fun hold<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller, arg6: u8, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : u64 {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::adapter(arg5);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&v0), 38);
        assert!(arg6 == 0 || arg6 == 1, 21);
        let v1 = spend<T0>(arg0, arg2, arg3, arg4, arg8, arg9);
        place<T0>(arg0, arg2, v1, arg5, arg6, 0, arg7, 0x1::option::none<External>(), arg8, arg9)
    }

    public fun hold_count<T0>(arg0: &Intent<T0>) : u64 {
        0x1::vector::length<Hold<T0>>(&arg0.holds)
    }

    public fun hold_external<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : u64 {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = spend<T0>(arg0, arg2, arg3, arg4, arg8, arg9);
        place<T0>(arg0, arg2, v0, arg5, 0, 1, arg6, 0x1::option::some<External>(external_terms(arg5, arg6, arg7)), arg8, arg9)
    }

    public fun hold_external_from<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: &mut Draw<T0>, arg4: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : u64 {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(arg3.intent_id == 0x2::object::id<Intent<T0>>(arg0), 46);
        place<T0>(arg0, arg2, 0x2::balance::split<T0>(&mut arg3.funds, arg5), arg4, 0, 1, arg6, 0x1::option::some<External>(external_terms(arg4, arg6, arg7)), arg8, arg9)
    }

    public fun hold_from<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: &mut Draw<T0>, arg4: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller, arg5: u64, arg6: u8, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : u64 {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(arg3.intent_id == 0x2::object::id<Intent<T0>>(arg0), 46);
        let v0 = 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::adapter(arg4);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&v0), 38);
        assert!(arg6 == 0 || arg6 == 1, 21);
        place<T0>(arg0, arg2, 0x2::balance::split<T0>(&mut arg3.funds, arg5), arg4, arg6, 0, arg7, 0x1::option::none<External>(), arg8, arg9)
    }

    public fun hold_state<T0>(arg0: &Intent<T0>, arg1: u64) : u8 {
        0x1::vector::borrow<Hold<T0>>(&arg0.holds, arg1).state
    }

    public fun is_final<T0>(arg0: &Intent<T0>) : bool {
        arg0.status >= 2
    }

    fun is_ready<T0>(arg0: &Hold<T0>, arg1: u64) : bool {
        arg0.state == 1 || arg0.state == 3 && arg1 >= arg0.accept_by_ms
    }

    public fun open<T0>(arg0: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Intent<T0> {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(arg3 == 0 || arg3 == 1, 20);
        assert!(arg2 > 0, 33);
        assert!(arg5 <= 604800000, 62);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::assert_can_spend(arg0, 0x2::tx_context::sender(arg7));
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::assert_coin<T0>(arg0);
        let v0 = 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::needs_approval(arg0, arg2, arg6);
        let v1 = if (v0) {
            0
        } else {
            1
        };
        let v2 = Intent<T0>{
            id               : 0x2::object::new(arg7),
            version          : 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::current(),
            policy_id        : 0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg0),
            approved         : false,
            owner            : 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::owner(arg0),
            agent            : 0x2::tx_context::sender(arg7),
            budget           : arg2,
            mode             : arg3,
            deadline_ms      : 0x2::clock::timestamp_ms(arg6) + arg4,
            reject_window_ms : arg5,
            status           : v1,
            held             : 0,
            paid             : 0,
            holds            : 0x1::vector::empty<Hold<T0>>(),
        };
        let v3 = IntentOpened{
            intent_id         : 0x2::object::id<Intent<T0>>(&v2),
            agent             : v2.agent,
            budget            : arg2,
            mode              : arg3,
            deadline_ms       : v2.deadline_ms,
            awaiting_approval : v0,
        };
        0x2::event::emit<IntentOpened>(v3);
        v2
    }

    public fun paid<T0>(arg0: &Intent<T0>) : u64 {
        arg0.paid
    }

    public fun payouts_left<T0>(arg0: &ExternalPayouts<T0>) : u64 {
        0x1::vector::length<ExternalPayout<T0>>(&arg0.payouts)
    }

    fun place<T0>(arg0: &mut Intent<T0>, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: 0x2::balance::Balance<T0>, arg3: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller, arg4: u8, arg5: u8, arg6: vector<u8>, arg7: 0x1::option::Option<External>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : u64 {
        assert_open<T0>(arg0);
        assert!(0x2::tx_context::sender(arg9) == arg0.agent, 29);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg1) == arg0.policy_id, 31);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::assert_can_spend(arg1, 0x2::tx_context::sender(arg9));
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::assert_seller_allowed(arg1, 0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller>(arg3));
        assert!(0x2::clock::timestamp_ms(arg8) < arg0.deadline_ms, 27);
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 33);
        assert!(0x1::vector::length<Hold<T0>>(&arg0.holds) < 256, 65);
        assert!(0x1::vector::length<u8>(&arg6) <= 64, 66);
        assert!(arg0.reject_window_ms <= 604800000, 62);
        assert!(arg0.held + v0 <= arg0.budget, 23);
        if (arg0.approved) {
            consume_plan<T0>(arg0, 0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller>(arg3), v0);
        };
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::reserve(arg1, v0, arg8);
        if (!arg0.approved) {
            0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::record_unapproved(arg1, 0x2::object::id<Intent<T0>>(arg0), 0x1::vector::length<Hold<T0>>(&arg0.holds), v0, arg8);
        };
        arg0.held = arg0.held + v0;
        let v1 = 0x1::vector::length<Hold<T0>>(&arg0.holds);
        let v2 = 0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller>(arg3);
        let v3 = Hold<T0>{
            seller_id    : v2,
            payout       : 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::payout(arg3),
            amount       : v0,
            kind         : arg4,
            state        : arg5,
            ref_hash     : arg6,
            result_hash  : b"",
            accept_by_ms : 0,
            funds        : arg2,
            external     : arg7,
        };
        0x1::vector::push_back<Hold<T0>>(&mut arg0.holds, v3);
        let v4 = HoldPlaced{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            index     : v1,
            seller_id : v2,
            amount    : v0,
            kind      : arg4,
        };
        0x2::event::emit<HoldPlaced>(v4);
        if (arg5 == 1) {
            let v5 = HoldReady{
                intent_id : 0x2::object::id<Intent<T0>>(arg0),
                index     : v1,
            };
            0x2::event::emit<HoldReady>(v5);
        };
        v1
    }

    public fun plan_left<T0>(arg0: &Intent<T0>) : u64 {
        if (!has_plan<T0>(arg0)) {
            return 0
        };
        let v0 = PlanKey{dummy_field: false};
        0x1::vector::length<Planned>(0x2::dynamic_field::borrow<PlanKey, vector<Planned>>(&arg0.id, v0))
    }

    public fun reject<T0>(arg0: &mut Intent<T0>, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_open<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.agent || 0x2::tx_context::sender(arg4) == arg0.owner, 29);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg1) == arg0.policy_id, 31);
        let v0 = 0x1::vector::borrow_mut<Hold<T0>>(&mut arg0.holds, arg2);
        assert!(v0.state == 3, 25);
        assert!(0x2::clock::timestamp_ms(arg3) < v0.accept_by_ms, 27);
        v0.state = 4;
        let v1 = 0x2::balance::value<T0>(&v0.funds);
        0x2::balance::send_funds<T0>(0x2::balance::withdraw_all<T0>(&mut v0.funds), arg0.owner);
        settle_one(0x2::object::id<Intent<T0>>(arg0), arg1, arg2, v1, arg3);
        arg0.held = arg0.held - v1;
        let v2 = HoldRejected{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            index     : arg2,
        };
        0x2::event::emit<HoldRejected>(v2);
    }

    public fun release_external<T0, T1: drop>(arg0: &mut ExternalPayouts<T0>, arg1: T1, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, address, vector<u8>, u64, u64) {
        abort 63
    }

    public fun release_external_with_permit<T0, T1>(arg0: &mut ExternalPayouts<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: 0x1::internal::Permit<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, address, vector<u8>, u64, u64) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let ExternalPayout {
            index     : v0,
            seller_id : v1,
            recipient : v2,
            external  : v3,
            funds     : v4,
        } = 0x1::vector::pop_back<ExternalPayout<T0>>(&mut arg0.payouts);
        let v5 = v4;
        let v6 = v3;
        assert!(v6.adapter == 0x1::type_name::with_defining_ids<T1>(), 43);
        let v7 = 0x2::balance::value<T0>(&v5);
        let v8 = HoldPaid{
            intent_id : arg0.intent_id,
            index     : v0,
            seller_id : v1,
            payout    : v2,
            amount    : v7,
        };
        0x2::event::emit<HoldPaid>(v8);
        (0x2::coin::from_balance<T0>(v5, arg3), v2, v6.challenge_id, v7, v6.expires_at_ms)
    }

    fun send_or_destroy<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, arg1);
        };
    }

    fun settle(arg0: 0x2::object::ID, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: &vector<HoldOutcome>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::settle(arg1, arg3, arg4, arg5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<HoldOutcome>(arg2)) {
            let v1 = 0x1::vector::borrow<HoldOutcome>(arg2, v0);
            if (v1.returned > 0) {
                0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::release_unapproved(arg1, arg0, v1.index, v1.returned, arg5);
            };
            v0 = v0 + 1;
        };
    }

    fun settle_one(arg0: 0x2::object::ID, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::settle(arg1, arg3, 0, arg4);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::release_unapproved(arg1, arg0, arg2, arg3, arg4);
    }

    public fun share<T0>(arg0: Intent<T0>) {
        0x2::transfer::share_object<Intent<T0>>(arg0);
    }

    fun spend<T0>(arg0: &Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_open<T0>(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg0.agent, 29);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg1) == arg0.policy_id, 31);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::assert_can_spend(arg1, 0x2::tx_context::sender(arg5));
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::assert_allowance<T0>(arg1, arg2);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.deadline_ms, 27);
        0x2::allowance::app_balance_spend<T0, 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg2, 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::spend_permit(), arg3, arg4, arg5)
    }

    public fun status<T0>(arg0: &Intent<T0>) : u8 {
        arg0.status
    }

    public fun submit<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::SellerCap, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert_open<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 < arg0.deadline_ms, 27);
        let v1 = 0x1::vector::borrow_mut<Hold<T0>>(&mut arg0.holds, arg3);
        assert!(v1.seller_id == 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::cap_seller_id(arg2), 24);
        assert!(v1.kind == 1, 21);
        assert!(v1.state == 0, 25);
        assert!(0x1::vector::length<u8>(&arg4) <= 64, 66);
        let v2 = v0 + arg0.reject_window_ms;
        v1.state = 3;
        v1.result_hash = arg4;
        v1.accept_by_ms = v2;
        let v3 = HoldSubmitted{
            intent_id    : 0x2::object::id<Intent<T0>>(arg0),
            index        : arg3,
            accept_by_ms : v2,
        };
        0x2::event::emit<HoldSubmitted>(v3);
    }

    // decompiled from Move bytecode v7
}

