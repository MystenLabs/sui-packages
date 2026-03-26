module 0x4e81e10468d711de57a71173f33a2ad6877229c31470ffcc1d26552554d4be5c::multisig {
    struct ConfigWitness has drop {
        dummy_field: bool,
    }

    struct MigrateConfig has drop {
        dummy_field: bool,
    }

    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct ProposedConfigKey has copy, drop, store {
        intent_key: 0x1::string::String,
    }

    struct MultisigAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MultisigFeeVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct MultisigConfig has copy, drop, store {
        members: vector<Member>,
        global_threshold: u64,
        execution_timelock_ms: u64,
        intent_expiry_ms: u64,
        config_nonce: u64,
    }

    struct Member has copy, drop, store {
        addr: address,
        weight: u64,
        permissions: u8,
    }

    struct Approvals has copy, drop, store {
        config_nonce: u64,
        status: u8,
        total_weight: u64,
        cancel_weight: u64,
        approved_at_ms: u64,
        approved: 0x2::vec_set::VecSet<address>,
        rejected: 0x2::vec_set::VecSet<address>,
        cancelled: 0x2::vec_set::VecSet<address>,
    }

    struct AccountCreatedEvent has copy, drop {
        account_addr: address,
        creator: address,
    }

    struct ConfigChangedEvent has copy, drop {
        account_addr: address,
        members: vector<address>,
        weights: vector<u64>,
        permissions: vector<u8>,
        global_threshold: u64,
        execution_timelock_ms: u64,
        intent_expiry_ms: u64,
        config_nonce: u64,
    }

    struct IntentCreatedEvent has copy, drop {
        account_addr: address,
        key: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
    }

    struct IntentExecutedEvent has copy, drop {
        account_addr: address,
        key: 0x1::string::String,
        executor: address,
    }

    public fun addresses(arg0: &MultisigConfig) : vector<address> {
        let v0 = &arg0.members;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Member>(v0)) {
            0x1::vector::push_back<address>(&mut v1, 0x1::vector::borrow<Member>(v0, v2).addr);
            v2 = v2 + 1;
        };
        v1
    }

    public fun approve_intent(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = *0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0);
        assert!(is_member(&v0, 0x2::tx_context::sender(arg3)), 1);
        let v1 = member(&v0, 0x2::tx_context::sender(arg3));
        assert!(has_permission(&v1, 2), 15);
        let v2 = ConfigWitness{dummy_field: false};
        let v3 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::outcome_mut<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::get_mut<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v2), arg1));
        assert!(v3.config_nonce == v0.config_nonce, 19);
        assert!(v3.status == 0, 27);
        let v4 = 0x2::tx_context::sender(arg3);
        if (0x2::vec_set::contains<address>(&v3.rejected, &v4)) {
            let v5 = 0x2::tx_context::sender(arg3);
            0x2::vec_set::remove<address>(&mut v3.rejected, &v5);
        };
        let v6 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::vec_set::contains<address>(&v3.approved, &v6), 5);
        0x2::vec_set::insert<address>(&mut v3.approved, 0x2::tx_context::sender(arg3));
        v3.total_weight = v3.total_weight + v1.weight;
        if (v3.total_weight >= v0.global_threshold) {
            v3.status = 1;
            v3.approved_at_ms = 0x2::clock::timestamp_ms(arg2);
        };
    }

    public fun approved(arg0: &Approvals) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.approved)
    }

    public fun approved_at_ms(arg0: &Approvals) : u64 {
        arg0.approved_at_ms
    }

    fun assert_compatible_intent_policy(arg0: u64, arg1: u64) {
        assert_valid_intent_expiry_ms(arg1);
        assert!(arg0 < arg1, 47);
    }

    fun assert_intent_matches_config_policy(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<Approvals>) {
        let v0 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0);
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::execution_times<Approvals>(arg1);
        assert!(0x1::vector::length<u64>(&v1) == 1, 44);
        let v2 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::expiration_time<Approvals>(arg1);
        assert!(v2 > 0, 45);
        assert!(v2 == 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::creation_time<Approvals>(arg1) + v0.intent_expiry_ms, 45);
        assert!(*0x1::vector::borrow<u64>(&v1, 0) < v2, 45);
    }

    fun assert_no_orphaned_config_data(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String) {
        let v0 = ProposedConfigKey{intent_key: arg1};
        assert!(!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<ProposedConfigKey>(arg0, v0), 41);
    }

    public(friend) fun assert_sender_can_propose(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: address) {
        let v0 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0);
        assert!(is_member(v0, arg1), 1);
        let v1 = member(v0, arg1);
        assert!(has_permission(&v1, 1), 14);
    }

    fun assert_valid_intent_expiry_ms(arg0: u64) {
        assert!(arg0 > 0, 46);
    }

    public fun authenticate(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Auth {
        assert_sender_can_propose(arg0, 0x2::tx_context::sender(arg1));
        let v0 = ConfigWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::new_auth<MultisigConfig, ConfigWitness>(arg0, v0)
    }

    fun can_still_reach_threshold(arg0: &MultisigConfig, arg1: &0x2::vec_set::VecSet<address>) : bool {
        let v0 = 0;
        let v1 = &arg0.members;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Member>(v1)) {
            let v3 = 0x1::vector::borrow<Member>(v1, v2);
            if (has_permission(v3, 2) && !0x2::vec_set::contains<address>(arg1, &v3.addr)) {
                v0 = v0 + v3.weight;
            };
            v2 = v2 + 1;
        };
        v0 >= arg0.global_threshold
    }

    public fun cancel_expired_intent(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired {
        let v0 = cancel_expired_intent_inner(arg0, arg1, arg2, arg3);
        assert_no_orphaned_config_data(arg0, arg1);
        v0
    }

    public(friend) fun cancel_expired_intent_for_cleanup(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired {
        cancel_expired_intent_inner(arg0, arg1, arg2, arg3)
    }

    fun cancel_expired_intent_inner(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired {
        let v0 = ConfigWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::delete_expired_intent<Approvals, ConfigWitness>(arg0, arg1, arg2, v0, arg3)
    }

    public fun cancel_pending_intent(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired> {
        let v0 = cancel_pending_intent_inner(arg0, arg1, arg2);
        if (0x1::option::is_some<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired>(&v0)) {
            assert_no_orphaned_config_data(arg0, arg1);
        };
        v0
    }

    public(friend) fun cancel_pending_intent_for_cleanup(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired> {
        cancel_pending_intent_inner(arg0, arg1, arg2)
    }

    fun cancel_pending_intent_inner(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired> {
        let v0 = *0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0);
        assert!(is_member(&v0, 0x2::tx_context::sender(arg2)), 1);
        let v1 = member(&v0, 0x2::tx_context::sender(arg2));
        assert!(has_permission(&v1, 2), 15);
        let v2 = ConfigWitness{dummy_field: false};
        let v3 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::outcome_mut<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::get_mut<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v2), arg1));
        assert!(v3.status == 1, 27);
        sync_cancel_votes(v3, &v0);
        let v4 = if (v3.cancel_weight >= v0.global_threshold) {
            v3.status = 3;
            true
        } else {
            let v5 = 0x2::tx_context::sender(arg2);
            if (0x2::vec_set::contains<address>(&v3.cancelled, &v5)) {
                false
            } else {
                0x2::vec_set::insert<address>(&mut v3.cancelled, 0x2::tx_context::sender(arg2));
                v3.cancel_weight = v3.cancel_weight + v1.weight;
                if (v3.cancel_weight >= v0.global_threshold) {
                    v3.status = 3;
                    true
                } else {
                    false
                }
            }
        };
        if (!v4) {
            return 0x1::option::none<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired>()
        };
        let v6 = ConfigWitness{dummy_field: false};
        0x1::option::some<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::cancel_intent<Approvals, ConfigWitness>(arg0, arg1, v6, arg2))
    }

    public fun cancel_rejected_intent(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired {
        let v0 = cancel_rejected_intent_inner(arg0, arg1, arg2);
        assert_no_orphaned_config_data(arg0, arg1);
        v0
    }

    public(friend) fun cancel_rejected_intent_for_cleanup(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired {
        cancel_rejected_intent_inner(arg0, arg1, arg2)
    }

    fun cancel_rejected_intent_inner(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired {
        let v0 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0);
        assert!(is_member(v0, 0x2::tx_context::sender(arg2)), 1);
        let v1 = member(v0, 0x2::tx_context::sender(arg2));
        assert!(has_permission(&v1, 2), 15);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::outcome<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::get<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::intents(arg0), arg1)).status == 2, 27);
        let v2 = ConfigWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::cancel_intent<Approvals, ConfigWitness>(arg0, arg1, v2, arg2)
    }

    public fun cancel_stale_intent(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired {
        let v0 = cancel_stale_intent_inner(arg0, arg1, arg2);
        assert_no_orphaned_config_data(arg0, arg1);
        v0
    }

    public(friend) fun cancel_stale_intent_for_cleanup(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired {
        cancel_stale_intent_inner(arg0, arg1, arg2)
    }

    fun cancel_stale_intent_inner(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Expired {
        let v0 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0);
        assert!(is_member(v0, 0x2::tx_context::sender(arg2)), 1);
        let v1 = member(v0, 0x2::tx_context::sender(arg2));
        assert!(has_permission(&v1, 2), 15);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::outcome<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::get<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::intents(arg0), arg1)).config_nonce != v0.config_nonce, 20);
        let v2 = ConfigWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::cancel_intent<Approvals, ConfigWitness>(arg0, arg1, v2, arg2)
    }

    public fun cancel_weight(arg0: &Approvals) : u64 {
        arg0.cancel_weight
    }

    public fun cancelled(arg0: &Approvals) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.cancelled)
    }

    public fun config_nonce(arg0: &MultisigConfig) : u64 {
        arg0.config_nonce
    }

    public fun disapprove_intent(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = *0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0);
        assert!(is_member(&v0, 0x2::tx_context::sender(arg2)), 1);
        let v1 = member(&v0, 0x2::tx_context::sender(arg2));
        assert!(has_permission(&v1, 2), 15);
        let v2 = ConfigWitness{dummy_field: false};
        let v3 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::outcome_mut<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::get_mut<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v2), arg1));
        assert!(v3.config_nonce == v0.config_nonce, 19);
        assert!(v3.status == 0, 27);
        let v4 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&v3.approved, &v4), 4);
        let v5 = 0x2::tx_context::sender(arg2);
        0x2::vec_set::remove<address>(&mut v3.approved, &v5);
        v3.total_weight = v3.total_weight - v1.weight;
    }

    public(friend) fun emit_config_changed(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account) {
        let v0 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = b"";
        let v4 = &v0.members;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Member>(v4)) {
            let v6 = 0x1::vector::borrow<Member>(v4, v5);
            0x1::vector::push_back<address>(&mut v1, v6.addr);
            0x1::vector::push_back<u64>(&mut v2, v6.weight);
            0x1::vector::push_back<u8>(&mut v3, v6.permissions);
            v5 = v5 + 1;
        };
        let v7 = ConfigChangedEvent{
            account_addr          : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg0),
            members               : v1,
            weights               : v2,
            permissions           : v3,
            global_threshold      : v0.global_threshold,
            execution_timelock_ms : v0.execution_timelock_ms,
            intent_expiry_ms      : v0.intent_expiry_ms,
            config_nonce          : v0.config_nonce,
        };
        0x2::event::emit<ConfigChangedEvent>(v7);
    }

    public(friend) fun emit_intent_created(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address) {
        let v0 = IntentCreatedEvent{
            account_addr : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg0),
            key          : arg1,
            description  : arg2,
            creator      : arg3,
        };
        0x2::event::emit<IntentCreatedEvent>(v0);
    }

    public fun execute_intent(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<Approvals> {
        let v0 = *0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0);
        assert!(is_member(&v0, 0x2::tx_context::sender(arg4)), 1);
        let v1 = member(&v0, 0x2::tx_context::sender(arg4));
        assert!(has_permission(&v1, 4), 16);
        let v2 = ConfigWitness{dummy_field: false};
        let v3 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::outcome_mut<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::get_mut<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v2), arg2));
        assert!(v3.config_nonce == v0.config_nonce, 19);
        assert!(v3.total_weight >= v0.global_threshold, 3);
        assert!(v3.status == 1, 27);
        assert!(0x2::clock::timestamp_ms(arg3) >= v3.approved_at_ms && 0x2::clock::timestamp_ms(arg3) - v3.approved_at_ms >= v0.execution_timelock_ms, 28);
        v3.status = 4;
        let v4 = IntentExecutedEvent{
            account_addr : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg0),
            key          : arg2,
            executor     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<IntentExecutedEvent>(v4);
        let v5 = ConfigWitness{dummy_field: false};
        let (_, v7) = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::create_executable<MultisigConfig, Approvals, ConfigWitness>(arg0, arg1, arg2, arg3, v5, arg4);
        v7
    }

    public fun execute_migrate_config<T0: copy + drop + store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<Approvals>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T0) : MultisigConfig {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<Approvals>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<Approvals>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<Approvals>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<MigrateConfig>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 36);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)) == 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::key<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<Approvals>(arg0)), 38);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 39);
        let v2 = 0x2::bcs::to_bytes<T0>(&arg3);
        assert!(0x2::hash::blake2b256(&v2) == 0x2::bcs::peel_vec_u8(&mut v1), 37);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())) == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)), 40);
        let v3 = ConfigWitness{dummy_field: false};
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<Approvals, MigrateConfig, ExecutionProgressWitness>(arg0, arg2, v4);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::migrate_config<MultisigConfig, ConfigWitness, T0, T1>(arg1, arg2, v3, arg3)
    }

    public fun execution_timelock_ms(arg0: &MultisigConfig) : u64 {
        arg0.execution_timelock_ms
    }

    public fun get_member_idx(arg0: &MultisigConfig, arg1: address) : u64 {
        let v0 = &arg0.members;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Member>(v0)) {
            if (0x1::vector::borrow<Member>(v0, v1).addr == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 0);
                return 0x1::option::destroy_some<u64>(v2)
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun global_threshold(arg0: &MultisigConfig) : u64 {
        arg0.global_threshold
    }

    public fun has_permission(arg0: &Member, arg1: u8) : bool {
        arg0.permissions & arg1 == arg1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MultisigAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MultisigAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MultisigFeeVault{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MultisigFeeVault>(v1);
    }

    public fun intent_expiry_ms(arg0: &MultisigConfig) : u64 {
        arg0.intent_expiry_ms
    }

    public fun is_member(arg0: &MultisigConfig, arg1: address) : bool {
        let v0 = &arg0.members;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Member>(v0)) {
            if (0x1::vector::borrow<Member>(v0, v1).addr == arg1) {
                v2 = true;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = false;
        v2
    }

    public fun max_action_specs_per_intent() : u64 {
        10
    }

    public fun max_members() : u64 {
        200
    }

    public fun member(arg0: &MultisigConfig, arg1: address) : Member {
        *0x1::vector::borrow<Member>(&arg0.members, get_member_idx(arg0, arg1))
    }

    public fun member_addr(arg0: &Member) : address {
        arg0.addr
    }

    public fun members(arg0: &MultisigConfig) : &vector<Member> {
        &arg0.members
    }

    public fun multisig_creation_fee() : u64 {
        100000000
    }

    public fun new_account(arg0: &mut MultisigFeeVault, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 100000000, 29);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 100000000, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v0 = Member{
            addr        : 0x2::tx_context::sender(arg5),
            weight      : 1,
            permissions : 1 | 2 | 4,
        };
        let v1 = 0x1::vector::empty<Member>();
        0x1::vector::push_back<Member>(&mut v1, v0);
        let v2 = MultisigConfig{
            members               : v1,
            global_threshold      : 1,
            execution_timelock_ms : 0,
            intent_expiry_ms      : 604800000,
            config_nonce          : 0,
        };
        let v3 = ConfigWitness{dummy_field: false};
        let v4 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::new<MultisigConfig, ConfigWitness>(v2, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::metadata::from_keys_values(arg3, arg4), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::new(arg1), v3, arg5);
        let v5 = AccountCreatedEvent{
            account_addr : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(&v4),
            creator      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<AccountCreatedEvent>(v5);
        v4
    }

    public(friend) fun new_config(arg0: vector<address>, arg1: vector<u64>, arg2: vector<u8>, arg3: u64) : MultisigConfig {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 6);
        assert!(v0 == 0x1::vector::length<u8>(&arg2), 6);
        assert!(v0 <= 200, 32);
        assert!(arg3 > 0, 9);
        let v1 = 0x2::vec_set::empty<address>();
        0x1::vector::reverse<address>(&mut arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0)) {
            let v3 = 0x1::vector::pop_back<address>(&mut arg0);
            assert!(!0x2::vec_set::contains<address>(&v1, &v3), 10);
            0x2::vec_set::insert<address>(&mut v1, v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(arg0);
        0x1::vector::reverse<u8>(&mut arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&arg2)) {
            let v5 = 0x1::vector::pop_back<u8>(&mut arg2);
            assert!(v5 > 0 && v5 <= 7, 17);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u8>(arg2);
        let v6 = false;
        let v7 = false;
        let v8 = false;
        0x1::vector::reverse<u8>(&mut arg2);
        let v9 = 0;
        while (v9 < 0x1::vector::length<u8>(&arg2)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg2);
            if (v10 & 1 == 1) {
                v6 = true;
            };
            if (v10 & 2 == 2) {
                v7 = true;
            };
            if (v10 & 4 == 4) {
                v8 = true;
            };
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<u8>(arg2);
        assert!(v6, 11);
        assert!(v7, 12);
        assert!(v8, 13);
        let v11 = 0;
        let v12 = 0;
        while (v12 < v0) {
            if (*0x1::vector::borrow<u8>(&arg2, v12) & 2 == 2) {
                assert!(*0x1::vector::borrow<u64>(&arg1, v12) > 0, 23);
                v11 = v11 + *0x1::vector::borrow<u64>(&arg1, v12);
            };
            v12 = v12 + 1;
        };
        assert!(v11 >= arg3, 8);
        let v13 = 0x1::vector::empty<Member>();
        let v14 = 0;
        while (v14 < v0) {
            let v15 = Member{
                addr        : *0x1::vector::borrow<address>(&arg0, v14),
                weight      : *0x1::vector::borrow<u64>(&arg1, v14),
                permissions : *0x1::vector::borrow<u8>(&arg2, v14),
            };
            0x1::vector::push_back<Member>(&mut v13, v15);
            v14 = v14 + 1;
        };
        let v16 = MultisigConfig{
            members               : v13,
            global_threshold      : arg3,
            execution_timelock_ms : 0,
            intent_expiry_ms      : 604800000,
            config_nonce          : 0,
        };
        assert_compatible_intent_policy(v16.execution_timelock_ms, v16.intent_expiry_ms);
        v16
    }

    public(friend) fun new_config_with_policy(arg0: vector<address>, arg1: vector<u64>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64) : MultisigConfig {
        assert_compatible_intent_policy(arg4, arg5);
        let v0 = new_config(arg0, arg1, arg2, arg3);
        v0.execution_timelock_ms = arg4;
        v0.intent_expiry_ms = arg5;
        v0
    }

    public(friend) fun new_config_with_timelock(arg0: vector<address>, arg1: vector<u64>, arg2: vector<u8>, arg3: u64, arg4: u64) : MultisigConfig {
        new_config_with_policy(arg0, arg1, arg2, arg3, arg4, 604800000)
    }

    public fun new_migrate_config() : MigrateConfig {
        MigrateConfig{dummy_field: false}
    }

    public fun new_outcome(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account) : Approvals {
        Approvals{
            config_nonce   : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0).config_nonce,
            status         : 0,
            total_weight   : 0,
            cancel_weight  : 0,
            approved_at_ms : 0,
            approved       : 0x2::vec_set::empty<address>(),
            rejected       : 0x2::vec_set::empty<address>(),
            cancelled      : 0x2::vec_set::empty<address>(),
        }
    }

    public fun new_params_from_config(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Params {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg3);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::new_params(arg1, arg2, v0, 0x2::clock::timestamp_ms(arg4) + 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0).intent_expiry_ms, arg4, arg5)
    }

    public fun new_proposed_config_key(arg0: 0x1::string::String) : ProposedConfigKey {
        ProposedConfigKey{intent_key: arg0}
    }

    public fun outcome_config_nonce(arg0: &Approvals) : u64 {
        arg0.config_nonce
    }

    public fun outcome_status(arg0: &Approvals) : u8 {
        arg0.status
    }

    public fun permission_execute() : u8 {
        4
    }

    public fun permission_propose() : u8 {
        1
    }

    public fun permission_vote() : u8 {
        2
    }

    public fun permissions(arg0: &Member) : u8 {
        arg0.permissions
    }

    public fun reject_intent(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = *0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::config<MultisigConfig>(arg0);
        assert!(is_member(&v0, 0x2::tx_context::sender(arg2)), 1);
        let v1 = member(&v0, 0x2::tx_context::sender(arg2));
        assert!(has_permission(&v1, 2), 15);
        let v2 = ConfigWitness{dummy_field: false};
        let v3 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::outcome_mut<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::get_mut<Approvals>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v2), arg1));
        assert!(v3.config_nonce == v0.config_nonce, 19);
        assert!(v3.status == 0, 27);
        let v4 = 0x2::tx_context::sender(arg2);
        if (0x2::vec_set::contains<address>(&v3.approved, &v4)) {
            let v5 = 0x2::tx_context::sender(arg2);
            0x2::vec_set::remove<address>(&mut v3.approved, &v5);
            v3.total_weight = v3.total_weight - v1.weight;
        };
        let v6 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::vec_set::contains<address>(&v3.rejected, &v6), 25);
        0x2::vec_set::insert<address>(&mut v3.rejected, 0x2::tx_context::sender(arg2));
        if (!can_still_reach_threshold(&v0, &v3.rejected)) {
            v3.status = 2;
        };
    }

    public fun rejected(arg0: &Approvals) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.rejected)
    }

    public(friend) fun set_config_nonce(arg0: &mut MultisigConfig, arg1: u64) {
        arg0.config_nonce = arg1;
    }

    public(friend) fun set_intent_expiry_ms(arg0: &mut MultisigConfig, arg1: u64) {
        assert_compatible_intent_policy(arg0.execution_timelock_ms, arg1);
        arg0.intent_expiry_ms = arg1;
    }

    public fun share(arg0: 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::share_account(arg0);
    }

    public fun stage_intent<T0: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<Approvals>, arg3: 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::version_witness::VersionWitness, arg4: T0, arg5: &0x2::tx_context::TxContext) {
        assert_sender_can_propose(arg0, 0x2::tx_context::sender(arg5));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::assert_package_authorized(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::deps(arg0), arg1, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::account_deps(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::version_witness::package_addr(&arg3), 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg0));
        let v0 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_count<Approvals>(&arg2);
        assert!(v0 > 0, 31);
        assert!(v0 <= 10, 30);
        assert_intent_matches_config_policy(arg0, &arg2);
        let v1 = ConfigWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::insert_intent<MultisigConfig, Approvals, ConfigWitness, T0>(arg0, arg1, arg2, v1, arg4);
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_approved() : u8 {
        1
    }

    public fun status_cancelled() : u8 {
        3
    }

    public fun status_executed() : u8 {
        4
    }

    public fun status_rejected() : u8 {
        2
    }

    public fun sweep_fees(arg0: &MultisigAdminCap, arg1: &mut MultisigFeeVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        if (v0 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    fun sync_cancel_votes(arg0: &mut Approvals, arg1: &MultisigConfig) {
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0;
        let v2 = *0x2::vec_set::keys<address>(&arg0.cancelled);
        0x1::vector::reverse<address>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v2)) {
            let v4 = 0x1::vector::pop_back<address>(&mut v2);
            if (is_member(arg1, v4)) {
                let v5 = member(arg1, v4);
                if (has_permission(&v5, 2)) {
                    0x2::vec_set::insert<address>(&mut v0, v4);
                    v1 = v1 + v5.weight;
                };
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<address>(v2);
        arg0.cancelled = v0;
        arg0.cancel_weight = v1;
    }

    public fun total_weight(arg0: &Approvals) : u64 {
        arg0.total_weight
    }

    public fun vault_balance(arg0: &MultisigFeeVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun weight(arg0: &Member) : u64 {
        arg0.weight
    }

    public(friend) fun witness() : ConfigWitness {
        ConfigWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

