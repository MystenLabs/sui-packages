module 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::jitter_position {
    struct PyLeg has drop, store {
        pt_balance: u64,
        yt_balance: u64,
        yt_reward_guard: u64,
        index: u128,
        py_index: u128,
        accrued: u128,
    }

    struct LpLeg has drop, store {
        pool_id: 0x2::object::ID,
        lp_amount: u64,
        lp_reward_guard: u64,
    }

    struct JitterPosition has key {
        id: 0x2::object::UID,
        market_state_id: 0x2::object::ID,
        expiry: u64,
        created_at: u64,
        py: PyLeg,
        lp: LpLeg,
    }

    struct PositionCreatedEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        expiry: u64,
        owner: address,
    }

    struct PositionTransferredEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        recipient: address,
        pt_balance: u64,
        yt_balance: u64,
        lp_amount: u64,
        accrued: u128,
    }

    struct PositionDestroyedEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
    }

    struct PositionAccruedMergedEvent has copy, drop {
        market_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        amount: u128,
        destination_accrued: u128,
    }

    struct PositionTransferLockUpdatedEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        locked: bool,
    }

    struct LpRewardGateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ScopedTransferLockKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
        pos1: 0x2::object::ID,
    }

    struct TransferLockCountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LpRewardMutation {
        position_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
    }

    public fun destroy_empty(arg0: JitterPosition, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        assert!(!transfer_locked(&arg0), 1906);
        assert!(arg0.py.accrued == 0, 506);
        assert!(arg0.py.pt_balance == 0 && arg0.py.yt_balance == 0, 500);
        assert!(is_lp_empty(&arg0), 1900);
        destroy(arg0);
    }

    public fun id(arg0: &JitterPosition) : 0x2::object::ID {
        0x2::object::id<JitterPosition>(arg0)
    }

    public fun accrued(arg0: &JitterPosition) : u128 {
        arg0.py.accrued
    }

    public(friend) fun add_lp(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        arg0.lp.lp_amount = arg0.lp.lp_amount + arg1;
        arg0.lp.lp_reward_guard = arg0.lp.lp_reward_guard + 1;
    }

    public(friend) fun add_pt(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        arg0.py.pt_balance = arg0.py.pt_balance + arg1;
    }

    public fun add_scoped_transfer_lock<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut JitterPosition, arg2: 0x2::object::ID, arg3: T0) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg0);
        let v0 = ScopedTransferLockKey{
            pos0 : 0x1::type_name::with_defining_ids<T0>(),
            pos1 : arg2,
        };
        assert!(!0x2::dynamic_field::exists<ScopedTransferLockKey>(&arg1.id, v0), 1907);
        0x2::dynamic_field::add<ScopedTransferLockKey, bool>(&mut arg1.id, v0, true);
        increment_transfer_lock_count(arg1);
        let v1 = PositionTransferLockUpdatedEvent{
            position_id : 0x2::object::id<JitterPosition>(arg1),
            market_id   : arg1.market_state_id,
            source_id   : arg2,
            witness     : 0x1::type_name::with_defining_ids<T0>(),
            locked      : true,
        };
        0x2::event::emit<PositionTransferLockUpdatedEvent>(v1);
    }

    public(friend) fun add_yt(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        arg0.py.yt_balance = arg0.py.yt_balance + arg1;
        arg0.py.yt_reward_guard = arg0.py.yt_reward_guard + 1;
    }

    public fun assert_market_state_match(arg0: &JitterPosition, arg1: 0x2::object::ID) {
        assert!(arg0.market_state_id == arg1, 502);
    }

    public fun assert_pool_match(arg0: &JitterPosition, arg1: 0x2::object::ID) {
        assert!(arg0.lp.pool_id == arg1, 1901);
    }

    public(friend) fun assert_reward_mutation_allowed(arg0: &JitterPosition, arg1: 0x2::object::ID) {
        assert!(reward_gate_open(arg0), 1903);
        let v0 = LpRewardGateKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<LpRewardGateKey, 0x2::object::ID>(&arg0.id, v0) == arg1, 1905);
    }

    public(friend) fun begin_reward_mutation(arg0: &mut JitterPosition, arg1: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement, arg2: 0x2::object::ID, arg3: address) : LpRewardMutation {
        assert!(!reward_gate_open(arg0), 1904);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_scope(&arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope());
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_market_matches(&arg1, market_state_id(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_subject(&arg1, 0x2::object::id<JitterPosition>(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_owner(&arg1, arg3);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_previous_exposure(&arg1, lp_amount(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_guard(&arg1, lp_reward_guard(arg0));
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::consume_lp_settlement(arg1, arg2, 0x2::object::id<JitterPosition>(arg0), arg3);
        let v1 = LpRewardGateKey{dummy_field: false};
        0x2::dynamic_field::add<LpRewardGateKey, 0x2::object::ID>(&mut arg0.id, v1, v0);
        LpRewardMutation{
            position_id    : 0x2::object::id<JitterPosition>(arg0),
            distributor_id : v0,
        }
    }

    public(friend) fun bind_pool_if_empty(arg0: &mut JitterPosition, arg1: 0x2::object::ID) {
        if (arg0.lp.pool_id == none_id()) {
            assert!(arg0.lp.lp_amount == 0, 1901);
            arg0.lp.pool_id = arg1;
        };
    }

    public(friend) fun consume_lp_transfer(arg0: &mut JitterPosition, arg1: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement, arg2: 0x2::object::ID, arg3: address, arg4: address) {
        assert!(!reward_gate_open(arg0), 1904);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_scope(&arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::lp_scope());
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_market_matches(&arg1, market_state_id(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_subject(&arg1, 0x2::object::id<JitterPosition>(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_owner(&arg1, arg3);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_transfer_to(&arg1, arg4);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_previous_exposure(&arg1, lp_amount(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_guard(&arg1, lp_reward_guard(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::consume_lp_transfer_settlement(arg1, arg2, 0x2::object::id<JitterPosition>(arg0), arg3, arg4);
        arg0.lp.lp_reward_guard = arg0.lp.lp_reward_guard + 1;
    }

    public(friend) fun consume_yt_transfer(arg0: &mut JitterPosition, arg1: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::RewardSettlement, arg2: 0x2::object::ID, arg3: address, arg4: address) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_scope(&arg1, 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::yt_scope());
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_market_matches(&arg1, market_state_id(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_subject(&arg1, 0x2::object::id<JitterPosition>(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_owner(&arg1, arg3);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_transfer_to(&arg1, arg4);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_previous_exposure(&arg1, yt_balance(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::assert_settlement_guard(&arg1, yt_reward_guard(arg0));
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor::consume_yt_transfer_settlement(arg1, arg2, 0x2::object::id<JitterPosition>(arg0), arg3, arg4);
        arg0.py.yt_reward_guard = arg0.py.yt_reward_guard + 1;
    }

    public fun created_at(arg0: &JitterPosition) : u64 {
        arg0.created_at
    }

    fun decrement_transfer_lock_count(arg0: &mut JitterPosition) {
        let v0 = TransferLockCountKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<TransferLockCountKey>(&arg0.id, v0), 1908);
        let v1 = *0x2::dynamic_field::borrow<TransferLockCountKey, u64>(&arg0.id, v0);
        assert!(v1 > 0, 1908);
        if (v1 == 1) {
            0x2::dynamic_field::remove<TransferLockCountKey, u64>(&mut arg0.id, v0);
        } else {
            *0x2::dynamic_field::borrow_mut<TransferLockCountKey, u64>(&mut arg0.id, v0) = v1 - 1;
        };
    }

    fun destroy(arg0: JitterPosition) {
        assert!(!transfer_locked(&arg0), 1906);
        let v0 = PositionDestroyedEvent{
            position_id : 0x2::object::id<JitterPosition>(&arg0),
            market_id   : arg0.market_state_id,
        };
        0x2::event::emit<PositionDestroyedEvent>(v0);
        let JitterPosition {
            id              : v1,
            market_state_id : _,
            expiry          : _,
            created_at      : _,
            py              : _,
            lp              : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public(friend) fun end_reward_mutation(arg0: &mut JitterPosition, arg1: LpRewardMutation) {
        let LpRewardMutation {
            position_id    : v0,
            distributor_id : v1,
        } = arg1;
        assert!(v0 == 0x2::object::id<JitterPosition>(arg0), 1901);
        assert!(reward_gate_open(arg0), 1903);
        let v2 = LpRewardGateKey{dummy_field: false};
        assert!(0x2::dynamic_field::remove<LpRewardGateKey, 0x2::object::ID>(&mut arg0.id, v2) == v1, 1905);
    }

    public fun expiry(arg0: &JitterPosition) : u64 {
        arg0.expiry
    }

    public fun has_scoped_transfer_lock<T0: drop>(arg0: &JitterPosition, arg1: 0x2::object::ID) : bool {
        let v0 = ScopedTransferLockKey{
            pos0 : 0x1::type_name::with_defining_ids<T0>(),
            pos1 : arg1,
        };
        0x2::dynamic_field::exists<ScopedTransferLockKey>(&arg0.id, v0)
    }

    fun increment_transfer_lock_count(arg0: &mut JitterPosition) {
        let v0 = TransferLockCountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<TransferLockCountKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<TransferLockCountKey, u64>(&mut arg0.id, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::dynamic_field::add<TransferLockCountKey, u64>(&mut arg0.id, v0, 1);
        };
    }

    public fun index(arg0: &JitterPosition) : u128 {
        arg0.py.index
    }

    public fun is_lp_empty(arg0: &JitterPosition) : bool {
        arg0.lp.lp_amount == 0
    }

    public fun is_py_empty(arg0: &JitterPosition) : bool {
        if (arg0.py.pt_balance == 0) {
            if (arg0.py.yt_balance == 0) {
                arg0.py.accrued == 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun lp_amount(arg0: &JitterPosition) : u64 {
        arg0.lp.lp_amount
    }

    public fun lp_reward_guard(arg0: &JitterPosition) : u64 {
        arg0.lp.lp_reward_guard
    }

    public fun market_state_id(arg0: &JitterPosition) : 0x2::object::ID {
        arg0.market_state_id
    }

    public fun merge_accrued(arg0: &mut JitterPosition, arg1: &mut JitterPosition, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg2);
        assert!(arg0.market_state_id == arg1.market_state_id, 502);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_target_active(arg2, b"market", arg0.market_state_id, 3623);
        assert!(!transfer_locked(arg0) && !transfer_locked(arg1), 1906);
        assert!(arg0.py.yt_balance == 0, 501);
        let v0 = arg0.py.accrued;
        arg1.py.accrued = arg1.py.accrued + v0;
        arg0.py.accrued = 0;
        let v1 = PositionAccruedMergedEvent{
            market_id               : arg0.market_state_id,
            source_position_id      : 0x2::object::id<JitterPosition>(arg0),
            destination_position_id : 0x2::object::id<JitterPosition>(arg1),
            amount                  : v0,
            destination_accrued     : arg1.py.accrued,
        };
        0x2::event::emit<PositionAccruedMergedEvent>(v1);
    }

    public(friend) fun mint_market_state(arg0: 0x2::object::ID, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : JitterPosition {
        let v0 = PyLeg{
            pt_balance      : 0,
            yt_balance      : 0,
            yt_reward_guard : 0,
            index           : 0,
            py_index        : 0,
            accrued         : 0,
        };
        let v1 = LpLeg{
            pool_id         : none_id(),
            lp_amount       : 0,
            lp_reward_guard : 0,
        };
        let v2 = JitterPosition{
            id              : 0x2::object::new(arg3),
            market_state_id : arg0,
            expiry          : arg1,
            created_at      : 0x2::clock::timestamp_ms(arg2),
            py              : v0,
            lp              : v1,
        };
        let v3 = PositionCreatedEvent{
            position_id     : 0x2::object::id<JitterPosition>(&v2),
            market_state_id : arg0,
            pool_id         : none_id(),
            expiry          : arg1,
            owner           : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PositionCreatedEvent>(v3);
        v2
    }

    public fun none_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    public fun pool_id(arg0: &JitterPosition) : 0x2::object::ID {
        arg0.lp.pool_id
    }

    public fun pt_balance(arg0: &JitterPosition) : u64 {
        arg0.py.pt_balance
    }

    public fun py_index(arg0: &JitterPosition) : u128 {
        arg0.py.py_index
    }

    public fun remove_scoped_transfer_lock<T0: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut JitterPosition, arg2: 0x2::object::ID, arg3: T0) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg0);
        let v0 = ScopedTransferLockKey{
            pos0 : 0x1::type_name::with_defining_ids<T0>(),
            pos1 : arg2,
        };
        assert!(0x2::dynamic_field::exists<ScopedTransferLockKey>(&arg1.id, v0), 1908);
        0x2::dynamic_field::remove<ScopedTransferLockKey, bool>(&mut arg1.id, v0);
        decrement_transfer_lock_count(arg1);
        let v1 = PositionTransferLockUpdatedEvent{
            position_id : 0x2::object::id<JitterPosition>(arg1),
            market_id   : arg1.market_state_id,
            source_id   : arg2,
            witness     : 0x1::type_name::with_defining_ids<T0>(),
            locked      : false,
        };
        0x2::event::emit<PositionTransferLockUpdatedEvent>(v1);
    }

    public fun reward_gate_open(arg0: &JitterPosition) : bool {
        let v0 = LpRewardGateKey{dummy_field: false};
        0x2::dynamic_field::exists<LpRewardGateKey>(&arg0.id, v0)
    }

    public(friend) fun set_accrued(arg0: &mut JitterPosition, arg1: u128) {
        arg0.py.accrued = arg1;
    }

    public(friend) fun set_index(arg0: &mut JitterPosition, arg1: u128) {
        arg0.py.index = arg1;
    }

    public(friend) fun set_py_index(arg0: &mut JitterPosition, arg1: u128) {
        arg0.py.py_index = arg1;
    }

    public(friend) fun sub_lp(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        assert!(arg0.lp.lp_amount >= arg1, 1900);
        arg0.lp.lp_amount = arg0.lp.lp_amount - arg1;
        arg0.lp.lp_reward_guard = arg0.lp.lp_reward_guard + 1;
    }

    public(friend) fun sub_pt(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        assert!(arg0.py.pt_balance >= arg1, 500);
        arg0.py.pt_balance = arg0.py.pt_balance - arg1;
    }

    public(friend) fun sub_yt(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        assert!(arg0.py.yt_balance >= arg1, 501);
        arg0.py.yt_balance = arg0.py.yt_balance - arg1;
        arg0.py.yt_reward_guard = arg0.py.yt_reward_guard + 1;
    }

    public fun transfer_locked(arg0: &JitterPosition) : bool {
        let v0 = TransferLockCountKey{dummy_field: false};
        0x2::dynamic_field::exists<TransferLockCountKey>(&arg0.id, v0) && *0x2::dynamic_field::borrow<TransferLockCountKey, u64>(&arg0.id, v0) > 0
    }

    public(friend) fun transfer_position(arg0: JitterPosition, arg1: address) {
        assert!(!transfer_locked(&arg0), 1906);
        let v0 = PositionTransferredEvent{
            position_id : 0x2::object::id<JitterPosition>(&arg0),
            market_id   : arg0.market_state_id,
            recipient   : arg1,
            pt_balance  : arg0.py.pt_balance,
            yt_balance  : arg0.py.yt_balance,
            lp_amount   : arg0.lp.lp_amount,
            accrued     : arg0.py.accrued,
        };
        0x2::event::emit<PositionTransferredEvent>(v0);
        0x2::transfer::transfer<JitterPosition>(arg0, arg1);
    }

    public fun yt_balance(arg0: &JitterPosition) : u64 {
        arg0.py.yt_balance
    }

    public fun yt_reward_guard(arg0: &JitterPosition) : u64 {
        arg0.py.yt_reward_guard
    }

    // decompiled from Move bytecode v7
}

