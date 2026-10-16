module 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::reward_distributor {
    struct RewardDistributor has store, key {
        id: 0x2::object::UID,
        market_state_id: 0x2::object::ID,
        config_version: u64,
        enabled: bool,
    }

    struct RewardOperation {
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        scope: u8,
        owner: address,
        operation_kind: u8,
        next_owner: address,
        subject_id: 0x2::object::ID,
        previous_exposure: u64,
        guard: u64,
        config_version: u64,
        pending_rewarder_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct RewardSettlement {
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        scope: u8,
        owner: address,
        operation_kind: u8,
        next_owner: address,
        subject_id: 0x2::object::ID,
        previous_exposure: u64,
        guard: u64,
        config_version: u64,
    }

    struct RewarderMetadataKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct ScopeRewarderSetKey has copy, drop, store {
        pos0: u8,
    }

    struct RetiredRewarderKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct RewarderSet has store {
        ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct RewarderMetadata has copy, drop, store {
        rewarder_id: 0x2::object::ID,
        scope: u8,
        kind: vector<u8>,
        label: vector<u8>,
    }

    struct RewarderSettlementCap has store {
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        scope: u8,
        rewarder_id: 0x2::object::ID,
    }

    struct RewardDistributorCreatedEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        owner: address,
    }

    struct RewardDistributorStatusChangedEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        enabled: bool,
    }

    struct RewarderRegisteredEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        scope: u8,
        kind: vector<u8>,
        label: vector<u8>,
    }

    struct RewarderUnregisteredEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        scope: u8,
    }

    struct RewarderSettledEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        scope: u8,
        owner: address,
        operation_kind: u8,
        next_owner: address,
        subject_id: 0x2::object::ID,
        previous_exposure: u64,
    }

    struct RewardOperationFinishedEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        scope: u8,
        owner: address,
        operation_kind: u8,
        next_owner: address,
        subject_id: 0x2::object::ID,
        previous_exposure: u64,
    }

    struct RewardSettlementPreparedEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        scope: u8,
        operation_kind: u8,
        config_version: u64,
        declared_owner: address,
        declared_next_owner: address,
        declared_subject_id: 0x2::object::ID,
        declared_previous_exposure: u64,
    }

    public fun id(arg0: &RewardDistributor) : 0x2::object::ID {
        0x2::object::id<RewardDistributor>(arg0)
    }

    fun assert_cap_matches(arg0: &RewardDistributor, arg1: &RewarderSettlementCap) {
        assert!(arg1.distributor_id == 0x2::object::id<RewardDistributor>(arg0), 9305);
        assert!(arg1.market_state_id == arg0.market_state_id, 9311);
    }

    public fun assert_mutation_operation(arg0: &RewardOperation) {
        assert!(arg0.operation_kind == 0, 9315);
        assert!(arg0.next_owner == arg0.owner, 9309);
    }

    public fun assert_operation_market_matches(arg0: &RewardOperation, arg1: 0x2::object::ID) {
        assert!(arg0.market_state_id == arg1, 9311);
    }

    public fun assert_owner(arg0: &RewardOperation, arg1: address) {
        assert!(arg0.owner == arg1, 9309);
    }

    fun assert_scope(arg0: u8) {
        assert!(arg0 > 0, 9300);
    }

    public fun assert_settlement_config_current(arg0: &RewardDistributor, arg1: &RewardSettlement) {
        assert!(arg1.distributor_id == 0x2::object::id<RewardDistributor>(arg0), 9305);
        assert!(arg1.market_state_id == arg0.market_state_id, 9311);
        assert!(arg1.config_version == arg0.config_version, 9314);
    }

    public fun assert_settlement_guard(arg0: &RewardSettlement, arg1: u64) {
        assert!(arg0.guard == arg1, 9312);
    }

    public fun assert_settlement_market_matches(arg0: &RewardSettlement, arg1: 0x2::object::ID) {
        assert!(arg0.market_state_id == arg1, 9311);
    }

    public fun assert_settlement_mutation(arg0: &RewardSettlement) {
        assert!(arg0.operation_kind == 0, 9315);
        assert!(arg0.next_owner == arg0.owner, 9309);
    }

    public fun assert_settlement_owner(arg0: &RewardSettlement, arg1: address) {
        assert!(arg0.owner == arg1, 9309);
    }

    public fun assert_settlement_previous_exposure(arg0: &RewardSettlement, arg1: u64) {
        assert!(arg0.previous_exposure == arg1, 9312);
    }

    public fun assert_settlement_scope(arg0: &RewardSettlement, arg1: u8) {
        assert!(arg0.scope == arg1, 9306);
    }

    public fun assert_settlement_subject(arg0: &RewardSettlement, arg1: 0x2::object::ID) {
        assert!(arg0.subject_id == arg1, 9308);
    }

    public fun assert_settlement_transfer_to(arg0: &RewardSettlement, arg1: address) {
        assert!(arg0.operation_kind == 1, 9315);
        assert!(arg0.next_owner == arg1, 9309);
    }

    public fun assert_subject(arg0: &RewardOperation, arg1: 0x2::object::ID) {
        assert!(arg0.subject_id == arg1, 9308);
    }

    public fun assert_transfer_operation(arg0: &RewardOperation, arg1: address) {
        assert!(arg0.operation_kind == 1, 9315);
        assert!(arg0.next_owner == arg1, 9309);
    }

    public fun begin_scoped_operation_with_guard(arg0: &RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: u8, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: u64) : RewardOperation {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        new_operation(arg0, arg2, arg3, 0, arg3, arg4, arg5, arg6)
    }

    public fun begin_transfer_operation(arg0: &RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: u8, arg3: address, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: u64) : RewardOperation {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        new_operation(arg0, arg2, arg3, 1, arg4, arg5, arg6, arg7)
    }

    public fun config_version(arg0: &RewardDistributor) : u64 {
        arg0.config_version
    }

    public(friend) fun consume_lp_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) : 0x2::object::ID {
        consume_position_settlement(arg0, arg1, 2, arg2, arg3)
    }

    public(friend) fun consume_lp_transfer_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: address) : 0x2::object::ID {
        consume_position_transfer_settlement(arg0, arg1, 2, arg2, arg3, arg4)
    }

    public(friend) fun consume_pool_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : 0x2::object::ID {
        consume_scoped_subject_settlement(arg0, arg1, 3, arg2)
    }

    fun consume_position_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: address) : 0x2::object::ID {
        let RewardSettlement {
            distributor_id    : v0,
            market_state_id   : _,
            scope             : v2,
            owner             : v3,
            operation_kind    : v4,
            next_owner        : v5,
            subject_id        : v6,
            previous_exposure : _,
            guard             : _,
            config_version    : _,
        } = arg0;
        assert!(v0 == arg1, 9305);
        assert!(v2 == arg2, 9306);
        assert!(v4 == 0, 9315);
        assert!(v5 == v3, 9309);
        assert!(v6 == arg3, 9308);
        assert!(v3 == arg4, 9309);
        v0
    }

    fun consume_position_transfer_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: address, arg5: address) : 0x2::object::ID {
        let RewardSettlement {
            distributor_id    : v0,
            market_state_id   : _,
            scope             : v2,
            owner             : v3,
            operation_kind    : v4,
            next_owner        : v5,
            subject_id        : v6,
            previous_exposure : _,
            guard             : _,
            config_version    : _,
        } = arg0;
        assert!(v0 == arg1, 9305);
        assert!(v2 == arg2, 9306);
        assert!(v4 == 1, 9315);
        assert!(v6 == arg3, 9308);
        assert!(v3 == arg4, 9309);
        assert!(v5 == arg5, 9309);
        v0
    }

    public fun consume_scoped_subject_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID) : 0x2::object::ID {
        assert_scope(arg2);
        let RewardSettlement {
            distributor_id    : v0,
            market_state_id   : _,
            scope             : v2,
            owner             : _,
            operation_kind    : v4,
            next_owner        : _,
            subject_id        : v6,
            previous_exposure : _,
            guard             : _,
            config_version    : _,
        } = arg0;
        assert!(v0 == arg1, 9305);
        assert!(v2 == arg2, 9306);
        assert!(v4 == 0, 9315);
        assert!(v6 == arg3, 9308);
        v0
    }

    public(friend) fun consume_yt_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) : 0x2::object::ID {
        consume_position_settlement(arg0, arg1, 1, arg2, arg3)
    }

    public(friend) fun consume_yt_transfer_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: address) : 0x2::object::ID {
        consume_position_transfer_settlement(arg0, arg1, 1, arg2, arg3, arg4)
    }

    public fun destroy_settlement(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: RewardSettlement) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg0);
        assert!(arg1.operation_kind == 0, 9315);
        let RewardSettlement {
            distributor_id    : _,
            market_state_id   : _,
            scope             : _,
            owner             : _,
            operation_kind    : _,
            next_owner        : _,
            subject_id        : _,
            previous_exposure : _,
            guard             : _,
            config_version    : _,
        } = arg1;
    }

    public fun enabled(arg0: &RewardDistributor) : bool {
        arg0.enabled
    }

    fun ensure_scope_rewarder_set(arg0: &mut RewardDistributor, arg1: u8) {
        let v0 = ScopeRewarderSetKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<ScopeRewarderSetKey>(&arg0.id, v0)) {
            let v1 = RewarderSet{ids: 0x2::vec_set::empty<0x2::object::ID>()};
            0x2::dynamic_field::add<ScopeRewarderSetKey, RewarderSet>(&mut arg0.id, v0, v1);
        };
    }

    public fun finish_operation(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: RewardOperation) : RewardSettlement {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg0);
        let RewardOperation {
            distributor_id       : v0,
            market_state_id      : v1,
            scope                : v2,
            owner                : v3,
            operation_kind       : v4,
            next_owner           : v5,
            subject_id           : v6,
            previous_exposure    : v7,
            guard                : v8,
            config_version       : v9,
            pending_rewarder_ids : v10,
        } = arg1;
        let v11 = v10;
        assert!(0x2::vec_set::is_empty<0x2::object::ID>(&v11), 9307);
        let v12 = RewardSettlementPreparedEvent{
            distributor_id             : v0,
            market_state_id            : v1,
            scope                      : v2,
            operation_kind             : v4,
            config_version             : v9,
            declared_owner             : v3,
            declared_next_owner        : v5,
            declared_subject_id        : v6,
            declared_previous_exposure : v7,
        };
        0x2::event::emit<RewardSettlementPreparedEvent>(v12);
        RewardSettlement{
            distributor_id    : v0,
            market_state_id   : v1,
            scope             : v2,
            owner             : v3,
            operation_kind    : v4,
            next_owner        : v5,
            subject_id        : v6,
            previous_exposure : v7,
            guard             : v8,
            config_version    : v9,
        }
    }

    public fun lp_scope() : u8 {
        2
    }

    public fun market_state_id(arg0: &RewardDistributor) : 0x2::object::ID {
        arg0.market_state_id
    }

    public(friend) fun new_for_market(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : RewardDistributor {
        let v0 = RewardDistributor{
            id              : 0x2::object::new(arg1),
            market_state_id : arg0,
            config_version  : 0,
            enabled         : true,
        };
        let v1 = RewardDistributorCreatedEvent{
            distributor_id  : 0x2::object::id<RewardDistributor>(&v0),
            market_state_id : arg0,
            owner           : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RewardDistributorCreatedEvent>(v1);
        v0
    }

    fun new_operation(arg0: &RewardDistributor, arg1: u8, arg2: address, arg3: u8, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: u64) : RewardOperation {
        assert_scope(arg1);
        assert!(arg3 == 0 || arg3 == 1, 9315);
        if (arg3 == 0) {
            assert!(arg4 == arg2, 9309);
        };
        RewardOperation{
            distributor_id       : 0x2::object::id<RewardDistributor>(arg0),
            market_state_id      : arg0.market_state_id,
            scope                : arg1,
            owner                : arg2,
            operation_kind       : arg3,
            next_owner           : arg4,
            subject_id           : arg5,
            previous_exposure    : arg6,
            guard                : arg7,
            config_version       : arg0.config_version,
            pending_rewarder_ids : rewarder_ids(arg0, arg1),
        }
    }

    public fun operation_guard(arg0: &RewardOperation) : u64 {
        arg0.guard
    }

    public fun operation_is_transfer(arg0: &RewardOperation) : bool {
        arg0.operation_kind == 1
    }

    public fun operation_next_owner(arg0: &RewardOperation) : address {
        arg0.next_owner
    }

    public fun operation_owner(arg0: &RewardOperation) : address {
        arg0.owner
    }

    public fun operation_scope(arg0: &RewardOperation) : u8 {
        arg0.scope
    }

    public fun orderbook_scope() : u8 {
        4
    }

    public fun pool_scope() : u8 {
        3
    }

    public fun previous_exposure(arg0: &RewardOperation) : u64 {
        arg0.previous_exposure
    }

    public fun pt_scope() : u8 {
        5
    }

    fun register_rewarder(arg0: &mut RewardDistributor, arg1: u8, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0.enabled, 9304);
        assert_scope(arg1);
        assert!(!rewarder_retired(arg0, arg2), 9316);
        let v0 = rewarder_ids_mut(arg0, arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(v0, &arg2), 9302);
        assert!(0x2::vec_set::length<0x2::object::ID>(v0) < 16, 9301);
        0x2::vec_set::insert<0x2::object::ID>(v0, arg2);
        let v1 = RewarderMetadataKey{pos0: arg2};
        let v2 = RewarderMetadata{
            rewarder_id : arg2,
            scope       : arg1,
            kind        : arg3,
            label       : arg4,
        };
        0x2::dynamic_field::add<RewarderMetadataKey, RewarderMetadata>(&mut arg0.id, v1, v2);
        arg0.config_version = arg0.config_version + 1;
        let v3 = RewarderRegisteredEvent{
            distributor_id  : 0x2::object::id<RewardDistributor>(arg0),
            market_state_id : arg0.market_state_id,
            rewarder_id     : arg2,
            scope           : arg1,
            kind            : arg3,
            label           : arg4,
        };
        0x2::event::emit<RewarderRegisteredEvent>(v3);
    }

    public fun register_rewarder_with_settlement_cap_by_admin(arg0: &mut RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u8, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: vector<u8>) : RewarderSettlementCap {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        register_rewarder(arg0, arg3, arg4, arg5, arg6);
        RewarderSettlementCap{
            distributor_id  : 0x2::object::id<RewardDistributor>(arg0),
            market_state_id : arg0.market_state_id,
            scope           : arg3,
            rewarder_id     : arg4,
        }
    }

    fun remove_scope_rewarder_set(arg0: &mut RewardDistributor, arg1: u8) {
        let v0 = ScopeRewarderSetKey{pos0: arg1};
        if (0x2::dynamic_field::exists<ScopeRewarderSetKey>(&arg0.id, v0)) {
            let RewarderSet {  } = 0x2::dynamic_field::remove<ScopeRewarderSetKey, RewarderSet>(&mut arg0.id, v0);
        };
    }

    public fun rewarder_count(arg0: &RewardDistributor, arg1: u8) : u64 {
        let v0 = rewarder_ids(arg0, arg1);
        0x2::vec_set::length<0x2::object::ID>(&v0)
    }

    fun rewarder_ids(arg0: &RewardDistributor, arg1: u8) : 0x2::vec_set::VecSet<0x2::object::ID> {
        assert_scope(arg1);
        let v0 = ScopeRewarderSetKey{pos0: arg1};
        if (0x2::dynamic_field::exists<ScopeRewarderSetKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<ScopeRewarderSetKey, RewarderSet>(&arg0.id, v0).ids
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    fun rewarder_ids_mut(arg0: &mut RewardDistributor, arg1: u8) : &mut 0x2::vec_set::VecSet<0x2::object::ID> {
        assert_scope(arg1);
        ensure_scope_rewarder_set(arg0, arg1);
        let v0 = ScopeRewarderSetKey{pos0: arg1};
        &mut 0x2::dynamic_field::borrow_mut<ScopeRewarderSetKey, RewarderSet>(&mut arg0.id, v0).ids
    }

    public fun rewarder_metadata(arg0: &RewardDistributor, arg1: 0x2::object::ID) : RewarderMetadata {
        let v0 = RewarderMetadataKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<RewarderMetadataKey>(&arg0.id, v0), 9310);
        *0x2::dynamic_field::borrow<RewarderMetadataKey, RewarderMetadata>(&arg0.id, v0)
    }

    public fun rewarder_registered(arg0: &RewardDistributor, arg1: u8, arg2: 0x2::object::ID) : bool {
        let v0 = rewarder_ids(arg0, arg1);
        0x2::vec_set::contains<0x2::object::ID>(&v0, &arg2)
    }

    fun rewarder_retired(arg0: &RewardDistributor, arg1: 0x2::object::ID) : bool {
        let v0 = RetiredRewarderKey{pos0: arg1};
        0x2::dynamic_field::exists<RetiredRewarderKey>(&arg0.id, v0)
    }

    public fun scope_rewarder_ids(arg0: &RewardDistributor, arg1: u8) : 0x2::vec_set::VecSet<0x2::object::ID> {
        rewarder_ids(arg0, arg1)
    }

    public fun set_enabled_by_admin(arg0: &mut RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: bool) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        arg0.enabled = arg3;
        let v0 = RewardDistributorStatusChangedEvent{
            distributor_id  : 0x2::object::id<RewardDistributor>(arg0),
            market_state_id : arg0.market_state_id,
            enabled         : arg3,
        };
        0x2::event::emit<RewardDistributorStatusChangedEvent>(v0);
    }

    fun settle_rewarder(arg0: &RewardDistributor, arg1: &mut RewardOperation, arg2: u8, arg3: 0x2::object::ID) {
        assert!(arg1.distributor_id == 0x2::object::id<RewardDistributor>(arg0), 9305);
        assert!(arg1.market_state_id == arg0.market_state_id, 9311);
        assert!(arg1.config_version == arg0.config_version, 9314);
        assert!(arg1.scope == arg2, 9306);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.pending_rewarder_ids, &arg3), 9307);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.pending_rewarder_ids, &arg3);
        let v0 = RewarderSettledEvent{
            distributor_id    : 0x2::object::id<RewardDistributor>(arg0),
            market_state_id   : arg0.market_state_id,
            rewarder_id       : arg3,
            scope             : arg2,
            owner             : arg1.owner,
            operation_kind    : arg1.operation_kind,
            next_owner        : arg1.next_owner,
            subject_id        : arg1.subject_id,
            previous_exposure : arg1.previous_exposure,
        };
        0x2::event::emit<RewarderSettledEvent>(v0);
    }

    public fun settle_rewarder_with_cap(arg0: &RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut RewardOperation, arg3: &RewarderSettlementCap) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        assert_mutation_operation(arg2);
        assert_cap_matches(arg0, arg3);
        settle_rewarder(arg0, arg2, arg3.scope, arg3.rewarder_id);
    }

    public fun settle_transfer_rewarder_with_cap(arg0: &RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &mut RewardOperation, arg3: &RewarderSettlementCap, arg4: address) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        assert_transfer_operation(arg2, arg4);
        assert_cap_matches(arg0, arg3);
        settle_rewarder(arg0, arg2, arg3.scope, arg3.rewarder_id);
    }

    fun unregister_rewarder(arg0: &mut RewardDistributor, arg1: u8, arg2: 0x2::object::ID) {
        assert!(arg0.enabled, 9304);
        assert_scope(arg1);
        let v0 = rewarder_ids_mut(arg0, arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(v0, &arg2), 9303);
        0x2::vec_set::remove<0x2::object::ID>(v0, &arg2);
        if (0x2::vec_set::is_empty<0x2::object::ID>(v0)) {
            remove_scope_rewarder_set(arg0, arg1);
        };
        let v1 = RewarderMetadataKey{pos0: arg2};
        0x2::dynamic_field::remove<RewarderMetadataKey, RewarderMetadata>(&mut arg0.id, v1);
        let v2 = RetiredRewarderKey{pos0: arg2};
        0x2::dynamic_field::add<RetiredRewarderKey, bool>(&mut arg0.id, v2, true);
        arg0.config_version = arg0.config_version + 1;
        let v3 = RewarderUnregisteredEvent{
            distributor_id  : 0x2::object::id<RewardDistributor>(arg0),
            market_state_id : arg0.market_state_id,
            rewarder_id     : arg2,
            scope           : arg1,
        };
        0x2::event::emit<RewarderUnregisteredEvent>(v3);
    }

    public fun unregister_rewarder_by_admin(arg0: &mut RewardDistributor, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &RewarderSettlementCap) {
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::package_version::assert_current(arg1);
        assert_cap_matches(arg0, arg3);
        unregister_rewarder(arg0, arg3.scope, arg3.rewarder_id);
    }

    public fun yt_scope() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

