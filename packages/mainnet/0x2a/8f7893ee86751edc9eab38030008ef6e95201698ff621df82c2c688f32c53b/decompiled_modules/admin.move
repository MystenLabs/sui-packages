module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin {
    struct PackageUpgradeProposal has store {
        action_hash: vector<u8>,
        package_digest: vector<u8>,
        dependency_digest: vector<u8>,
        policy: u8,
        eta_ms: u64,
        scheduled_at_ms: u64,
    }

    struct UpgradeVault has key {
        id: 0x2::object::UID,
        original_package_id: 0x2::object::ID,
        upgrade_cap: 0x2::package::UpgradeCap,
        min_delay_ms: u64,
        proposals: 0x2::table::Table<vector<u8>, PackageUpgradeProposal>,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
    }

    struct EmergencyPauseCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
    }

    struct TimelockProposal has store {
        action_hash: vector<u8>,
        eta_ms: u64,
    }

    struct GovernanceTimelock<phantom T0> has key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
        min_delay_ms: u64,
        proposals: 0x2::table::Table<vector<u8>, TimelockProposal>,
    }

    struct ProtocolConfig<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        pause_flags: u64,
        expected_chain_identifier: vector<u8>,
        order_domain_package_id: address,
        supported_order_version: u8,
        max_session_key_lifetime_ms: u64,
        max_session_order_notional_e6: u64,
        matcher_public_key: vector<u8>,
        matcher_key_epoch: u64,
        matcher_enabled: bool,
        used_matcher_key_ids: 0x2::table::Table<vector<u8>, bool>,
    }

    struct UpgradeProposerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct UpgradeExecutorCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct UpgradeActionV1 has copy, drop {
        original_package_id: 0x2::object::ID,
        package_digest: vector<u8>,
        dependency_digest: vector<u8>,
        policy: u8,
        eta_ms: u64,
    }

    public fun authorize_upgrade(arg0: &UpgradeExecutorCap, arg1: &mut UpgradeVault, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        assert!(arg0.vault_id == 0x2::object::id<UpgradeVault>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_vault());
        let v0 = upgrade_action_hash(arg1.original_package_id, &arg2, &arg3, arg4, arg5);
        assert!(0x2::table::contains<vector<u8>, PackageUpgradeProposal>(&arg1.proposals, v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::proposal_not_found());
        assert!(0x2::clock::timestamp_ms(arg6) >= arg5, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::timelock_not_elapsed());
        let PackageUpgradeProposal {
            action_hash       : _,
            package_digest    : v2,
            dependency_digest : _,
            policy            : v4,
            eta_ms            : _,
            scheduled_at_ms   : _,
        } = 0x2::table::remove<vector<u8>, PackageUpgradeProposal>(&mut arg1.proposals, v0);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_package_upgrade_authorized(0x2::object::id<UpgradeVault>(arg1), v0);
        0x2::package::authorize_upgrade(&mut arg1.upgrade_cap, v4, v2)
    }

    public fun commit_upgrade(arg0: &UpgradeExecutorCap, arg1: &mut UpgradeVault, arg2: 0x2::package::UpgradeReceipt) {
        assert!(arg0.vault_id == 0x2::object::id<UpgradeVault>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_vault());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_package_upgrade_committed(0x2::object::id<UpgradeVault>(arg1), arg1.original_package_id);
        0x2::package::commit_upgrade(&mut arg1.upgrade_cap, arg2);
    }

    public fun assert_admin<T0>(arg0: &AdminCap<T0>, arg1: &ProtocolConfig<T0>) {
        assert!(arg0.protocol_id == 0x2::object::id<ProtocolConfig<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
    }

    public fun assert_emergency<T0>(arg0: &EmergencyPauseCap<T0>, arg1: &ProtocolConfig<T0>) {
        assert!(arg0.protocol_id == 0x2::object::id<ProtocolConfig<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
    }

    public fun assert_timelock<T0>(arg0: &GovernanceTimelock<T0>, arg1: &ProtocolConfig<T0>) {
        assert!(arg0.protocol_id == 0x2::object::id<ProtocolConfig<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
    }

    fun assert_valid_flag(arg0: u64) {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 8
        };
        assert!(v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_pause_flag());
    }

    fun assert_valid_policy(arg0: u8) {
        let v0 = if (arg0 == 0x2::package::compatible_policy()) {
            true
        } else if (arg0 == 0x2::package::additive_policy()) {
            true
        } else {
            arg0 == 0x2::package::dep_only_policy()
        };
        assert!(v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_policy());
    }

    public fun cancel_timelock_action<T0>(arg0: &AdminCap<T0>, arg1: &ProtocolConfig<T0>, arg2: &mut GovernanceTimelock<T0>, arg3: vector<u8>) {
        assert_admin<T0>(arg0, arg1);
        assert_timelock<T0>(arg2, arg1);
        assert!(0x2::table::contains<vector<u8>, TimelockProposal>(&arg2.proposals, arg3), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::proposal_not_found());
        let TimelockProposal {
            action_hash : _,
            eta_ms      : _,
        } = 0x2::table::remove<vector<u8>, TimelockProposal>(&mut arg2.proposals, arg3);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_timelock_action_cancelled(0x2::object::id<GovernanceTimelock<T0>>(arg2), arg3);
    }

    public fun cancel_upgrade(arg0: &UpgradeProposerCap, arg1: &mut UpgradeVault, arg2: vector<u8>) {
        assert!(arg0.vault_id == 0x2::object::id<UpgradeVault>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_vault());
        assert!(0x2::table::contains<vector<u8>, PackageUpgradeProposal>(&arg1.proposals, arg2), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::proposal_not_found());
        let PackageUpgradeProposal {
            action_hash       : _,
            package_digest    : _,
            dependency_digest : _,
            policy            : _,
            eta_ms            : _,
            scheduled_at_ms   : _,
        } = 0x2::table::remove<vector<u8>, PackageUpgradeProposal>(&mut arg1.proposals, arg2);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_package_upgrade_cancelled(0x2::object::id<UpgradeVault>(arg1), arg2);
    }

    public fun compute_upgrade_action_hash(arg0: &UpgradeVault, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u64) : vector<u8> {
        upgrade_action_hash(arg0.original_package_id, &arg1, &arg2, arg3, arg4)
    }

    public fun consume_timelock_action<T0>(arg0: &AdminCap<T0>, arg1: &ProtocolConfig<T0>, arg2: &mut GovernanceTimelock<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        assert_timelock<T0>(arg2, arg1);
        assert!(0x2::table::contains<vector<u8>, TimelockProposal>(&arg2.proposals, arg3), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::proposal_not_found());
        let TimelockProposal {
            action_hash : _,
            eta_ms      : v1,
        } = 0x2::table::remove<vector<u8>, TimelockProposal>(&mut arg2.proposals, arg3);
        assert!(0x2::clock::timestamp_ms(arg4) >= v1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::timelock_not_elapsed());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_timelock_action_executed(0x2::object::id<GovernanceTimelock<T0>>(arg2), arg3);
    }

    public fun create_protocol<T0>(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 4, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_matcher_key());
        let v0 = 0x2::table::new<vector<u8>, bool>(arg4);
        0x2::table::add<vector<u8>, bool>(&mut v0, 0x2::hash::blake2b256(&arg2), true);
        let v1 = ProtocolConfig<T0>{
            id                            : 0x2::object::new(arg4),
            version                       : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::protocol_version(),
            pause_flags                   : 0,
            expected_chain_identifier     : arg0,
            order_domain_package_id       : arg1,
            supported_order_version       : 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::version::supported_order_version(),
            max_session_key_lifetime_ms   : 604800000,
            max_session_order_notional_e6 : 10000000000,
            matcher_public_key            : arg2,
            matcher_key_epoch             : 1,
            matcher_enabled               : true,
            used_matcher_key_ids          : v0,
        };
        let v2 = 0x2::object::id<ProtocolConfig<T0>>(&v1);
        let v3 = GovernanceTimelock<T0>{
            id           : 0x2::object::new(arg4),
            protocol_id  : v2,
            min_delay_ms : arg3,
            proposals    : 0x2::table::new<vector<u8>, TimelockProposal>(arg4),
        };
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_protocol_created(v2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::registry::create<T0>(v2, arg4), 0x2::object::id<GovernanceTimelock<T0>>(&v3), arg1, 1, 604800000, 10000000000);
        let v4 = AdminCap<T0>{
            id          : 0x2::object::new(arg4),
            protocol_id : v2,
        };
        0x2::transfer::transfer<AdminCap<T0>>(v4, 0x2::tx_context::sender(arg4));
        let v5 = EmergencyPauseCap<T0>{
            id          : 0x2::object::new(arg4),
            protocol_id : v2,
        };
        0x2::transfer::transfer<EmergencyPauseCap<T0>>(v5, 0x2::tx_context::sender(arg4));
        0x2::transfer::share_object<ProtocolConfig<T0>>(v1);
        0x2::transfer::share_object<GovernanceTimelock<T0>>(v3);
    }

    public fun create_upgrade_vault(arg0: 0x2::package::UpgradeCap, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::upgrade_package(&arg0) == arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_package());
        let v0 = UpgradeVault{
            id                  : 0x2::object::new(arg5),
            original_package_id : arg1,
            upgrade_cap         : arg0,
            min_delay_ms        : arg2,
            proposals           : 0x2::table::new<vector<u8>, PackageUpgradeProposal>(arg5),
        };
        let v1 = 0x2::object::id<UpgradeVault>(&v0);
        let v2 = UpgradeProposerCap{
            id       : 0x2::object::new(arg5),
            vault_id : v1,
        };
        0x2::transfer::transfer<UpgradeProposerCap>(v2, arg3);
        let v3 = UpgradeExecutorCap{
            id       : 0x2::object::new(arg5),
            vault_id : v1,
        };
        0x2::transfer::transfer<UpgradeExecutorCap>(v3, arg4);
        0x2::transfer::share_object<UpgradeVault>(v0);
    }

    public fun emergency_invalidate_matcher<T0>(arg0: &EmergencyPauseCap<T0>, arg1: &mut ProtocolConfig<T0>, arg2: u64) {
        assert_emergency<T0>(arg0, arg1);
        assert!(arg1.matcher_key_epoch == arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::epoch_mismatch());
        let v0 = arg1.matcher_key_epoch;
        arg1.matcher_key_epoch = v0 + 1;
        arg1.matcher_enabled = false;
        arg1.pause_flags = arg1.pause_flags | 4;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_matcher_epoch_invalidated(0x2::object::id<ProtocolConfig<T0>>(arg1), v0, v0 + 1, 0x2::hash::blake2b256(&arg1.matcher_public_key));
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_pause_flag_set(0x2::object::id<ProtocolConfig<T0>>(arg1), 4, true, true);
    }

    public fun emergency_set_pause_flag<T0>(arg0: &EmergencyPauseCap<T0>, arg1: &mut ProtocolConfig<T0>, arg2: u64) {
        assert_emergency<T0>(arg0, arg1);
        assert_valid_flag(arg2);
        arg1.pause_flags = arg1.pause_flags | arg2;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_pause_flag_set(0x2::object::id<ProtocolConfig<T0>>(arg1), arg2, true, true);
    }

    public fun expected_chain_identifier<T0>(arg0: &ProtocolConfig<T0>) : vector<u8> {
        arg0.expected_chain_identifier
    }

    public fun is_paused<T0>(arg0: &ProtocolConfig<T0>, arg1: u64) : bool {
        arg0.pause_flags & arg1 != 0
    }

    public fun matcher_enabled<T0>(arg0: &ProtocolConfig<T0>) : bool {
        arg0.matcher_enabled
    }

    public fun matcher_key_epoch<T0>(arg0: &ProtocolConfig<T0>) : u64 {
        arg0.matcher_key_epoch
    }

    public fun matcher_public_key<T0>(arg0: &ProtocolConfig<T0>) : vector<u8> {
        arg0.matcher_public_key
    }

    public fun max_session_key_lifetime_ms<T0>(arg0: &ProtocolConfig<T0>) : u64 {
        arg0.max_session_key_lifetime_ms
    }

    public fun max_session_order_notional_e6<T0>(arg0: &ProtocolConfig<T0>) : u64 {
        arg0.max_session_order_notional_e6
    }

    public fun order_domain_package_id<T0>(arg0: &ProtocolConfig<T0>) : address {
        arg0.order_domain_package_id
    }

    public fun pause_deposit_and_split_flag() : u64 {
        2
    }

    public fun pause_market_creation_flag() : u64 {
        1
    }

    public fun pause_resolution_flag() : u64 {
        8
    }

    public fun pause_settlement_flag() : u64 {
        4
    }

    public fun proposer_cap_vault_id(arg0: &UpgradeProposerCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun raise_pause_flag_internal<T0>(arg0: &mut ProtocolConfig<T0>, arg1: u64) {
        arg0.pause_flags = arg0.pause_flags | arg1;
    }

    public fun rotate_matcher_key<T0>(arg0: &AdminCap<T0>, arg1: &mut ProtocolConfig<T0>, arg2: u64, arg3: vector<u8>) {
        assert_admin<T0>(arg0, arg1);
        assert!(arg1.matcher_key_epoch == arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::epoch_mismatch());
        assert!(0x1::vector::length<u8>(&arg3) == 32, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_matcher_key());
        let v0 = 0x2::hash::blake2b256(&arg3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.used_matcher_key_ids, v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::matcher_key_reused());
        0x2::table::add<vector<u8>, bool>(&mut arg1.used_matcher_key_ids, v0, true);
        let v1 = arg1.matcher_key_epoch;
        arg1.matcher_public_key = arg3;
        arg1.matcher_key_epoch = v1 + 1;
        arg1.matcher_enabled = true;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_matcher_key_rotated(0x2::object::id<ProtocolConfig<T0>>(arg1), v1, v1 + 1, 0x2::hash::blake2b256(&arg1.matcher_public_key), v0, true);
    }

    public fun schedule_timelock_action<T0>(arg0: &AdminCap<T0>, arg1: &ProtocolConfig<T0>, arg2: &mut GovernanceTimelock<T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        assert_timelock<T0>(arg2, arg1);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg5) + arg2.min_delay_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_eta());
        assert!(!0x2::table::contains<vector<u8>, TimelockProposal>(&arg2.proposals, arg3), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::proposal_exists());
        let v0 = TimelockProposal{
            action_hash : arg3,
            eta_ms      : arg4,
        };
        0x2::table::add<vector<u8>, TimelockProposal>(&mut arg2.proposals, arg3, v0);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_timelock_action_scheduled(0x2::object::id<GovernanceTimelock<T0>>(arg2), arg3, arg4);
    }

    public fun schedule_upgrade(arg0: &UpgradeProposerCap, arg1: &mut UpgradeVault, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(arg0.vault_id == 0x2::object::id<UpgradeVault>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_vault());
        assert_valid_policy(arg4);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg5 >= v0 + arg1.min_delay_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_eta());
        let v1 = upgrade_action_hash(arg1.original_package_id, &arg2, &arg3, arg4, arg5);
        assert!(!0x2::table::contains<vector<u8>, PackageUpgradeProposal>(&arg1.proposals, v1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::proposal_exists());
        let v2 = PackageUpgradeProposal{
            action_hash       : v1,
            package_digest    : arg2,
            dependency_digest : arg3,
            policy            : arg4,
            eta_ms            : arg5,
            scheduled_at_ms   : v0,
        };
        0x2::table::add<vector<u8>, PackageUpgradeProposal>(&mut arg1.proposals, v1, v2);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_package_upgrade_scheduled(0x2::object::id<UpgradeVault>(arg1), arg1.original_package_id, v1, arg5);
    }

    public(friend) fun set_matcher_state<T0>(arg0: &mut ProtocolConfig<T0>, arg1: vector<u8>, arg2: u64, arg3: bool) {
        arg0.matcher_public_key = arg1;
        arg0.matcher_key_epoch = arg2;
        arg0.matcher_enabled = arg3;
    }

    public fun set_pause_flag<T0>(arg0: &AdminCap<T0>, arg1: &mut ProtocolConfig<T0>, arg2: u64, arg3: bool) {
        assert_admin<T0>(arg0, arg1);
        assert_valid_flag(arg2);
        if (arg3) {
            arg1.pause_flags = arg1.pause_flags | arg2;
        } else {
            if (arg2 == 4) {
                assert!(arg1.matcher_enabled, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::matcher_disabled());
            };
            arg1.pause_flags = arg1.pause_flags & (arg2 ^ 18446744073709551615);
        };
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_pause_flag_set(0x2::object::id<ProtocolConfig<T0>>(arg1), arg2, arg3, false);
    }

    public fun supported_order_version<T0>(arg0: &ProtocolConfig<T0>) : u8 {
        arg0.supported_order_version
    }

    fun upgrade_action_hash(arg0: 0x2::object::ID, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u8, arg4: u64) : vector<u8> {
        let v0 = UpgradeActionV1{
            original_package_id : arg0,
            package_digest      : *arg1,
            dependency_digest   : *arg2,
            policy              : arg3,
            eta_ms              : arg4,
        };
        let v1 = 0x2::bcs::to_bytes<UpgradeActionV1>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    public(friend) fun used_matcher_key_ids_mut<T0>(arg0: &mut ProtocolConfig<T0>) : &mut 0x2::table::Table<vector<u8>, bool> {
        &mut arg0.used_matcher_key_ids
    }

    // decompiled from Move bytecode v7
}

