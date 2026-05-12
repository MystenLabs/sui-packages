module 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access {
    struct RoleRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        super_admins: 0x2::vec_set::VecSet<address>,
        admins: 0x2::vec_set::VecSet<address>,
        treasury_admins: 0x2::vec_set::VecSet<address>,
        oracles: 0x2::vec_set::VecSet<address>,
        creators: 0x2::vec_set::VecSet<address>,
        blacklist: 0x2::vec_set::VecSet<address>,
    }

    struct RoleGranted has copy, drop {
        role_type: u8,
        role_name: vector<u8>,
        target_address: address,
        granted_by: address,
        timestamp: u64,
    }

    struct RoleRevoked has copy, drop {
        role_type: u8,
        role_name: vector<u8>,
        target_address: address,
        revoked_by: address,
        timestamp: u64,
    }

    struct AddressBlacklisted has copy, drop {
        target_address: address,
        reason: vector<u8>,
        blacklisted_by: address,
        timestamp: u64,
    }

    struct AddressUnblacklisted has copy, drop {
        target_address: address,
        unblacklisted_by: address,
        timestamp: u64,
    }

    public fun admin_count(arg0: &RoleRegistry) : u64 {
        0x2::vec_set::length<address>(&arg0.admins)
    }

    public fun assert_admin(arg0: &RoleRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(has_pause_authority(arg0, 0x2::tx_context::sender(arg1)), 1);
    }

    public fun assert_not_blacklisted(arg0: &RoleRegistry, arg1: address) {
        assert!(!is_blacklisted(arg0, arg1), 7);
    }

    public fun assert_operations(arg0: &RoleRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(has_operations_authority(arg0, 0x2::tx_context::sender(arg1)), 1);
    }

    public fun assert_oracle(arg0: &RoleRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(has_oracle_authority(arg0, 0x2::tx_context::sender(arg1)), 1);
    }

    public fun assert_super_admin(arg0: &RoleRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(is_super_admin(arg0, 0x2::tx_context::sender(arg1)), 1);
    }

    public fun assert_treasury(arg0: &RoleRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(has_treasury_authority(arg0, 0x2::tx_context::sender(arg1)), 1);
    }

    public fun blacklist_address(arg0: &mut RoleRegistry, arg1: address, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(!0x2::vec_set::contains<address>(&arg0.blacklist, &arg1), 5);
        0x2::vec_set::insert<address>(&mut arg0.blacklist, arg1);
        let v0 = AddressBlacklisted{
            target_address : arg1,
            reason         : arg2,
            blacklisted_by : 0x2::tx_context::sender(arg3),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<AddressBlacklisted>(v0);
    }

    public fun blacklist_count(arg0: &RoleRegistry) : u64 {
        0x2::vec_set::length<address>(&arg0.blacklist)
    }

    public fun creator_count(arg0: &RoleRegistry) : u64 {
        0x2::vec_set::length<address>(&arg0.creators)
    }

    public fun grant_admin(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.admins, &arg1), 2);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
        let v0 = RoleGranted{
            role_type      : 1,
            role_name      : b"Admin",
            target_address : arg1,
            granted_by     : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_creator(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.creators, &arg1), 2);
        0x2::vec_set::insert<address>(&mut arg0.creators, arg1);
        let v0 = RoleGranted{
            role_type      : 4,
            role_name      : b"Creator",
            target_address : arg1,
            granted_by     : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_oracle(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.oracles, &arg1), 2);
        0x2::vec_set::insert<address>(&mut arg0.oracles, arg1);
        let v0 = RoleGranted{
            role_type      : 3,
            role_name      : b"Oracle",
            target_address : arg1,
            granted_by     : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_super_admin(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.super_admins, &arg1), 2);
        0x2::vec_set::insert<address>(&mut arg0.super_admins, arg1);
        let v0 = RoleGranted{
            role_type      : 0,
            role_name      : b"SuperAdmin",
            target_address : arg1,
            granted_by     : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun grant_treasury_admin(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.treasury_admins, &arg1), 2);
        0x2::vec_set::insert<address>(&mut arg0.treasury_admins, arg1);
        let v0 = RoleGranted{
            role_type      : 2,
            role_name      : b"Treasury",
            target_address : arg1,
            granted_by     : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun has_creator_authority(arg0: &RoleRegistry, arg1: address) : bool {
        is_super_admin(arg0, arg1) || is_creator(arg0, arg1)
    }

    public fun has_operations_authority(arg0: &RoleRegistry, arg1: address) : bool {
        if (is_super_admin(arg0, arg1)) {
            true
        } else if (is_admin(arg0, arg1)) {
            true
        } else {
            is_oracle(arg0, arg1)
        }
    }

    public fun has_oracle_authority(arg0: &RoleRegistry, arg1: address) : bool {
        is_super_admin(arg0, arg1) || is_oracle(arg0, arg1)
    }

    public fun has_pause_authority(arg0: &RoleRegistry, arg1: address) : bool {
        is_super_admin(arg0, arg1) || is_admin(arg0, arg1)
    }

    public fun has_treasury_authority(arg0: &RoleRegistry, arg1: address) : bool {
        is_super_admin(arg0, arg1) || is_treasury_admin(arg0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = RoleRegistry{
            id              : 0x2::object::new(arg0),
            version         : 1,
            super_admins    : v1,
            admins          : 0x2::vec_set::empty<address>(),
            treasury_admins : 0x2::vec_set::empty<address>(),
            oracles         : 0x2::vec_set::empty<address>(),
            creators        : 0x2::vec_set::empty<address>(),
            blacklist       : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<RoleRegistry>(v2);
        let v3 = RoleGranted{
            role_type      : 0,
            role_name      : b"SuperAdmin",
            target_address : v0,
            granted_by     : v0,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<RoleGranted>(v3);
    }

    public fun is_admin(arg0: &RoleRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_blacklisted(arg0: &RoleRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.blacklist, &arg1)
    }

    public fun is_creator(arg0: &RoleRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.creators, &arg1)
    }

    public fun is_oracle(arg0: &RoleRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.oracles, &arg1)
    }

    public fun is_super_admin(arg0: &RoleRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.super_admins, &arg1)
    }

    public fun is_treasury_admin(arg0: &RoleRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.treasury_admins, &arg1)
    }

    public fun oracle_count(arg0: &RoleRegistry) : u64 {
        0x2::vec_set::length<address>(&arg0.oracles)
    }

    public fun revoke_admin(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg1), 3);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
        let v0 = RoleRevoked{
            role_type      : 1,
            role_name      : b"Admin",
            target_address : arg1,
            revoked_by     : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RoleRevoked>(v0);
    }

    public fun revoke_creator(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.creators, &arg1), 3);
        0x2::vec_set::remove<address>(&mut arg0.creators, &arg1);
        let v0 = RoleRevoked{
            role_type      : 4,
            role_name      : b"Creator",
            target_address : arg1,
            revoked_by     : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RoleRevoked>(v0);
    }

    public fun revoke_oracle(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.oracles, &arg1), 3);
        0x2::vec_set::remove<address>(&mut arg0.oracles, &arg1);
        let v0 = RoleRevoked{
            role_type      : 3,
            role_name      : b"Oracle",
            target_address : arg1,
            revoked_by     : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RoleRevoked>(v0);
    }

    public fun revoke_super_admin(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.super_admins, &arg1), 3);
        assert!(0x2::vec_set::length<address>(&arg0.super_admins) > 1, 4);
        0x2::vec_set::remove<address>(&mut arg0.super_admins, &arg1);
        let v0 = RoleRevoked{
            role_type      : 0,
            role_name      : b"SuperAdmin",
            target_address : arg1,
            revoked_by     : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RoleRevoked>(v0);
    }

    public fun revoke_treasury_admin(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.treasury_admins, &arg1), 3);
        0x2::vec_set::remove<address>(&mut arg0.treasury_admins, &arg1);
        let v0 = RoleRevoked{
            role_type      : 2,
            role_name      : b"Treasury",
            target_address : arg1,
            revoked_by     : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RoleRevoked>(v0);
    }

    public fun role_type_admin() : u8 {
        1
    }

    public fun role_type_creator() : u8 {
        4
    }

    public fun role_type_oracle() : u8 {
        3
    }

    public fun role_type_super_admin() : u8 {
        0
    }

    public fun role_type_treasury() : u8 {
        2
    }

    public fun super_admin_count(arg0: &RoleRegistry) : u64 {
        0x2::vec_set::length<address>(&arg0.super_admins)
    }

    public fun treasury_admin_count(arg0: &RoleRegistry) : u64 {
        0x2::vec_set::length<address>(&arg0.treasury_admins)
    }

    public fun unblacklist_address(arg0: &mut RoleRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.blacklist, &arg1), 6);
        0x2::vec_set::remove<address>(&mut arg0.blacklist, &arg1);
        let v0 = AddressUnblacklisted{
            target_address   : arg1,
            unblacklisted_by : 0x2::tx_context::sender(arg2),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<AddressUnblacklisted>(v0);
    }

    // decompiled from Move bytecode v7
}

