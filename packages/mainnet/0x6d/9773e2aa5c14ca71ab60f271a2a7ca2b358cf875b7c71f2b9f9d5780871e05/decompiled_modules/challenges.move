module 0x6d9773e2aa5c14ca71ab60f271a2a7ca2b358cf875b7c71f2b9f9d5780871e05::challenges {
    struct Challenges has drop {
        dummy: bool,
    }

    struct RegistryKey has copy, drop, store {
        dummy: bool,
    }

    struct ChallengeKey has copy, drop, store {
        pos0: vector<u8>,
    }

    struct ChallengeAdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        generation: u64,
        owner: address,
    }

    struct ChallengeOperatorCap has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        generation: u64,
        owner: address,
    }

    struct Limits has copy, drop, store {
        max_prize: u64,
        rolling_amount: u64,
        rolling_count: u64,
        outstanding_amount: u64,
        cumulative_amount: u64,
    }

    struct Creation has copy, drop, store {
        at_ms: u64,
        amount: u64,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        version: u64,
        admin_generation: u64,
        admin_owner: address,
        operator_generation: u64,
        operations_paused: bool,
        claims_paused_at_ms: 0x1::option::Option<u64>,
        paused_claim_time_ms: u64,
        claim_time_credit_until_ms: u64,
        limits: Limits,
        pending_limits: 0x1::option::Option<Limits>,
        pending_limits_ready_at_ms: 0x1::option::Option<u64>,
        cumulative_created: u64,
        outstanding: u64,
        recent_creations: vector<Creation>,
        active_games: vector<0x1::option::Option<vector<u8>>>,
    }

    struct Challenge has copy, drop, store {
        challenge_id: vector<u8>,
        rule_hash: vector<u8>,
        game: u64,
        amount: u64,
        starts_at_ms: u64,
        status: u8,
        winner: 0x1::option::Option<address>,
        proof_hash: vector<u8>,
        completed_at_ms: 0x1::option::Option<u64>,
        awarded_at_ms: 0x1::option::Option<u64>,
        claim_deadline_tick: 0x1::option::Option<u64>,
        cancellation_cutoff_ms: 0x1::option::Option<u64>,
        cancellation_digest: vector<u8>,
        cancellation_drained: bool,
    }

    struct RegistryConfigured has copy, drop {
        registry_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        limits: Limits,
        cumulative_created: u64,
        outstanding: u64,
        operator_generation: u64,
        operations_paused: bool,
        claims_paused_at_ms: 0x1::option::Option<u64>,
        paused_claim_time_ms: u64,
        version: u64,
    }

    struct ChallengeChanged has copy, drop {
        registry_id: 0x2::object::ID,
        challenge: Challenge,
    }

    struct LimitsChangeScheduled has copy, drop {
        registry_id: 0x2::object::ID,
        limits: Limits,
        ready_at_ms: u64,
    }

    struct LimitsChangeCancelled has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct ClaimTimeCredited has copy, drop {
        registry_id: 0x2::object::ID,
        from_ms: u64,
        to_ms: u64,
    }

    struct AdminCapabilityReissued has copy, drop {
        registry_id: 0x2::object::ID,
        generation: u64,
        owner: address,
    }

    fun admin(arg0: &Registry, arg1: &ChallengeAdminCap, arg2: &0x2::tx_context::TxContext) {
        version(arg0);
        admin_authority(arg0, arg1, arg2);
    }

    public fun admin_apply_limits(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin(v0, arg1, arg3);
        assert!(v0.operations_paused, 3);
        let v1 = if (0x1::option::is_some<Limits>(&v0.pending_limits)) {
            if (0x1::option::is_some<u64>(&v0.pending_limits_ready_at_ms)) {
                0x2::clock::timestamp_ms(arg2) >= *0x1::option::borrow<u64>(&v0.pending_limits_ready_at_ms)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13);
        let v2 = 0x1::option::extract<Limits>(&mut v0.pending_limits);
        validate_limits(v2);
        v0.limits = v2;
        0x1::option::extract<u64>(&mut v0.pending_limits_ready_at_ms);
        configured(v0);
    }

    fun admin_authority(arg0: &Registry, arg1: &ChallengeAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = if (arg1.registry_id == 0x2::object::id<Registry>(arg0)) {
            if (arg1.generation == arg0.admin_generation) {
                if (arg1.owner == arg0.admin_owner) {
                    arg1.owner == 0x2::tx_context::sender(arg2)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun admin_cancel_limits(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin(v0, arg1, arg2);
        assert!(0x1::option::is_some<Limits>(&v0.pending_limits), 13);
        v0.pending_limits = 0x1::option::none<Limits>();
        v0.pending_limits_ready_at_ms = 0x1::option::none<u64>();
        let v1 = LimitsChangeCancelled{registry_id: 0x2::object::id<Registry>(v0)};
        0x2::event::emit<LimitsChangeCancelled>(v1);
    }

    public fun admin_credit_claim_time(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin(v0, arg1, arg5);
        assert!(v0.operations_paused && 0x1::option::is_some<u64>(&v0.claims_paused_at_ms), 3);
        let v1 = *0x1::option::borrow<u64>(&v0.claims_paused_at_ms);
        let v2 = if (arg3 >= v0.claim_time_credit_until_ms) {
            if (arg4 > arg3) {
                if (arg4 <= v1) {
                    v1 <= 0x2::clock::timestamp_ms(arg2)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 4);
        let v3 = arg4 - arg3;
        let v4 = if (v3 <= 31536000000) {
            if (v0.paused_claim_time_ms <= v1) {
                v3 <= v1 - v0.paused_claim_time_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 4);
        v0.paused_claim_time_ms = v0.paused_claim_time_ms + v3;
        v0.claim_time_credit_until_ms = arg4;
        let v5 = ClaimTimeCredited{
            registry_id : 0x2::object::id<Registry>(v0),
            from_ms     : arg3,
            to_ms       : arg4,
        };
        0x2::event::emit<ClaimTimeCredited>(v5);
        configured(v0);
    }

    public fun admin_finalize_cancellation(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin(v0, arg1, arg3);
        let v1 = ChallengeKey{pos0: arg2};
        let v2 = 0x2::dynamic_field::borrow_mut<ChallengeKey, Challenge>(&mut v0.id, v1);
        let v3 = if (v2.status == 0) {
            if (0x1::option::is_some<u64>(&v2.cancellation_cutoff_ms)) {
                v2.cancellation_drained
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 11);
        v2.status = 3;
        v0.outstanding = v0.outstanding - v2.amount;
        *0x1::vector::borrow_mut<0x1::option::Option<vector<u8>>>(&mut v0.active_games, v2.game) = 0x1::option::none<vector<u8>>();
        changed(v0, arg2);
        configured(v0);
    }

    public fun admin_initialize<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: Limits, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistryKey{dummy: false};
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::dof_exists<RegistryKey>(arg0, v0), 6);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::house_exists<T0>(arg0), 10);
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::get_coin_decimals<T0>(arg0) == 6 && 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::get_dollar_coin_type(arg0) == 0x1::type_name::with_defining_ids<T0>(), 10);
        validate_limits(arg2);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::admin_add_operator_config<Challenges>(arg0, arg1, arg3);
        let v1 = 0x1::vector::empty<0x1::option::Option<vector<u8>>>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::option::Option<vector<u8>>>(v2, 0x1::option::none<vector<u8>>());
        0x1::vector::push_back<0x1::option::Option<vector<u8>>>(v2, 0x1::option::none<vector<u8>>());
        0x1::vector::push_back<0x1::option::Option<vector<u8>>>(v2, 0x1::option::none<vector<u8>>());
        0x1::vector::push_back<0x1::option::Option<vector<u8>>>(v2, 0x1::option::none<vector<u8>>());
        0x1::vector::push_back<0x1::option::Option<vector<u8>>>(v2, 0x1::option::none<vector<u8>>());
        0x1::vector::push_back<0x1::option::Option<vector<u8>>>(v2, 0x1::option::none<vector<u8>>());
        0x1::vector::push_back<0x1::option::Option<vector<u8>>>(v2, 0x1::option::none<vector<u8>>());
        let v3 = Registry{
            id                         : 0x2::object::new(arg3),
            coin_type                  : 0x1::type_name::with_defining_ids<T0>(),
            version                    : 1,
            admin_generation           : 0,
            admin_owner                : 0x2::tx_context::sender(arg3),
            operator_generation        : 0,
            operations_paused          : true,
            claims_paused_at_ms        : 0x1::option::none<u64>(),
            paused_claim_time_ms       : 0,
            claim_time_credit_until_ms : 0,
            limits                     : arg2,
            pending_limits             : 0x1::option::none<Limits>(),
            pending_limits_ready_at_ms : 0x1::option::none<u64>(),
            cumulative_created         : 0,
            outstanding                : 0,
            recent_creations           : 0x1::vector::empty<Creation>(),
            active_games               : v1,
        };
        let v4 = ChallengeAdminCap{
            id          : 0x2::object::new(arg3),
            registry_id : 0x2::object::id<Registry>(&v3),
            generation  : 0,
            owner       : 0x2::tx_context::sender(arg3),
        };
        configured(&v3);
        let v5 = Challenges{dummy: false};
        let v6 = RegistryKey{dummy: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_dof<Challenges, RegistryKey, Registry>(arg0, v5, v6, v3);
        0x2::transfer::public_transfer<ChallengeAdminCap>(v4, 0x2::tx_context::sender(arg3));
    }

    public fun admin_pause(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: &0x2::clock::Clock, arg3: bool, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin(v0, arg1, arg5);
        set_pause(v0, arg2, arg3, arg4);
    }

    public fun admin_pause_if_state(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: &0x2::clock::Clock, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin(v0, arg1, arg7);
        assert!(v0.operations_paused == arg3 && 0x1::option::is_some<u64>(&v0.claims_paused_at_ms) == arg4, 7);
        set_pause(v0, arg2, arg5, arg6);
    }

    public fun admin_reissue_admin(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 4);
        let v0 = registry_mut(arg0);
        assert!(v0.version <= 1, 2);
        v0.admin_generation = v0.admin_generation + 1;
        v0.admin_owner = arg3;
        v0.operator_generation = v0.operator_generation + 1;
        v0.operations_paused = true;
        if (0x1::option::is_none<u64>(&v0.claims_paused_at_ms)) {
            v0.claims_paused_at_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        };
        v0.pending_limits = 0x1::option::none<Limits>();
        v0.pending_limits_ready_at_ms = 0x1::option::none<u64>();
        let v1 = ChallengeAdminCap{
            id          : 0x2::object::new(arg4),
            registry_id : 0x2::object::id<Registry>(v0),
            generation  : v0.admin_generation,
            owner       : arg3,
        };
        0x2::transfer::public_transfer<ChallengeAdminCap>(v1, arg3);
        let v2 = AdminCapabilityReissued{
            registry_id : 0x2::object::id<Registry>(v0),
            generation  : v0.admin_generation,
            owner       : arg3,
        };
        0x2::event::emit<AdminCapabilityReissued>(v2);
        configured(v0);
    }

    public fun admin_request_cancellation(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin(v0, arg1, arg4);
        let v1 = ChallengeKey{pos0: arg3};
        let v2 = 0x2::dynamic_field::borrow_mut<ChallengeKey, Challenge>(&mut v0.id, v1);
        assert!(v2.status == 0 && 0x1::option::is_none<u64>(&v2.cancellation_cutoff_ms), 7);
        v2.cancellation_cutoff_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        v2.cancellation_digest = *0x2::tx_context::digest(arg4);
        changed(v0, arg3);
    }

    public fun admin_rotate_operator(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin(v0, arg1, arg3);
        v0.operator_generation = v0.operator_generation + 1;
        if (0x1::option::is_some<address>(&arg2)) {
            let v1 = 0x1::option::destroy_some<address>(arg2);
            assert!(v1 != @0x0, 4);
            let v2 = ChallengeOperatorCap{
                id          : 0x2::object::new(arg3),
                registry_id : 0x2::object::id<Registry>(v0),
                generation  : v0.operator_generation,
                owner       : v1,
            };
            0x2::transfer::transfer<ChallengeOperatorCap>(v2, v1);
        };
        configured(v0);
    }

    public fun admin_schedule_limits(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: &0x2::clock::Clock, arg3: Limits, arg4: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin(v0, arg1, arg4);
        validate_limits(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 <= 18446744073709551615 - 86400000, 4);
        let v2 = v1 + 86400000;
        v0.pending_limits = 0x1::option::some<Limits>(arg3);
        v0.pending_limits_ready_at_ms = 0x1::option::some<u64>(v2);
        let v3 = LimitsChangeScheduled{
            registry_id : 0x2::object::id<Registry>(v0),
            limits      : arg3,
            ready_at_ms : v2,
        };
        0x2::event::emit<LimitsChangeScheduled>(v3);
    }

    public fun admin_set_limits(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: Limits, arg3: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin(v0, arg1, arg3);
        validate_limits(arg2);
        assert!(does_not_increase(arg2, v0.limits), 13);
        v0.limits = arg2;
        v0.pending_limits = 0x1::option::none<Limits>();
        v0.pending_limits_ready_at_ms = 0x1::option::none<u64>();
        configured(v0);
    }

    public fun admin_set_version(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        admin_authority(v0, arg1, arg2);
        assert!(v0.version < 1, 2);
        v0.version = 1;
        configured(v0);
    }

    entry fun award(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeOperatorCap, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: address, arg5: u64, arg6: vector<u8>, arg7: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        operator(v0, arg1, arg7);
        assert!(arg4 != @0x0 && 0x1::vector::length<u8>(&arg6) == 32, 4);
        let v1 = ChallengeKey{pos0: arg3};
        let v2 = 0x2::dynamic_field::borrow_mut<ChallengeKey, Challenge>(&mut v0.id, v1);
        assert!(v2.status == 0 && !v2.cancellation_drained, 7);
        assert!(arg5 >= v2.starts_at_ms && arg5 <= 0x2::clock::timestamp_ms(arg2), 4);
        if (0x1::option::is_some<u64>(&v2.cancellation_cutoff_ms)) {
            assert!(arg5 <= *0x1::option::borrow<u64>(&v2.cancellation_cutoff_ms), 11);
        };
        v2.status = 1;
        v2.winner = 0x1::option::some<address>(arg4);
        v2.proof_hash = arg6;
        v2.completed_at_ms = 0x1::option::some<u64>(arg5);
        v2.awarded_at_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        v2.claim_deadline_tick = 0x1::option::some<u64>(claim_tick(v0, arg2) + 7776000000);
        *0x1::vector::borrow_mut<0x1::option::Option<vector<u8>>>(&mut v0.active_games, v2.game) = 0x1::option::none<vector<u8>>();
        changed(v0, arg3);
    }

    public fun challenge(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: vector<u8>) : &Challenge {
        let v0 = ChallengeKey{pos0: arg1};
        0x2::dynamic_field::borrow<ChallengeKey, Challenge>(&registry(arg0).id, v0)
    }

    fun changed(arg0: &Registry, arg1: vector<u8>) {
        let v0 = ChallengeKey{pos0: arg1};
        let v1 = ChallengeChanged{
            registry_id : 0x2::object::id<Registry>(arg0),
            challenge   : *0x2::dynamic_field::borrow<ChallengeKey, Challenge>(&arg0.id, v0),
        };
        0x2::event::emit<ChallengeChanged>(v1);
    }

    entry fun claim<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        version(v0);
        assert!(v0.coin_type == 0x1::type_name::with_defining_ids<T0>(), 10);
        assert!(0x1::option::is_none<u64>(&v0.claims_paused_at_ms), 3);
        let v1 = ChallengeKey{pos0: arg2};
        let v2 = 0x2::dynamic_field::borrow_mut<ChallengeKey, Challenge>(&mut v0.id, v1);
        assert!(v2.status == 1, 7);
        assert!(*0x1::option::borrow<address>(&v2.winner) == 0x2::tx_context::sender(arg3), 8);
        assert!(claim_tick(v0, arg1) <= *0x1::option::borrow<u64>(&v2.claim_deadline_tick), 9);
        v2.status = 2;
        let v3 = v2.amount;
        v0.outstanding = v0.outstanding - v3;
        changed(v0, arg2);
        configured(v0);
        let v4 = Challenges{dummy: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_from_rakeback_pool<T0, Challenges>(arg0, v4, v3), arg3), 0x2::tx_context::sender(arg3));
    }

    fun claim_tick(arg0: &Registry, arg1: &0x2::clock::Clock) : u64 {
        let v0 = if (0x1::option::is_some<u64>(&arg0.claims_paused_at_ms)) {
            *0x1::option::borrow<u64>(&arg0.claims_paused_at_ms)
        } else {
            0x2::clock::timestamp_ms(arg1)
        };
        v0 - arg0.paused_claim_time_ms
    }

    fun configured(arg0: &Registry) {
        let v0 = RegistryConfigured{
            registry_id          : 0x2::object::id<Registry>(arg0),
            coin_type            : arg0.coin_type,
            limits               : arg0.limits,
            cumulative_created   : arg0.cumulative_created,
            outstanding          : arg0.outstanding,
            operator_generation  : arg0.operator_generation,
            operations_paused    : arg0.operations_paused,
            claims_paused_at_ms  : arg0.claims_paused_at_ms,
            paused_claim_time_ms : arg0.paused_claim_time_ms,
            version              : arg0.version,
        };
        0x2::event::emit<RegistryConfigured>(v0);
    }

    entry fun confirm_cancellation_drained(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeOperatorCap, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        operator(v0, arg1, arg4);
        let v1 = ChallengeKey{pos0: arg2};
        let v2 = 0x2::dynamic_field::borrow_mut<ChallengeKey, Challenge>(&mut v0.id, v1);
        let v3 = if (v2.status == 0) {
            if (0x1::option::is_some<u64>(&v2.cancellation_cutoff_ms)) {
                v2.cancellation_digest == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 11);
        v2.cancellation_drained = true;
        changed(v0, arg2);
    }

    entry fun create(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &ChallengeOperatorCap, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        let v0 = registry_mut(arg0);
        operator(v0, arg1, arg8);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (0x1::vector::length<u8>(&arg3) == 32) {
            if (0x1::vector::length<u8>(&arg4) == 32) {
                if (arg5 < 7) {
                    if (arg6 > 0) {
                        arg7 >= v1
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
        assert!(v2, 4);
        assert!(arg7 - v1 <= 1209600000, 4);
        let v3 = ChallengeKey{pos0: arg3};
        assert!(!0x2::dynamic_field::exists<ChallengeKey>(&v0.id, v3), 6);
        assert!(0x1::option::is_none<vector<u8>>(0x1::vector::borrow<0x1::option::Option<vector<u8>>>(&v0.active_games, arg5)), 12);
        assert!(arg6 <= v0.limits.max_prize, 5);
        headroom(v0.cumulative_created, arg6, v0.limits.cumulative_amount);
        headroom(v0.outstanding, arg6, v0.limits.outstanding_amount);
        let v4 = 0;
        let v5 = 0;
        while (v4 < 0x1::vector::length<Creation>(&v0.recent_creations)) {
            if (v1 - 0x1::vector::borrow<Creation>(&v0.recent_creations, v4).at_ms >= 86400000) {
                0x1::vector::remove<Creation>(&mut v0.recent_creations, v4);
                continue
            };
            v5 = v5 + 0x1::vector::borrow<Creation>(&v0.recent_creations, v4).amount;
            v4 = v4 + 1;
        };
        headroom(v5, arg6, v0.limits.rolling_amount);
        assert!(0x1::vector::length<Creation>(&v0.recent_creations) < v0.limits.rolling_count, 5);
        let v6 = Creation{
            at_ms  : v1,
            amount : arg6,
        };
        0x1::vector::push_back<Creation>(&mut v0.recent_creations, v6);
        v0.cumulative_created = v0.cumulative_created + arg6;
        v0.outstanding = v0.outstanding + arg6;
        *0x1::vector::borrow_mut<0x1::option::Option<vector<u8>>>(&mut v0.active_games, arg5) = 0x1::option::some<vector<u8>>(arg3);
        let v7 = ChallengeKey{pos0: arg3};
        let v8 = Challenge{
            challenge_id           : arg3,
            rule_hash              : arg4,
            game                   : arg5,
            amount                 : arg6,
            starts_at_ms           : arg7,
            status                 : 0,
            winner                 : 0x1::option::none<address>(),
            proof_hash             : b"",
            completed_at_ms        : 0x1::option::none<u64>(),
            awarded_at_ms          : 0x1::option::none<u64>(),
            claim_deadline_tick    : 0x1::option::none<u64>(),
            cancellation_cutoff_ms : 0x1::option::none<u64>(),
            cancellation_digest    : b"",
            cancellation_drained   : false,
        };
        0x2::dynamic_field::add<ChallengeKey, Challenge>(&mut v0.id, v7, v8);
        changed(v0, arg3);
        configured(v0);
    }

    fun does_not_increase(arg0: Limits, arg1: Limits) : bool {
        if (arg0.max_prize <= arg1.max_prize) {
            if (arg0.rolling_amount <= arg1.rolling_amount) {
                if (arg0.rolling_count <= arg1.rolling_count) {
                    if (arg0.outstanding_amount <= arg1.outstanding_amount) {
                        arg0.cumulative_amount <= arg1.cumulative_amount
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
    }

    entry fun expire(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x2::clock::Clock, arg2: vector<u8>) {
        let v0 = registry_mut(arg0);
        version(v0);
        assert!(0x1::option::is_none<u64>(&v0.claims_paused_at_ms), 3);
        let v1 = ChallengeKey{pos0: arg2};
        let v2 = 0x2::dynamic_field::borrow_mut<ChallengeKey, Challenge>(&mut v0.id, v1);
        assert!(v2.status == 1, 7);
        assert!(claim_tick(v0, arg1) > *0x1::option::borrow<u64>(&v2.claim_deadline_tick), 9);
        v2.status = 4;
        v0.outstanding = v0.outstanding - v2.amount;
        changed(v0, arg2);
        configured(v0);
    }

    fun headroom(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 <= arg2 && arg1 <= arg2 - arg0, 5);
    }

    public fun limits(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Limits {
        let v0 = Limits{
            max_prize          : arg0,
            rolling_amount     : arg1,
            rolling_count      : arg2,
            outstanding_amount : arg3,
            cumulative_amount  : arg4,
        };
        validate_limits(v0);
        v0
    }

    fun operator(arg0: &Registry, arg1: &ChallengeOperatorCap, arg2: &0x2::tx_context::TxContext) {
        version(arg0);
        let v0 = if (arg1.registry_id == 0x2::object::id<Registry>(arg0)) {
            if (arg1.generation == arg0.operator_generation) {
                arg1.owner == 0x2::tx_context::sender(arg2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(!arg0.operations_paused, 3);
    }

    public fun pilot_limits() : Limits {
        Limits{
            max_prize          : 100000000,
            rolling_amount     : 250000000,
            rolling_count      : 20,
            outstanding_amount : 1000000000,
            cumulative_amount  : 1000000000,
        }
    }

    public fun registry(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &Registry {
        let v0 = RegistryKey{dummy: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::borrow_operator_dof<Challenges, RegistryKey, Registry>(arg0, v0)
    }

    fun registry_mut(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut Registry {
        let v0 = Challenges{dummy: false};
        let v1 = RegistryKey{dummy: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_borrow_operator_dof_mut<Challenges, RegistryKey, Registry>(arg0, v0, v1)
    }

    fun set_pause(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: bool, arg3: bool) {
        arg0.operations_paused = arg2;
        if (arg3 && 0x1::option::is_none<u64>(&arg0.claims_paused_at_ms)) {
            arg0.claims_paused_at_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
        } else if (!arg3 && 0x1::option::is_some<u64>(&arg0.claims_paused_at_ms)) {
            arg0.paused_claim_time_ms = arg0.paused_claim_time_ms + 0x2::clock::timestamp_ms(arg1) - 0x1::option::extract<u64>(&mut arg0.claims_paused_at_ms);
            arg0.claim_time_credit_until_ms = 0x2::clock::timestamp_ms(arg1);
        };
        configured(arg0);
    }

    fun validate_limits(arg0: Limits) {
        assert!(arg0.max_prize > 0 && arg0.max_prize <= 1000000000, 5);
        assert!(arg0.rolling_amount >= arg0.max_prize && arg0.rolling_amount <= 5000000000, 5);
        assert!(arg0.rolling_count > 0 && arg0.rolling_count <= 100, 5);
        assert!(arg0.outstanding_amount >= arg0.max_prize && arg0.outstanding_amount <= 10000000000, 5);
        assert!(arg0.cumulative_amount >= arg0.outstanding_amount && arg0.cumulative_amount <= 100000000000, 5);
    }

    fun version(arg0: &Registry) {
        assert!(arg0.version == 1, 2);
    }

    // decompiled from Move bytecode v7
}

