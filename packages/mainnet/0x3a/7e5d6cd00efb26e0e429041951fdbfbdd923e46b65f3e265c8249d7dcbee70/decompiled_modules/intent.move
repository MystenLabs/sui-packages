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

    struct PlannedItem has copy, drop, store {
        seller_id: 0x2::object::ID,
        amount: u64,
        ref_hash: vector<u8>,
    }

    struct PlanItemsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BoundItem has copy, drop, store {
        seller_id: 0x2::object::ID,
        amount: u64,
        ref_hash: vector<u8>,
        payout: address,
    }

    struct PlanBoundKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BoundItemsApproved has copy, drop {
        intent_id: 0x2::object::ID,
        seller_ids: vector<0x2::object::ID>,
        amounts: vector<u64>,
        ref_hashes: vector<vector<u8>>,
        payouts: vector<address>,
    }

    struct DueItem has copy, drop, store {
        seller_id: 0x2::object::ID,
        amount: u64,
        ref_hash: vector<u8>,
        payout: address,
        due_at_ms: u64,
    }

    struct PlanDueKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LongKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LongRecord has copy, drop, store {
        due: 0x2::vec_map::VecMap<u64, u64>,
        open: u64,
        paid: u64,
    }

    struct DueItemsApproved has copy, drop {
        intent_id: 0x2::object::ID,
        seller_ids: vector<0x2::object::ID>,
        amounts: vector<u64>,
        ref_hashes: vector<vector<u8>>,
        payouts: vector<address>,
        due_at_ms: vector<u64>,
    }

    struct ItemsApproved has copy, drop {
        intent_id: 0x2::object::ID,
        seller_ids: vector<0x2::object::ID>,
        amounts: vector<u64>,
        ref_hashes: vector<vector<u8>>,
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

    struct RefundedKey has copy, drop, store {
        seller_id: 0x2::object::ID,
    }

    struct Refunded has copy, drop {
        intent_id: 0x2::object::ID,
        seller_id: 0x2::object::ID,
        amount: u64,
        total_refunded: u64,
        owner: address,
        paid_to: address,
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

    public fun approve_with_items<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg3);
        let v1 = if (v0 > 0) {
            if (v0 == 0x1::vector::length<u64>(&arg4)) {
                if (v0 == 0x1::vector::length<vector<u8>>(&arg5)) {
                    v0 <= 100
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 55);
        let v2 = 0x1::vector::empty<PlannedItem>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<u64>(&arg4, v4);
            assert!(v5 > 0, 33);
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg5, v4)) <= 64, 66);
            v3 = v3 + v5;
            let v6 = PlannedItem{
                seller_id : *0x1::vector::borrow<0x2::object::ID>(&arg3, v4),
                amount    : v5,
                ref_hash  : *0x1::vector::borrow<vector<u8>>(&arg5, v4),
            };
            0x1::vector::push_back<PlannedItem>(&mut v2, v6);
            v4 = v4 + 1;
        };
        assert!(v3 <= arg0.budget, 23);
        approve<T0>(arg0, arg1, arg2, arg6, arg7);
        let v7 = PlanItemsKey{dummy_field: false};
        0x2::dynamic_field::add<PlanItemsKey, vector<PlannedItem>>(&mut arg0.id, v7, v2);
        let v8 = ItemsApproved{
            intent_id  : 0x2::object::id<Intent<T0>>(arg0),
            seller_ids : arg3,
            amounts    : arg4,
            ref_hashes : arg5,
        };
        0x2::event::emit<ItemsApproved>(v8);
    }

    public fun approve_with_items_bound<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: vector<vector<u8>>, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg3);
        let v1 = if (v0 > 0) {
            if (v0 == 0x1::vector::length<u64>(&arg4)) {
                if (v0 == 0x1::vector::length<vector<u8>>(&arg5)) {
                    if (v0 == 0x1::vector::length<address>(&arg6)) {
                        v0 <= 100
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 55);
        let v2 = 0x1::vector::empty<BoundItem>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<u64>(&arg4, v4);
            assert!(v5 > 0, 33);
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg5, v4)) <= 64, 66);
            v3 = v3 + v5;
            let v6 = BoundItem{
                seller_id : *0x1::vector::borrow<0x2::object::ID>(&arg3, v4),
                amount    : v5,
                ref_hash  : *0x1::vector::borrow<vector<u8>>(&arg5, v4),
                payout    : *0x1::vector::borrow<address>(&arg6, v4),
            };
            0x1::vector::push_back<BoundItem>(&mut v2, v6);
            v4 = v4 + 1;
        };
        assert!(v3 <= arg0.budget, 23);
        approve<T0>(arg0, arg1, arg2, arg7, arg8);
        let v7 = PlanBoundKey{dummy_field: false};
        0x2::dynamic_field::add<PlanBoundKey, vector<BoundItem>>(&mut arg0.id, v7, v2);
        let v8 = BoundItemsApproved{
            intent_id  : 0x2::object::id<Intent<T0>>(arg0),
            seller_ids : arg3,
            amounts    : arg4,
            ref_hashes : arg5,
            payouts    : arg6,
        };
        0x2::event::emit<BoundItemsApproved>(v8);
    }

    public fun approve_with_items_due<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: vector<vector<u8>>, arg6: vector<address>, arg7: vector<u64>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg3);
        let v1 = if (v0 > 0) {
            if (v0 == 0x1::vector::length<u64>(&arg4)) {
                if (v0 == 0x1::vector::length<vector<u8>>(&arg5)) {
                    if (v0 == 0x1::vector::length<address>(&arg6)) {
                        if (v0 == 0x1::vector::length<u64>(&arg7)) {
                            v0 <= 100
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 55);
        let v2 = 0x2::clock::timestamp_ms(arg8);
        let v3 = 0x1::vector::empty<DueItem>();
        let v4 = 0;
        let v5 = 0;
        let v6 = v5;
        let v7 = 0;
        while (v7 < v0) {
            let v8 = *0x1::vector::borrow<u64>(&arg4, v7);
            assert!(v8 > 0, 33);
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg5, v7)) <= 64, 66);
            let v9 = *0x1::vector::borrow<u64>(&arg7, v7);
            assert!(v9 > v2 && v9 <= v2 + 15552000000, 81);
            assert!(v9 == *0x1::vector::borrow<u64>(&arg7, 0), 85);
            if (v9 > v5) {
                v6 = v9;
            };
            v4 = v4 + v8;
            let v10 = DueItem{
                seller_id : *0x1::vector::borrow<0x2::object::ID>(&arg3, v7),
                amount    : v8,
                ref_hash  : *0x1::vector::borrow<vector<u8>>(&arg5, v7),
                payout    : *0x1::vector::borrow<address>(&arg6, v7),
                due_at_ms : v9,
            };
            0x1::vector::push_back<DueItem>(&mut v3, v10);
            v7 = v7 + 1;
        };
        assert!(v4 <= arg0.budget, 23);
        approve<T0>(arg0, arg1, arg2, arg8, arg9);
        let v11 = v6 + 259200000;
        if (v11 > arg0.deadline_ms) {
            arg0.deadline_ms = v11;
        };
        let v12 = PlanDueKey{dummy_field: false};
        0x2::dynamic_field::add<PlanDueKey, vector<DueItem>>(&mut arg0.id, v12, v3);
        let v13 = DueItemsApproved{
            intent_id  : 0x2::object::id<Intent<T0>>(arg0),
            seller_ids : arg3,
            amounts    : arg4,
            ref_hashes : arg5,
            payouts    : arg6,
            due_at_ms  : arg7,
        };
        0x2::event::emit<DueItemsApproved>(v13);
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
        settle<T0>(arg0, arg1, &v3, v0, v1, arg2);
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

    public fun cancel_capped<T0>(arg0: &mut Intent<T0>, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.agent || 0x2::tx_context::sender(arg4) == arg0.owner, 29);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg1) == arg0.policy_id, 31);
        let (v0, v1, v2) = end_all<T0>(arg0, arg3);
        let v3 = v2;
        assert!(v1 <= arg2, 73);
        settle<T0>(arg0, arg1, &v3, v0, v1, arg3);
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

    fun consume_plan<T0>(arg0: &mut Intent<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &vector<u8>) : (0x1::option::Option<address>, 0x1::option::Option<u64>) {
        let v0 = PlanDueKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PlanDueKey>(&arg0.id, v0)) {
            let v1 = PlanDueKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<PlanDueKey, vector<DueItem>>(&mut arg0.id, v1);
            let v3 = 0;
            let v4;
            while (v3 < 0x1::vector::length<DueItem>(v2)) {
                let v5 = 0x1::vector::borrow<DueItem>(v2, v3);
                let v6 = if (v5.seller_id == arg1) {
                    if (v5.amount == arg2) {
                        &v5.ref_hash == arg3
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v6) {
                    v4 = 0x1::option::some<u64>(v3);
                    /* label 14 */
                    assert!(0x1::option::is_some<u64>(&v4), 54);
                    let v7 = 0x1::vector::swap_remove<DueItem>(v2, 0x1::option::destroy_some<u64>(v4));
                    return (0x1::option::some<address>(v7.payout), 0x1::option::some<u64>(v7.due_at_ms))
                };
                v3 = v3 + 1;
            };
            v4 = 0x1::option::none<u64>();
            /* goto 14 */
        } else {
            let v8 = PlanBoundKey{dummy_field: false};
            if (0x2::dynamic_field::exists<PlanBoundKey>(&arg0.id, v8)) {
                let v9 = PlanBoundKey{dummy_field: false};
                let v10 = 0x2::dynamic_field::borrow_mut<PlanBoundKey, vector<BoundItem>>(&mut arg0.id, v9);
                let v11 = 0;
                let v12;
                while (v11 < 0x1::vector::length<BoundItem>(v10)) {
                    let v13 = 0x1::vector::borrow<BoundItem>(v10, v11);
                    let v14 = if (v13.seller_id == arg1) {
                        if (v13.amount == arg2) {
                            &v13.ref_hash == arg3
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v14) {
                        v12 = 0x1::option::some<u64>(v11);
                        /* label 34 */
                        assert!(0x1::option::is_some<u64>(&v12), 54);
                        let v15 = 0x1::vector::swap_remove<BoundItem>(v10, 0x1::option::destroy_some<u64>(v12));
                        return (0x1::option::some<address>(v15.payout), 0x1::option::none<u64>())
                    };
                    v11 = v11 + 1;
                };
                v12 = 0x1::option::none<u64>();
                /* goto 34 */
            } else {
                let v16 = PlanItemsKey{dummy_field: false};
                if (0x2::dynamic_field::exists<PlanItemsKey>(&arg0.id, v16)) {
                    let v17 = PlanItemsKey{dummy_field: false};
                    let v18 = 0x2::dynamic_field::borrow_mut<PlanItemsKey, vector<PlannedItem>>(&mut arg0.id, v17);
                    let v19 = 0;
                    let v20;
                    while (v19 < 0x1::vector::length<PlannedItem>(v18)) {
                        let v21 = 0x1::vector::borrow<PlannedItem>(v18, v19);
                        let v22 = if (v21.seller_id == arg1) {
                            if (v21.amount == arg2) {
                                &v21.ref_hash == arg3
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v22) {
                            v20 = 0x1::option::some<u64>(v19);
                            /* label 55 */
                            assert!(0x1::option::is_some<u64>(&v20), 54);
                            0x1::vector::swap_remove<PlannedItem>(v18, 0x1::option::destroy_some<u64>(v20));
                            return (0x1::option::none<address>(), 0x1::option::none<u64>())
                        };
                        v19 = v19 + 1;
                    };
                    v20 = 0x1::option::none<u64>();
                    /* goto 55 */
                } else {
                    let v23 = PlanKey{dummy_field: false};
                    if (!0x2::dynamic_field::exists<PlanKey>(&arg0.id, v23)) {
                        return (0x1::option::none<address>(), 0x1::option::none<u64>())
                    } else {
                        let v24 = PlanKey{dummy_field: false};
                        let v25 = 0x2::dynamic_field::borrow_mut<PlanKey, vector<Planned>>(&mut arg0.id, v24);
                        let v26 = 0;
                        while (v26 < 0x1::vector::length<Planned>(v25)) {
                            let v27 = 0x1::vector::borrow<Planned>(v25, v26);
                            if (v27.seller_id == arg1 && v27.amount == arg2) {
                                0x1::vector::swap_remove<Planned>(v25, v26);
                                return (0x1::option::none<address>(), 0x1::option::none<u64>())
                            };
                            v26 = v26 + 1;
                        };
                        abort 54
                    };
                };
            };
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
        settle_one<T0>(arg0, arg1, v0.seller_id, arg3, v1, arg4);
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
        pay_out<T0>(arg0, arg1, arg2, arg3)
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
        settle<T0>(arg0, arg1, &v3, v0, v1, arg2);
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
        if (0x2::dynamic_field::exists<PlanKey>(&arg0.id, v0)) {
            true
        } else {
            let v2 = PlanItemsKey{dummy_field: false};
            if (0x2::dynamic_field::exists<PlanItemsKey>(&arg0.id, v2)) {
                true
            } else {
                let v3 = PlanBoundKey{dummy_field: false};
                if (0x2::dynamic_field::exists<PlanBoundKey>(&arg0.id, v3)) {
                    true
                } else {
                    let v4 = PlanDueKey{dummy_field: false};
                    0x2::dynamic_field::exists<PlanDueKey>(&arg0.id, v4)
                }
            }
        }
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

    fun long_due<T0>(arg0: &Intent<T0>) : 0x2::vec_map::VecMap<u64, u64> {
        let v0 = LongKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LongKey>(&arg0.id, v0)) {
            let v2 = LongKey{dummy_field: false};
            0x2::dynamic_field::borrow<LongKey, LongRecord>(&arg0.id, v2).due
        } else {
            0x2::vec_map::empty<u64, u64>()
        }
    }

    fun long_settled<T0>(arg0: &mut Intent<T0>) : (u64, u64) {
        let v0 = LongKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LongKey>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = LongKey{dummy_field: false};
        let v2 = *0x2::dynamic_field::borrow<LongKey, LongRecord>(&arg0.id, v1);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x2::vec_map::keys<u64, u64>(&v2.due);
        0x1::vector::reverse<u64>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v5)) {
            let v7 = 0x1::vector::borrow<Hold<T0>>(&arg0.holds, 0x1::vector::pop_back<u64>(&mut v5));
            let v8 = if (v7.state == 0) {
                true
            } else if (v7.state == 1) {
                true
            } else {
                v7.state == 3
            };
            if (v8) {
                v4 = v4 + v7.amount;
            } else if (v7.state == 5) {
                v3 = v3 + v7.amount;
            };
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<u64>(v5);
        let v9 = v3 - v2.paid;
        let v10 = LongKey{dummy_field: false};
        let v11 = 0x2::dynamic_field::borrow_mut<LongKey, LongRecord>(&mut arg0.id, v10);
        v11.open = v4;
        v11.paid = v3;
        (v2.open - v4 - v9, v9)
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

    public fun pay_due<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg3: &0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: &0x2::clock::Clock) {
        assert_open<T0>(arg0);
        assert!(0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy>(arg2) == arg0.policy_id, 31);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(!0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::revoked(arg2), 87);
        let v0 = long_due<T0>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Hold<T0>>(&arg0.holds)) {
            let v3 = 0x1::vector::borrow<Hold<T0>>(&arg0.holds, v2);
            let v4 = if (v3.state == 0) {
                true
            } else if (v3.state == 1) {
                true
            } else {
                v3.state == 3
            };
            if (v4) {
                assert!(0x2::vec_map::contains<u64, u64>(&v0, &v2), 86);
                assert!(v3.state == 1, 26);
                assert!(0x2::clock::timestamp_ms(arg4) >= *0x2::vec_map::get<u64, u64>(&v0, &v2), 82);
                assert!(0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::is_seller_allowed(arg2, v3.seller_id), 88);
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 86);
        let v5 = pay_out<T0>(arg0, arg2, arg3, arg4);
        assert!(0x1::vector::is_empty<ExternalPayout<T0>>(&v5), 38);
        0x1::vector::destroy_empty<ExternalPayout<T0>>(v5);
    }

    fun pay_out<T0>(arg0: &mut Intent<T0>, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: &0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: &0x2::clock::Clock) : vector<ExternalPayout<T0>> {
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
        let v5 = long_due<T0>(arg0);
        let v6 = 0x2::balance::zero<T0>();
        let v7 = 0;
        let v8 = 0x1::vector::empty<ExternalPayout<T0>>();
        let v9 = 0x1::vector::empty<HoldOutcome>();
        let v10 = 0;
        while (v10 < v2) {
            let v11 = 0x1::vector::borrow_mut<Hold<T0>>(&mut arg0.holds, v10);
            assert!(v11.state != 3 || v0 >= v11.accept_by_ms, 61);
            if (is_ready<T0>(v11, v0)) {
                if (0x2::vec_map::contains<u64, u64>(&v5, &v10)) {
                    assert!(v0 >= *0x2::vec_map::get<u64, u64>(&v5, &v10), 82);
                };
                let v12 = 0x2::balance::value<T0>(&v11.funds);
                v7 = v7 + v12;
                v11.state = 5;
                if (0x1::option::is_some<External>(&v11.external)) {
                    let v13 = ExternalPayout<T0>{
                        index     : v10,
                        seller_id : v11.seller_id,
                        recipient : v11.payout,
                        external  : *0x1::option::borrow<External>(&v11.external),
                        funds     : 0x2::balance::withdraw_all<T0>(&mut v11.funds),
                    };
                    0x1::vector::push_back<ExternalPayout<T0>>(&mut v8, v13);
                } else {
                    0x2::balance::send_funds<T0>(0x2::balance::withdraw_all<T0>(&mut v11.funds), v11.payout);
                    let v14 = HoldPaid{
                        intent_id : v4,
                        index     : v10,
                        seller_id : v11.seller_id,
                        payout    : v11.payout,
                        amount    : v12,
                    };
                    0x2::event::emit<HoldPaid>(v14);
                };
            } else if (v11.state == 0) {
                v11.state = 6;
                let v15 = HoldOutcome{
                    index     : v10,
                    seller_id : v11.seller_id,
                    paid      : 0,
                    returned  : 0x2::balance::value<T0>(&v11.funds),
                };
                0x1::vector::push_back<HoldOutcome>(&mut v9, v15);
                0x2::balance::join<T0>(&mut v6, 0x2::balance::withdraw_all<T0>(&mut v11.funds));
            };
            v10 = v10 + 1;
        };
        let v16 = 0x2::balance::value<T0>(&v6);
        send_or_destroy<T0>(v6, arg0.owner);
        settle<T0>(arg0, arg1, &v9, v16, v7, arg3);
        arg0.paid = v7;
        arg0.status = 2;
        let v17 = IntentCommitted{
            intent_id : v4,
            paid      : v7,
            returned  : v16,
        };
        0x2::event::emit<IntentCommitted>(v17);
        v8
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
        let v1 = 0x1::option::none<u64>();
        if (arg0.approved) {
            let (v2, v3) = consume_plan<T0>(arg0, 0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller>(arg3), v0, &arg6);
            let v4 = v2;
            if (0x1::option::is_some<address>(&v4)) {
                assert!(0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::payout(arg3) == 0x1::option::destroy_some<address>(v4), 72);
            };
            v1 = v3;
        };
        if (0x1::option::is_some<u64>(&v1)) {
            assert!(arg4 == 0, 83);
        };
        if (0x1::option::is_some<u64>(&v1)) {
            0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::reserve_long(arg1, v0);
        } else {
            0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::reserve(arg1, v0, arg8);
        };
        if (!arg0.approved) {
            0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::record_unapproved(arg1, 0x2::object::id<Intent<T0>>(arg0), 0x1::vector::length<Hold<T0>>(&arg0.holds), v0, arg8);
        };
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::use_seller(arg1, 0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller>(arg3), 0x2::object::id<Intent<T0>>(arg0), 0x1::vector::length<Hold<T0>>(&arg0.holds), v0, arg8);
        arg0.held = arg0.held + v0;
        let v5 = 0x1::vector::length<Hold<T0>>(&arg0.holds);
        let v6 = 0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller>(arg3);
        let v7 = Hold<T0>{
            seller_id    : v6,
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
        0x1::vector::push_back<Hold<T0>>(&mut arg0.holds, v7);
        if (0x1::option::is_some<u64>(&v1)) {
            let v8 = LongKey{dummy_field: false};
            if (!0x2::dynamic_field::exists<LongKey>(&arg0.id, v8)) {
                let v9 = LongKey{dummy_field: false};
                let v10 = LongRecord{
                    due  : 0x2::vec_map::empty<u64, u64>(),
                    open : 0,
                    paid : 0,
                };
                0x2::dynamic_field::add<LongKey, LongRecord>(&mut arg0.id, v9, v10);
            };
            let v11 = LongKey{dummy_field: false};
            let v12 = 0x2::dynamic_field::borrow_mut<LongKey, LongRecord>(&mut arg0.id, v11);
            0x2::vec_map::insert<u64, u64>(&mut v12.due, v5, 0x1::option::destroy_some<u64>(v1));
            v12.open = v12.open + v0;
        };
        let v13 = HoldPlaced{
            intent_id : 0x2::object::id<Intent<T0>>(arg0),
            index     : v5,
            seller_id : v6,
            amount    : v0,
            kind      : arg4,
        };
        0x2::event::emit<HoldPlaced>(v13);
        if (arg5 == 1) {
            let v14 = HoldReady{
                intent_id : 0x2::object::id<Intent<T0>>(arg0),
                index     : v5,
            };
            0x2::event::emit<HoldReady>(v14);
        };
        v5
    }

    public fun plan_left<T0>(arg0: &Intent<T0>) : u64 {
        let v0 = PlanDueKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PlanDueKey>(&arg0.id, v0)) {
            let v1 = PlanDueKey{dummy_field: false};
            return 0x1::vector::length<DueItem>(0x2::dynamic_field::borrow<PlanDueKey, vector<DueItem>>(&arg0.id, v1))
        };
        let v2 = PlanBoundKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PlanBoundKey>(&arg0.id, v2)) {
            let v3 = PlanBoundKey{dummy_field: false};
            return 0x1::vector::length<BoundItem>(0x2::dynamic_field::borrow<PlanBoundKey, vector<BoundItem>>(&arg0.id, v3))
        };
        let v4 = PlanItemsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PlanItemsKey>(&arg0.id, v4)) {
            let v5 = PlanItemsKey{dummy_field: false};
            return 0x1::vector::length<PlannedItem>(0x2::dynamic_field::borrow<PlanItemsKey, vector<PlannedItem>>(&arg0.id, v5))
        };
        let v6 = PlanKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PlanKey>(&arg0.id, v6)) {
            return 0
        };
        let v7 = PlanKey{dummy_field: false};
        0x1::vector::length<Planned>(0x2::dynamic_field::borrow<PlanKey, vector<Planned>>(&arg0.id, v7))
    }

    public fun refunded<T0>(arg0: &Intent<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = RefundedKey{seller_id: arg1};
        if (0x2::dynamic_field::exists<RefundedKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<RefundedKey, u64>(&arg0.id, v0)
        } else {
            0
        }
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
        settle_one<T0>(arg0, arg1, v0.seller_id, arg2, v1, arg3);
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

    public fun release_external_with_refund<T0, T1>(arg0: &mut ExternalPayouts<T0>, arg1: &Intent<T0>, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg3: 0x1::internal::Permit<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, address, vector<u8>, u64, u64, address) {
        assert!(arg0.intent_id == 0x2::object::id<Intent<T0>>(arg1), 71);
        let (v0, v1, v2, v3, v4) = release_external_with_permit<T0, T1>(arg0, arg2, arg3, arg4);
        (v0, v1, v2, v3, v4, arg1.owner)
    }

    public fun seller_refund<T0>(arg0: &mut Intent<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(0x2::tx_context::sender(arg4) == 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::payout(arg2), 84);
        assert!(is_final<T0>(arg0), 34);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 33);
        let v1 = 0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::Seller>(arg2);
        let v2 = 0;
        let v3 = &arg0.holds;
        let v4 = 0;
        while (v4 < 0x1::vector::length<Hold<T0>>(v3)) {
            let v5 = 0x1::vector::borrow<Hold<T0>>(v3, v4);
            if (v5.seller_id == v1 && v5.state == 5) {
                v2 = v2 + v5.amount;
            };
            v4 = v4 + 1;
        };
        assert!(v2 > 0, 76);
        let v6 = RefundedKey{seller_id: v1};
        let v7 = if (0x2::dynamic_field::exists<RefundedKey>(&arg0.id, v6)) {
            *0x2::dynamic_field::borrow<RefundedKey, u64>(&arg0.id, v6)
        } else {
            0
        };
        let v8 = v7 + v0;
        assert!(v8 <= v2, 77);
        if (v7 == 0) {
            0x2::dynamic_field::add<RefundedKey, u64>(&mut arg0.id, v6, v8);
        } else {
            *0x2::dynamic_field::borrow_mut<RefundedKey, u64>(&mut arg0.id, v6) = v8;
        };
        let v9 = arg0.owner;
        let v10 = 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::successor::successor_of(arg1, v9);
        0x2::balance::send_funds<T0>(0x2::coin::into_balance<T0>(arg3), v10);
        let v11 = Refunded{
            intent_id      : 0x2::object::id<Intent<T0>>(arg0),
            seller_id      : v1,
            amount         : v0,
            total_refunded : v8,
            owner          : v9,
            paid_to        : v10,
        };
        0x2::event::emit<Refunded>(v11);
    }

    fun send_or_destroy<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, arg1);
        };
    }

    fun settle<T0>(arg0: &mut Intent<T0>, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: &vector<HoldOutcome>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<Intent<T0>>(arg0);
        let (v1, v2) = long_settled<T0>(arg0);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::settle(arg1, arg3 - v1, arg4 - v2, arg5);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::settle_long(arg1, v1 + v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<HoldOutcome>(arg2)) {
            let v4 = 0x1::vector::borrow<HoldOutcome>(arg2, v3);
            if (v4.returned > 0) {
                0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::release_unapproved(arg1, v0, v4.index, v4.returned, arg5);
                0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::release_seller(arg1, v4.seller_id, v0, v4.index, v4.returned);
            };
            v3 = v3 + 1;
        };
    }

    fun settle_one<T0>(arg0: &mut Intent<T0>, arg1: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::Policy, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<Intent<T0>>(arg0);
        let (v1, _) = long_settled<T0>(arg0);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::settle(arg1, arg4 - v1, 0, arg5);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::settle_long(arg1, v1);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::release_unapproved(arg1, v0, arg3, arg4, arg5);
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy::release_seller(arg1, arg2, v0, arg3, arg4);
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

