module 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_upgrade {
    struct UpgradeGovernanceAdminCap has store, key {
        id: 0x2::object::UID,
        governance_id: 0x2::object::ID,
    }

    struct PendingUpgrade has drop, store {
        digest: vector<u8>,
        policy: u8,
        proposed_at_ms: u64,
    }

    struct UpgradeGovernance has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        timelock_ms: u64,
        cap: 0x2::package::UpgradeCap,
        pending: 0x1::option::Option<PendingUpgrade>,
        nonce: u64,
    }

    public fun authorize_upgrade(arg0: &mut UpgradeGovernance, arg1: &UpgradeGovernanceAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(0x1::option::is_some<PendingUpgrade>(&arg0.pending), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::no_pending_upgrade());
        let v0 = 0x1::option::extract<PendingUpgrade>(&mut arg0.pending);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.proposed_at_ms + arg0.timelock_ms, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::upgrade_timelock_active());
        let PendingUpgrade {
            digest         : v2,
            policy         : v3,
            proposed_at_ms : _,
        } = v0;
        let v5 = v2;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_upgrade_authorized(0x2::object::id<UpgradeGovernance>(arg0), v3, 0x1::vector::length<u8>(&v5), v1);
        0x2::package::authorize_upgrade(&mut arg0.cap, v3, v5)
    }

    public fun commit_upgrade(arg0: &mut UpgradeGovernance, arg1: &UpgradeGovernanceAdminCap, arg2: 0x2::package::UpgradeReceipt, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg4);
        0x2::package::commit_upgrade(&mut arg0.cap, arg2);
        arg0.nonce = arg0.nonce + 1;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_upgrade_committed(0x2::object::id<UpgradeGovernance>(arg0), arg0.nonce, 0x2::package::receipt_package(&arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun version() : u64 {
        1
    }

    public fun admin(arg0: &UpgradeGovernance) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &UpgradeGovernance, arg1: &UpgradeGovernanceAdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.governance_id == 0x2::object::id<UpgradeGovernance>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::wrong_governance());
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
    }

    fun assert_version(arg0: &UpgradeGovernance) {
        assert!(arg0.version == 1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::wrong_version());
    }

    public fun cancel_upgrade(arg0: &mut UpgradeGovernance, arg1: &UpgradeGovernanceAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(0x1::option::is_some<PendingUpgrade>(&arg0.pending), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::no_pending_upgrade());
        0x1::option::extract<PendingUpgrade>(&mut arg0.pending);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_upgrade_cancelled(0x2::object::id<UpgradeGovernance>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    public fun cap_package(arg0: &UpgradeGovernance) : 0x2::object::ID {
        0x2::package::upgrade_package(&arg0.cap)
    }

    public fun cap_policy(arg0: &UpgradeGovernance) : u8 {
        0x2::package::upgrade_policy(&arg0.cap)
    }

    public fun cap_version(arg0: &UpgradeGovernance) : u64 {
        0x2::package::version(&arg0.cap)
    }

    public fun governance_version(arg0: &UpgradeGovernance) : u64 {
        arg0.version
    }

    public fun is_pending(arg0: &UpgradeGovernance) : bool {
        0x1::option::is_some<PendingUpgrade>(&arg0.pending)
    }

    public fun migrate(arg0: &mut UpgradeGovernance, arg1: &UpgradeGovernanceAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg3);
        let v0 = arg0.version;
        assert!(v0 < 1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        arg0.version = 1;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_object_migrated(0x2::object::id<UpgradeGovernance>(arg0), v0, 1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun nonce(arg0: &UpgradeGovernance) : u64 {
        arg0.nonce
    }

    public fun pending_digest_length(arg0: &UpgradeGovernance) : u64 {
        if (0x1::option::is_some<PendingUpgrade>(&arg0.pending)) {
            0x1::vector::length<u8>(&0x1::option::borrow<PendingUpgrade>(&arg0.pending).digest)
        } else {
            0
        }
    }

    public fun pending_policy(arg0: &UpgradeGovernance) : u8 {
        assert!(0x1::option::is_some<PendingUpgrade>(&arg0.pending), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::no_pending_upgrade());
        0x1::option::borrow<PendingUpgrade>(&arg0.pending).policy
    }

    public fun pending_proposed_at_ms(arg0: &UpgradeGovernance) : u64 {
        assert!(0x1::option::is_some<PendingUpgrade>(&arg0.pending), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::no_pending_upgrade());
        0x1::option::borrow<PendingUpgrade>(&arg0.pending).proposed_at_ms
    }

    public fun propose_upgrade(arg0: &mut UpgradeGovernance, arg1: &UpgradeGovernanceAdminCap, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg5);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        assert!(0x1::option::is_none<PendingUpgrade>(&arg0.pending), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::upgrade_already_pending());
        assert!(arg2 >= 0x2::package::upgrade_policy(&arg0.cap), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::upgrade_policy_too_permissive());
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = PendingUpgrade{
            digest         : arg3,
            policy         : arg2,
            proposed_at_ms : v0,
        };
        arg0.pending = 0x1::option::some<PendingUpgrade>(v1);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_upgrade_proposed(0x2::object::id<UpgradeGovernance>(arg0), arg2, pending_digest_length(arg0), v0);
    }

    public fun restrict_policy(arg0: &mut UpgradeGovernance, arg1: &UpgradeGovernanceAdminCap, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        if (arg2 == 0x2::package::additive_policy()) {
            0x2::package::only_additive_upgrades(&mut arg0.cap);
        } else {
            assert!(arg2 == 0x2::package::dep_only_policy(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
            0x2::package::only_dep_upgrades(&mut arg0.cap);
        };
    }

    public fun set_timelock_secs(arg0: &mut UpgradeGovernance, arg1: &UpgradeGovernanceAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        arg0.timelock_ms = arg2 * 1000;
    }

    public fun timelock_secs(arg0: &UpgradeGovernance) : u64 {
        arg0.timelock_ms / 1000
    }

    public fun transfer_admin(arg0: &mut UpgradeGovernance, arg1: &UpgradeGovernanceAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        arg0.admin = arg2;
    }

    public fun wrap(arg0: 0x2::package::UpgradeCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : UpgradeGovernanceAdminCap {
        let v0 = UpgradeGovernance{
            id          : 0x2::object::new(arg3),
            version     : 1,
            admin       : arg1,
            timelock_ms : arg2 * 1000,
            cap         : arg0,
            pending     : 0x1::option::none<PendingUpgrade>(),
            nonce       : 0,
        };
        0x2::transfer::share_object<UpgradeGovernance>(v0);
        UpgradeGovernanceAdminCap{
            id            : 0x2::object::new(arg3),
            governance_id : 0x2::object::id<UpgradeGovernance>(&v0),
        }
    }

    // decompiled from Move bytecode v7
}

