module 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config {
    struct StakingConfig has store, key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct StakingConfigInner has store {
        registry_id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        pools: 0x2::table::Table<u64, bool>,
        unstaking_delay_ms: u64,
        signer_public_key: vector<u8>,
        chain_id: u64,
        paused: bool,
        migrated_v1_receipts: 0x2::table::Table<address, bool>,
        reward_vault_id: 0x1::option::Option<0x2::object::ID>,
        penalty_vault_id: 0x1::option::Option<0x2::object::ID>,
        emergency_penalty_bps: u64,
    }

    public fun add_pool(arg0: &mut StakingConfig, arg1: u64, arg2: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        0x2::table::add<u64, bool>(&mut load_inner_mut(arg0).pools, arg1, true);
    }

    public fun disable_version(arg0: &mut StakingConfig, arg1: u64, arg2: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        let v0 = 0x2::versioned::load_value_mut<StakingConfigInner>(&mut arg0.inner);
        assert!(arg1 != 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 0);
        0x2::vec_set::remove<u64>(&mut v0.allowed_versions, &arg1);
    }

    public fun enable_version(arg0: &mut StakingConfig, arg1: u64, arg2: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        let v0 = 0x2::versioned::load_value_mut<StakingConfigInner>(&mut arg0.inner);
        assert!(!0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 0);
        0x2::vec_set::insert<u64>(&mut v0.allowed_versions, arg1);
    }

    public fun get_chain_id(arg0: &StakingConfig) : u64 {
        load_inner(arg0).chain_id
    }

    public fun get_emergency_penalty_bps(arg0: &StakingConfig) : u64 {
        load_inner(arg0).emergency_penalty_bps
    }

    public fun get_penalty_vault_id(arg0: &StakingConfig) : 0x2::object::ID {
        let v0 = load_inner(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0.penalty_vault_id), 6);
        *0x1::option::borrow<0x2::object::ID>(&v0.penalty_vault_id)
    }

    public fun get_reward_vault_id(arg0: &StakingConfig) : 0x2::object::ID {
        let v0 = load_inner(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0.reward_vault_id), 5);
        *0x1::option::borrow<0x2::object::ID>(&v0.reward_vault_id)
    }

    public fun get_signer_public_key(arg0: &StakingConfig) : vector<u8> {
        load_inner(arg0).signer_public_key
    }

    public fun get_unstaking_delay_ms(arg0: &StakingConfig) : u64 {
        load_inner(arg0).unstaking_delay_ms
    }

    public fun initialize_registry(arg0: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingConfigInner{
            registry_id           : 0x2::object::new(arg1),
            allowed_versions      : 0x2::vec_set::empty<u64>(),
            pools                 : 0x2::table::new<u64, bool>(arg1),
            unstaking_delay_ms    : 0,
            signer_public_key     : b"",
            chain_id              : 0,
            paused                : true,
            migrated_v1_receipts  : 0x2::table::new<address, bool>(arg1),
            reward_vault_id       : 0x1::option::none<0x2::object::ID>(),
            penalty_vault_id      : 0x1::option::none<0x2::object::ID>(),
            emergency_penalty_bps : 3000,
        };
        let v1 = StakingConfig{
            id    : 0x2::object::new(arg1),
            inner : 0x2::versioned::create<StakingConfigInner>(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), v0, arg1),
        };
        0x2::transfer::public_share_object<StakingConfig>(v1);
    }

    public fun is_migrated_v1_receipt(arg0: &StakingConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&load_inner(arg0).migrated_v1_receipts, arg1)
    }

    public fun is_pool_exists(arg0: &StakingConfig, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&load_inner(arg0).pools, arg1)
    }

    public(friend) fun load_inner(arg0: &StakingConfig) : &StakingConfigInner {
        let v0 = 0x2::versioned::load_value<StakingConfigInner>(&arg0.inner);
        let v1 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version();
        assert!(!v0.paused, 2);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 0);
        v0
    }

    public(friend) fun load_inner_mut(arg0: &mut StakingConfig) : &mut StakingConfigInner {
        let v0 = 0x2::versioned::load_value_mut<StakingConfigInner>(&mut arg0.inner);
        let v1 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version();
        assert!(!v0.paused, 2);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 0);
        v0
    }

    public(friend) fun mark_migrated_v1_receipt(arg0: &mut StakingConfig, arg1: address) {
        let v0 = load_inner_mut(arg0);
        assert!(!0x2::table::contains<address, bool>(&v0.migrated_v1_receipts, arg1), 4);
        0x2::table::add<address, bool>(&mut v0.migrated_v1_receipts, arg1, true);
    }

    public fun pause(arg0: &mut StakingConfig, arg1: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        let v0 = 0x2::versioned::load_value_mut<StakingConfigInner>(&mut arg0.inner);
        assert!(!v0.paused, 1);
        v0.paused = true;
    }

    public fun remove_pool(arg0: &mut StakingConfig, arg1: u64, arg2: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        0x2::table::remove<u64, bool>(&mut load_inner_mut(arg0).pools, arg1);
    }

    public fun set_chain_id(arg0: &mut StakingConfig, arg1: u64, arg2: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        load_inner_mut(arg0).chain_id = arg1;
    }

    public fun set_emergency_penalty_bps(arg0: &mut StakingConfig, arg1: u64, arg2: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        assert!(arg1 <= 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::basis_points_denominator(), 7);
        load_inner_mut(arg0).emergency_penalty_bps = arg1;
    }

    public fun set_penalty_vault_id(arg0: &mut StakingConfig, arg1: 0x2::object::ID, arg2: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        load_inner_mut(arg0).penalty_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun set_reward_vault_id(arg0: &mut StakingConfig, arg1: 0x2::object::ID, arg2: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        load_inner_mut(arg0).reward_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun set_signer_public_key(arg0: &mut StakingConfig, arg1: vector<u8>, arg2: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        load_inner_mut(arg0).signer_public_key = arg1;
    }

    public fun set_unstaking_delay_ms(arg0: &mut StakingConfig, arg1: u64, arg2: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        load_inner_mut(arg0).unstaking_delay_ms = arg1;
    }

    public fun unpause(arg0: &mut StakingConfig, arg1: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap) {
        let v0 = 0x2::versioned::load_value_mut<StakingConfigInner>(&mut arg0.inner);
        assert!(v0.paused, 3);
        v0.paused = false;
    }

    // decompiled from Move bytecode v6
}

