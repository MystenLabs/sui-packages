module 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor {
    struct RewardDistributor has store, key {
        id: 0x2::object::UID,
        config_version: u64,
        enabled: bool,
    }

    struct RewardOperation {
        distributor_id: 0x2::object::ID,
        profile_id: 0x1::option::Option<0x2::object::ID>,
        scope: u8,
        owner: address,
        subject_id: 0x2::object::ID,
        previous_exposure: u64,
        guard: u64,
        config_version: u64,
        pending_rewarder_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct RewardSettlement {
        distributor_id: 0x2::object::ID,
        profile_id: 0x1::option::Option<0x2::object::ID>,
        scope: u8,
        owner: address,
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

    struct ProfileScopeRewarderSetKey has copy, drop, store {
        pos0: 0x2::object::ID,
        pos1: u8,
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
        scope: u8,
        rewarder_id: 0x2::object::ID,
    }

    struct RewardProfileKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct RewardProfile has store {
        profile_id: 0x2::object::ID,
    }

    struct RewardDistributorCreatedEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        owner: address,
    }

    struct RewardDistributorStatusChangedEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        enabled: bool,
    }

    struct RewarderRegisteredEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        scope: u8,
        kind: vector<u8>,
        label: vector<u8>,
    }

    struct RewarderUnregisteredEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        scope: u8,
    }

    struct RewardProfileCreatedEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
    }

    struct ProfileRewarderRegisteredEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        scope: u8,
        kind: vector<u8>,
        label: vector<u8>,
    }

    struct ProfileRewarderUnregisteredEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        scope: u8,
    }

    struct RewarderSettledEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        scope: u8,
        owner: address,
        subject_id: 0x2::object::ID,
        previous_exposure: u64,
    }

    struct RewardOperationFinishedEvent has copy, drop {
        distributor_id: 0x2::object::ID,
        scope: u8,
        owner: address,
        subject_id: 0x2::object::ID,
        previous_exposure: u64,
    }

    public fun id(arg0: &RewardDistributor) : 0x2::object::ID {
        0x2::object::id<RewardDistributor>(arg0)
    }

    public fun assert_operation_profile_matches(arg0: &RewardOperation, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.profile_id), 9313);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.profile_id) == arg1, 9313);
    }

    public fun assert_owner(arg0: &RewardOperation, arg1: address) {
        assert!(arg0.owner == arg1, 9309);
    }

    fun assert_scope(arg0: u8) {
        assert!(arg0 > 0, 9300);
    }

    public fun assert_settlement_config_current(arg0: &RewardDistributor, arg1: &RewardSettlement) {
        assert!(arg0.enabled, 9304);
        assert!(arg1.distributor_id == 0x2::object::id<RewardDistributor>(arg0), 9305);
        assert!(arg1.config_version == arg0.config_version, 9314);
    }

    public fun assert_settlement_guard(arg0: &RewardSettlement, arg1: u64) {
        assert!(arg0.guard == arg1, 9312);
    }

    public fun assert_settlement_owner(arg0: &RewardSettlement, arg1: address) {
        assert!(arg0.owner == arg1, 9309);
    }

    public fun assert_settlement_previous_exposure(arg0: &RewardSettlement, arg1: u64) {
        assert!(arg0.previous_exposure == arg1, 9312);
    }

    public fun assert_settlement_profile_matches(arg0: &RewardSettlement, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.profile_id), 9313);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.profile_id) == arg1, 9313);
    }

    public fun assert_settlement_scope(arg0: &RewardSettlement, arg1: u8) {
        assert!(arg0.scope == arg1, 9306);
    }

    public fun assert_settlement_subject(arg0: &RewardSettlement, arg1: 0x2::object::ID) {
        assert!(arg0.subject_id == arg1, 9308);
    }

    public fun assert_subject(arg0: &RewardOperation, arg1: 0x2::object::ID) {
        assert!(arg0.subject_id == arg1, 9308);
    }

    public fun begin_scoped_operation(arg0: &RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: u8, arg3: address, arg4: 0x2::object::ID, arg5: u64) : RewardOperation {
        begin_scoped_operation_with_guard(arg0, arg1, arg2, arg3, arg4, arg5, arg5)
    }

    public fun begin_scoped_operation_for_profile(arg0: &RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: 0x2::object::ID, arg3: u8, arg4: address, arg5: 0x2::object::ID, arg6: u64) : RewardOperation {
        begin_scoped_operation_for_profile_with_guard(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg6)
    }

    public fun begin_scoped_operation_for_profile_with_guard(arg0: &RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: 0x2::object::ID, arg3: u8, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: u64) : RewardOperation {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        new_operation(arg0, 0x1::option::some<0x2::object::ID>(arg2), arg3, arg4, arg5, arg6, arg7, profile_rewarder_ids_or_global(arg0, arg2, arg3))
    }

    public fun begin_scoped_operation_with_guard(arg0: &RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: u8, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: u64) : RewardOperation {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        new_operation(arg0, 0x1::option::none<0x2::object::ID>(), arg2, arg3, arg4, arg5, arg6, rewarder_ids(arg0, arg2))
    }

    fun bump_config_version(arg0: &mut RewardDistributor) {
        arg0.config_version = arg0.config_version + 1;
    }

    public fun config_version(arg0: &RewardDistributor) : u64 {
        arg0.config_version
    }

    public(friend) fun consume_lp_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) : 0x2::object::ID {
        consume_position_settlement(arg0, arg1, 2, arg2, arg3)
    }

    public(friend) fun consume_pool_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : 0x2::object::ID {
        let RewardSettlement {
            distributor_id    : v0,
            profile_id        : _,
            scope             : v2,
            owner             : _,
            subject_id        : v4,
            previous_exposure : _,
            guard             : _,
            config_version    : _,
        } = arg0;
        assert!(v0 == arg1, 9305);
        assert!(v2 == 3, 9306);
        assert!(v4 == arg2, 9308);
        v0
    }

    fun consume_position_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: address) : 0x2::object::ID {
        let RewardSettlement {
            distributor_id    : v0,
            profile_id        : _,
            scope             : v2,
            owner             : v3,
            subject_id        : v4,
            previous_exposure : _,
            guard             : _,
            config_version    : _,
        } = arg0;
        assert!(v0 == arg1, 9305);
        assert!(v2 == arg2, 9306);
        assert!(v4 == arg3, 9308);
        assert!(v3 == arg4, 9309);
        v0
    }

    public fun consume_scoped_subject_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID) : 0x2::object::ID {
        assert_scope(arg2);
        let RewardSettlement {
            distributor_id    : v0,
            profile_id        : _,
            scope             : v2,
            owner             : _,
            subject_id        : v4,
            previous_exposure : _,
            guard             : _,
            config_version    : _,
        } = arg0;
        assert!(v0 == arg1, 9305);
        assert!(v2 == arg2, 9306);
        assert!(v4 == arg3, 9308);
        v0
    }

    public(friend) fun consume_yt_settlement(arg0: RewardSettlement, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) : 0x2::object::ID {
        consume_position_settlement(arg0, arg1, 1, arg2, arg3)
    }

    fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardDistributor{
            id             : 0x2::object::new(arg0),
            config_version : 0,
            enabled        : true,
        };
        let v1 = RewardDistributorCreatedEvent{
            distributor_id : 0x2::object::id<RewardDistributor>(&v0),
            owner          : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<RewardDistributorCreatedEvent>(v1);
        0x2::transfer::share_object<RewardDistributor>(v0);
    }

    public fun create_and_share_by_admin(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg1: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg0);
        create_and_share(arg2);
    }

    public fun destroy_settlement(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg1: RewardSettlement) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg0);
        let RewardSettlement {
            distributor_id    : _,
            profile_id        : _,
            scope             : _,
            owner             : _,
            subject_id        : _,
            previous_exposure : _,
            guard             : _,
            config_version    : _,
        } = arg1;
    }

    public fun enabled(arg0: &RewardDistributor) : bool {
        arg0.enabled
    }

    fun ensure_profile_scope_rewarder_set(arg0: &mut RewardDistributor, arg1: 0x2::object::ID, arg2: u8) {
        assert_scope(arg2);
        assert!(profile_exists(arg0, arg1), 9311);
        let v0 = ProfileScopeRewarderSetKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        if (!0x2::dynamic_field::exists_<ProfileScopeRewarderSetKey>(&arg0.id, v0)) {
            let v1 = RewarderSet{ids: 0x2::vec_set::empty<0x2::object::ID>()};
            0x2::dynamic_field::add<ProfileScopeRewarderSetKey, RewarderSet>(&mut arg0.id, v0, v1);
        };
    }

    fun ensure_reward_profile(arg0: &mut RewardDistributor, arg1: 0x2::object::ID) {
        if (profile_exists(arg0, arg1)) {
            return
        };
        let v0 = RewardProfileKey{pos0: arg1};
        let v1 = RewardProfile{profile_id: arg1};
        0x2::dynamic_field::add<RewardProfileKey, RewardProfile>(&mut arg0.id, v0, v1);
        let v2 = RewardProfileCreatedEvent{
            distributor_id : 0x2::object::id<RewardDistributor>(arg0),
            profile_id     : arg1,
        };
        0x2::event::emit<RewardProfileCreatedEvent>(v2);
    }

    fun ensure_scope_rewarder_set(arg0: &mut RewardDistributor, arg1: u8) {
        assert_scope(arg1);
        let v0 = ScopeRewarderSetKey{pos0: arg1};
        if (!0x2::dynamic_field::exists_<ScopeRewarderSetKey>(&arg0.id, v0)) {
            let v1 = RewarderSet{ids: 0x2::vec_set::empty<0x2::object::ID>()};
            0x2::dynamic_field::add<ScopeRewarderSetKey, RewarderSet>(&mut arg0.id, v0, v1);
        };
    }

    public fun finish_operation(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg1: RewardOperation) : RewardSettlement {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg0);
        let RewardOperation {
            distributor_id       : v0,
            profile_id           : v1,
            scope                : v2,
            owner                : v3,
            subject_id           : v4,
            previous_exposure    : v5,
            guard                : v6,
            config_version       : v7,
            pending_rewarder_ids : v8,
        } = arg1;
        let v9 = v8;
        assert!(0x2::vec_set::is_empty<0x2::object::ID>(&v9), 9307);
        let v10 = RewardOperationFinishedEvent{
            distributor_id    : v0,
            scope             : v2,
            owner             : v3,
            subject_id        : v4,
            previous_exposure : v5,
        };
        0x2::event::emit<RewardOperationFinishedEvent>(v10);
        RewardSettlement{
            distributor_id    : v0,
            profile_id        : v1,
            scope             : v2,
            owner             : v3,
            subject_id        : v4,
            previous_exposure : v5,
            guard             : v6,
            config_version    : v7,
        }
    }

    public fun lp_scope() : u8 {
        2
    }

    fun new_operation(arg0: &RewardDistributor, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u8, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: 0x2::vec_set::VecSet<0x2::object::ID>) : RewardOperation {
        assert_scope(arg2);
        assert!(arg0.enabled, 9304);
        RewardOperation{
            distributor_id       : 0x2::object::id<RewardDistributor>(arg0),
            profile_id           : arg1,
            scope                : arg2,
            owner                : arg3,
            subject_id           : arg4,
            previous_exposure    : arg5,
            guard                : arg6,
            config_version       : arg0.config_version,
            pending_rewarder_ids : arg7,
        }
    }

    public fun operation_distributor_id(arg0: &RewardOperation) : 0x2::object::ID {
        arg0.distributor_id
    }

    public fun operation_guard(arg0: &RewardOperation) : u64 {
        arg0.guard
    }

    public fun operation_owner(arg0: &RewardOperation) : address {
        arg0.owner
    }

    public fun operation_scope(arg0: &RewardOperation) : u8 {
        arg0.scope
    }

    public fun operation_subject(arg0: &RewardOperation) : 0x2::object::ID {
        arg0.subject_id
    }

    public fun orderbook_scope() : u8 {
        4
    }

    public fun pending_rewarder_count(arg0: &RewardOperation) : u64 {
        0x2::vec_set::length<0x2::object::ID>(&arg0.pending_rewarder_ids)
    }

    public fun pool_scope() : u8 {
        3
    }

    public fun previous_exposure(arg0: &RewardOperation) : u64 {
        arg0.previous_exposure
    }

    public fun profile_exists(arg0: &RewardDistributor, arg1: 0x2::object::ID) : bool {
        let v0 = RewardProfileKey{pos0: arg1};
        0x2::dynamic_field::exists_<RewardProfileKey>(&arg0.id, v0)
    }

    public fun profile_rewarder_count(arg0: &RewardDistributor, arg1: 0x2::object::ID, arg2: u8) : u64 {
        if (!profile_exists(arg0, arg1)) {
            return 0
        };
        let v0 = profile_rewarder_ids(arg0, arg1, arg2);
        0x2::vec_set::length<0x2::object::ID>(&v0)
    }

    fun profile_rewarder_ids(arg0: &RewardDistributor, arg1: 0x2::object::ID, arg2: u8) : 0x2::vec_set::VecSet<0x2::object::ID> {
        assert_scope(arg2);
        assert!(profile_exists(arg0, arg1), 9311);
        let v0 = ProfileScopeRewarderSetKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        if (0x2::dynamic_field::exists_<ProfileScopeRewarderSetKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<ProfileScopeRewarderSetKey, RewarderSet>(&arg0.id, v0).ids
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    fun profile_rewarder_ids_mut(arg0: &mut RewardDistributor, arg1: 0x2::object::ID, arg2: u8) : &mut 0x2::vec_set::VecSet<0x2::object::ID> {
        assert_scope(arg2);
        assert!(profile_exists(arg0, arg1), 9311);
        ensure_profile_scope_rewarder_set(arg0, arg1, arg2);
        let v0 = ProfileScopeRewarderSetKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        &mut 0x2::dynamic_field::borrow_mut<ProfileScopeRewarderSetKey, RewarderSet>(&mut arg0.id, v0).ids
    }

    fun profile_rewarder_ids_or_global(arg0: &RewardDistributor, arg1: 0x2::object::ID, arg2: u8) : 0x2::vec_set::VecSet<0x2::object::ID> {
        if (profile_exists(arg0, arg1)) {
            let v1 = profile_rewarder_ids(arg0, arg1, arg2);
            if (!0x2::vec_set::is_empty<0x2::object::ID>(&v1)) {
                v1
            } else {
                rewarder_ids(arg0, arg2)
            }
        } else {
            rewarder_ids(arg0, arg2)
        }
    }

    public fun profile_rewarder_registered(arg0: &RewardDistributor, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID) : bool {
        if (!profile_exists(arg0, arg1)) {
            return false
        };
        let v0 = profile_rewarder_ids(arg0, arg1, arg2);
        0x2::vec_set::contains<0x2::object::ID>(&v0, &arg3)
    }

    public fun pt_scope() : u8 {
        5
    }

    fun register_profile_rewarder(arg0: &mut RewardDistributor, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>) {
        assert_scope(arg2);
        let v0 = rewarder_ids(arg0, arg2);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v0, &arg3), 9303);
        ensure_reward_profile(arg0, arg1);
        let v1 = 0x2::object::id<RewardDistributor>(arg0);
        let v2 = profile_rewarder_ids_mut(arg0, arg1, arg2);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(v2, &arg3), 9302);
        assert!(0x2::vec_set::length<0x2::object::ID>(v2) < 16, 9301);
        0x2::vec_set::insert<0x2::object::ID>(v2, arg3);
        bump_config_version(arg0);
        let RewarderMetadata {
            rewarder_id : _,
            scope       : _,
            kind        : v5,
            label       : v6,
        } = rewarder_metadata(arg0, arg3);
        let v7 = ProfileRewarderRegisteredEvent{
            distributor_id : v1,
            profile_id     : arg1,
            rewarder_id    : arg3,
            scope          : arg2,
            kind           : v5,
            label          : v6,
        };
        0x2::event::emit<ProfileRewarderRegisteredEvent>(v7);
    }

    public fun register_profile_rewarder_by_admin(arg0: &mut RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: 0x2::object::ID, arg4: u8, arg5: 0x2::object::ID) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        register_profile_rewarder(arg0, arg3, arg4, arg5, b"", b"");
    }

    public fun register_profile_rewarder_with_metadata_by_admin(arg0: &mut RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: 0x2::object::ID, arg4: u8, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: vector<u8>) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        register_profile_rewarder(arg0, arg3, arg4, arg5, arg6, arg7);
    }

    fun register_rewarder(arg0: &mut RewardDistributor, arg1: u8, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>) {
        assert_scope(arg1);
        let v0 = 0x2::object::id<RewardDistributor>(arg0);
        let v1 = rewarder_ids_mut(arg0, arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(v1, &arg2), 9302);
        assert!(0x2::vec_set::length<0x2::object::ID>(v1) < 16, 9301);
        0x2::vec_set::insert<0x2::object::ID>(v1, arg2);
        set_rewarder_metadata(arg0, arg1, arg2, arg3, arg4);
        bump_config_version(arg0);
        let v2 = RewarderRegisteredEvent{
            distributor_id : v0,
            rewarder_id    : arg2,
            scope          : arg1,
            kind           : arg3,
            label          : arg4,
        };
        0x2::event::emit<RewarderRegisteredEvent>(v2);
    }

    public fun register_rewarder_by_admin(arg0: &mut RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u8, arg4: 0x2::object::ID) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        register_rewarder(arg0, arg3, arg4, b"", b"");
    }

    public fun register_rewarder_with_metadata_by_admin(arg0: &mut RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u8, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: vector<u8>) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        register_rewarder(arg0, arg3, arg4, arg5, arg6);
    }

    public fun register_rewarder_with_settlement_cap_by_admin(arg0: &mut RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u8, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: vector<u8>) : RewarderSettlementCap {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        register_rewarder(arg0, arg3, arg4, arg5, arg6);
        RewarderSettlementCap{
            distributor_id : 0x2::object::id<RewardDistributor>(arg0),
            scope          : arg3,
            rewarder_id    : arg4,
        }
    }

    fun remove_profile_scope_rewarder_set(arg0: &mut RewardDistributor, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = ProfileScopeRewarderSetKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        if (0x2::dynamic_field::exists_<ProfileScopeRewarderSetKey>(&arg0.id, v0)) {
            let RewarderSet {  } = 0x2::dynamic_field::remove<ProfileScopeRewarderSetKey, RewarderSet>(&mut arg0.id, v0);
        };
    }

    fun remove_rewarder_metadata_if_exists(arg0: &mut RewardDistributor, arg1: 0x2::object::ID) {
        let v0 = RewarderMetadataKey{pos0: arg1};
        if (0x2::dynamic_field::exists_<RewarderMetadataKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<RewarderMetadataKey, RewarderMetadata>(&mut arg0.id, v0);
        };
    }

    fun remove_scope_rewarder_set(arg0: &mut RewardDistributor, arg1: u8) {
        let v0 = ScopeRewarderSetKey{pos0: arg1};
        if (0x2::dynamic_field::exists_<ScopeRewarderSetKey>(&arg0.id, v0)) {
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
        if (0x2::dynamic_field::exists_<ScopeRewarderSetKey>(&arg0.id, v0)) {
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
        assert!(0x2::dynamic_field::exists_<RewarderMetadataKey>(&arg0.id, v0), 9310);
        *0x2::dynamic_field::borrow<RewarderMetadataKey, RewarderMetadata>(&arg0.id, v0)
    }

    public fun rewarder_registered(arg0: &RewardDistributor, arg1: u8, arg2: 0x2::object::ID) : bool {
        let v0 = rewarder_ids(arg0, arg1);
        0x2::vec_set::contains<0x2::object::ID>(&v0, &arg2)
    }

    public fun scope_rewarder_ids(arg0: &RewardDistributor, arg1: u8) : 0x2::vec_set::VecSet<0x2::object::ID> {
        rewarder_ids(arg0, arg1)
    }

    fun set_enabled(arg0: &mut RewardDistributor, arg1: bool) {
        if (arg0.enabled != arg1) {
            arg0.enabled = arg1;
            bump_config_version(arg0);
        };
        let v0 = RewardDistributorStatusChangedEvent{
            distributor_id : 0x2::object::id<RewardDistributor>(arg0),
            enabled        : arg1,
        };
        0x2::event::emit<RewardDistributorStatusChangedEvent>(v0);
    }

    public fun set_enabled_by_admin(arg0: &mut RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: bool) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        set_enabled(arg0, arg3);
    }

    fun set_rewarder_metadata(arg0: &mut RewardDistributor, arg1: u8, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = RewarderMetadataKey{pos0: arg2};
        let v1 = RewarderMetadata{
            rewarder_id : arg2,
            scope       : arg1,
            kind        : arg3,
            label       : arg4,
        };
        if (0x2::dynamic_field::exists_<RewarderMetadataKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<RewarderMetadataKey, RewarderMetadata>(&mut arg0.id, v0) = v1;
        } else {
            0x2::dynamic_field::add<RewarderMetadataKey, RewarderMetadata>(&mut arg0.id, v0, v1);
        };
    }

    public(friend) fun settle_lp_rewarder(arg0: &RewardDistributor, arg1: &mut RewardOperation, arg2: 0x2::object::ID) {
        settle_rewarder(arg0, arg1, 2, arg2);
    }

    public(friend) fun settle_pool_rewarder(arg0: &RewardDistributor, arg1: &mut RewardOperation, arg2: 0x2::object::ID) {
        settle_rewarder(arg0, arg1, 3, arg2);
    }

    fun settle_rewarder(arg0: &RewardDistributor, arg1: &mut RewardOperation, arg2: u8, arg3: 0x2::object::ID) {
        assert!(arg1.distributor_id == 0x2::object::id<RewardDistributor>(arg0), 9305);
        assert!(arg1.config_version == arg0.config_version, 9314);
        assert!(arg0.enabled, 9304);
        assert!(arg1.scope == arg2, 9306);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.pending_rewarder_ids, &arg3), 9307);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.pending_rewarder_ids, &arg3);
        let v0 = RewarderSettledEvent{
            distributor_id    : 0x2::object::id<RewardDistributor>(arg0),
            rewarder_id       : arg3,
            scope             : arg2,
            owner             : arg1.owner,
            subject_id        : arg1.subject_id,
            previous_exposure : arg1.previous_exposure,
        };
        0x2::event::emit<RewarderSettledEvent>(v0);
    }

    public fun settle_rewarder_with_cap(arg0: &RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &mut RewardOperation, arg3: &RewarderSettlementCap) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        assert!(arg3.distributor_id == 0x2::object::id<RewardDistributor>(arg0), 9305);
        settle_rewarder(arg0, arg2, arg3.scope, arg3.rewarder_id);
    }

    public(friend) fun settle_yt_rewarder(arg0: &RewardDistributor, arg1: &mut RewardOperation, arg2: 0x2::object::ID) {
        settle_rewarder(arg0, arg1, 1, arg2);
    }

    public fun settlement_config_version(arg0: &RewardSettlement) : u64 {
        arg0.config_version
    }

    public fun settlement_distributor_id(arg0: &RewardSettlement) : 0x2::object::ID {
        arg0.distributor_id
    }

    public fun settlement_guard(arg0: &RewardSettlement) : u64 {
        arg0.guard
    }

    public fun settlement_owner(arg0: &RewardSettlement) : address {
        arg0.owner
    }

    public fun settlement_previous_exposure(arg0: &RewardSettlement) : u64 {
        arg0.previous_exposure
    }

    public fun settlement_profile_id(arg0: &RewardSettlement) : 0x1::option::Option<0x2::object::ID> {
        arg0.profile_id
    }

    public fun settlement_scope(arg0: &RewardSettlement) : u8 {
        arg0.scope
    }

    public fun settlement_subject(arg0: &RewardSettlement) : 0x2::object::ID {
        arg0.subject_id
    }

    fun unregister_profile_rewarder(arg0: &mut RewardDistributor, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID) {
        assert_scope(arg2);
        assert!(profile_exists(arg0, arg1), 9311);
        let v0 = 0x2::object::id<RewardDistributor>(arg0);
        let v1 = profile_rewarder_ids_mut(arg0, arg1, arg2);
        assert!(0x2::vec_set::contains<0x2::object::ID>(v1, &arg3), 9303);
        0x2::vec_set::remove<0x2::object::ID>(v1, &arg3);
        if (0x2::vec_set::is_empty<0x2::object::ID>(v1)) {
            remove_profile_scope_rewarder_set(arg0, arg1, arg2);
        };
        bump_config_version(arg0);
        let v2 = ProfileRewarderUnregisteredEvent{
            distributor_id : v0,
            profile_id     : arg1,
            rewarder_id    : arg3,
            scope          : arg2,
        };
        0x2::event::emit<ProfileRewarderUnregisteredEvent>(v2);
    }

    public fun unregister_profile_rewarder_by_admin(arg0: &mut RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: 0x2::object::ID, arg4: u8, arg5: 0x2::object::ID) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        unregister_profile_rewarder(arg0, arg3, arg4, arg5);
    }

    fun unregister_rewarder(arg0: &mut RewardDistributor, arg1: u8, arg2: 0x2::object::ID) {
        assert_scope(arg1);
        let v0 = 0x2::object::id<RewardDistributor>(arg0);
        let v1 = rewarder_ids_mut(arg0, arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(v1, &arg2), 9303);
        0x2::vec_set::remove<0x2::object::ID>(v1, &arg2);
        if (0x2::vec_set::is_empty<0x2::object::ID>(v1)) {
            remove_scope_rewarder_set(arg0, arg1);
        };
        remove_rewarder_metadata_if_exists(arg0, arg2);
        bump_config_version(arg0);
        let v2 = RewarderUnregisteredEvent{
            distributor_id : v0,
            rewarder_id    : arg2,
            scope          : arg1,
        };
        0x2::event::emit<RewarderUnregisteredEvent>(v2);
    }

    public fun unregister_rewarder_by_admin(arg0: &mut RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u8, arg4: 0x2::object::ID) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        unregister_rewarder(arg0, arg3, arg4);
    }

    public fun yt_scope() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

