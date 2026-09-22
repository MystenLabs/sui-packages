module 0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events {
    struct AuthorityCreated<phantom T0: drop> has copy, drop {
        authority_id: 0x2::object::ID,
        super_admin_cap_id: 0x2::object::ID,
        recipient: address,
        max_admins: u64,
        root_transfer_delay_ms: u64,
    }

    struct AdminGranted<phantom T0: drop> has copy, drop {
        authority_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        roles: u64,
        recipient: address,
    }

    struct AdminRevoked<phantom T0: drop> has copy, drop {
        authority_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        previous_roles: u64,
    }

    struct AdminRoleGranted<phantom T0: drop> has copy, drop {
        authority_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        role: u64,
        previous_roles: u64,
        new_roles: u64,
    }

    struct AdminRoleRevoked<phantom T0: drop> has copy, drop {
        authority_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        role: u64,
        previous_roles: u64,
        new_roles: u64,
    }

    struct AdminDestroyed<phantom T0: drop> has copy, drop {
        authority_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        previous_roles: u64,
        was_active: bool,
    }

    struct SuperAdminTransferStarted<phantom T0: drop> has copy, drop {
        authority_id: 0x2::object::ID,
        recipient: address,
        execute_after_ms: u64,
    }

    struct SuperAdminTransferCancelled<phantom T0: drop> has copy, drop {
        authority_id: 0x2::object::ID,
        recipient: address,
        execute_after_ms: u64,
    }

    struct SuperAdminTransferred<phantom T0: drop> has copy, drop {
        authority_id: 0x2::object::ID,
        previous_super_admin_cap_id: 0x2::object::ID,
        new_super_admin_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct SuperAdminCapDestroyed<phantom T0: drop> has copy, drop {
        authority_id: 0x2::object::ID,
        super_admin_cap_id: 0x2::object::ID,
    }

    struct OperationalVersionAdvanced<phantom T0: drop> has copy, drop {
        container_id: 0x2::object::ID,
        package_id: address,
        previous_generation: u64,
        new_generation: u64,
    }

    struct UpgradeCustodyCreated<phantom T0: drop> has copy, drop {
        custodian_id: 0x2::object::ID,
        publisher_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        native_version: u64,
        policy: u8,
    }

    struct UpgradeAuthorized<phantom T0: drop> has copy, drop {
        custodian_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        native_version: u64,
        policy: u8,
        digest: vector<u8>,
    }

    struct UpgradeCommitted<phantom T0: drop> has copy, drop {
        custodian_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        original_package_id: address,
        new_package_id: 0x2::object::ID,
        previous_native_version: u64,
        new_native_version: u64,
    }

    struct UpgradePolicyRestricted<phantom T0: drop> has copy, drop {
        custodian_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        package_id: address,
        native_version: u64,
        previous_policy: u8,
        new_policy: u8,
    }

    struct UpgradeCapDestroyed<phantom T0: drop> has copy, drop {
        custodian_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        package_id: address,
        final_native_version: u64,
        final_policy: u8,
    }

    public(friend) fun admin_destroyed<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: bool) {
        let v0 = AdminDestroyed<T0>{
            authority_id   : arg0,
            admin_cap_id   : arg1,
            previous_roles : arg2,
            was_active     : arg3,
        };
        0x2::event::emit<AdminDestroyed<T0>>(v0);
    }

    public(friend) fun admin_granted<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address) {
        let v0 = AdminGranted<T0>{
            authority_id : arg0,
            admin_cap_id : arg1,
            roles        : arg2,
            recipient    : arg3,
        };
        0x2::event::emit<AdminGranted<T0>>(v0);
    }

    public(friend) fun admin_revoked<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = AdminRevoked<T0>{
            authority_id   : arg0,
            admin_cap_id   : arg1,
            previous_roles : arg2,
        };
        0x2::event::emit<AdminRevoked<T0>>(v0);
    }

    public(friend) fun admin_role_granted<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = AdminRoleGranted<T0>{
            authority_id   : arg0,
            admin_cap_id   : arg1,
            role           : arg2,
            previous_roles : arg3,
            new_roles      : arg4,
        };
        0x2::event::emit<AdminRoleGranted<T0>>(v0);
    }

    public(friend) fun admin_role_revoked<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = AdminRoleRevoked<T0>{
            authority_id   : arg0,
            admin_cap_id   : arg1,
            role           : arg2,
            previous_roles : arg3,
            new_roles      : arg4,
        };
        0x2::event::emit<AdminRoleRevoked<T0>>(v0);
    }

    public(friend) fun authority_created<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = AuthorityCreated<T0>{
            authority_id           : arg0,
            super_admin_cap_id     : arg1,
            recipient              : arg2,
            max_admins             : arg3,
            root_transfer_delay_ms : arg4,
        };
        0x2::event::emit<AuthorityCreated<T0>>(v0);
    }

    public(friend) fun operational_version_advanced<T0: drop>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = OperationalVersionAdvanced<T0>{
            container_id        : arg0,
            package_id          : arg1,
            previous_generation : arg2,
            new_generation      : arg3,
        };
        0x2::event::emit<OperationalVersionAdvanced<T0>>(v0);
    }

    public(friend) fun super_admin_cap_destroyed<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = SuperAdminCapDestroyed<T0>{
            authority_id       : arg0,
            super_admin_cap_id : arg1,
        };
        0x2::event::emit<SuperAdminCapDestroyed<T0>>(v0);
    }

    public(friend) fun super_admin_transfer_cancelled<T0: drop>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = SuperAdminTransferCancelled<T0>{
            authority_id     : arg0,
            recipient        : arg1,
            execute_after_ms : arg2,
        };
        0x2::event::emit<SuperAdminTransferCancelled<T0>>(v0);
    }

    public(friend) fun super_admin_transfer_started<T0: drop>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = SuperAdminTransferStarted<T0>{
            authority_id     : arg0,
            recipient        : arg1,
            execute_after_ms : arg2,
        };
        0x2::event::emit<SuperAdminTransferStarted<T0>>(v0);
    }

    public(friend) fun super_admin_transferred<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) {
        let v0 = SuperAdminTransferred<T0>{
            authority_id                : arg0,
            previous_super_admin_cap_id : arg1,
            new_super_admin_cap_id      : arg2,
            recipient                   : arg3,
        };
        0x2::event::emit<SuperAdminTransferred<T0>>(v0);
    }

    public(friend) fun upgrade_authorized<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u8, arg5: vector<u8>) {
        let v0 = UpgradeAuthorized<T0>{
            custodian_id   : arg0,
            upgrade_cap_id : arg1,
            package_id     : arg2,
            native_version : arg3,
            policy         : arg4,
            digest         : arg5,
        };
        0x2::event::emit<UpgradeAuthorized<T0>>(v0);
    }

    public(friend) fun upgrade_cap_destroyed<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u8) {
        let v0 = UpgradeCapDestroyed<T0>{
            custodian_id         : arg0,
            upgrade_cap_id       : arg1,
            package_id           : arg2,
            final_native_version : arg3,
            final_policy         : arg4,
        };
        0x2::event::emit<UpgradeCapDestroyed<T0>>(v0);
    }

    public(friend) fun upgrade_committed<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let v0 = UpgradeCommitted<T0>{
            custodian_id            : arg0,
            upgrade_cap_id          : arg1,
            original_package_id     : arg2,
            new_package_id          : arg3,
            previous_native_version : arg4,
            new_native_version      : arg5,
        };
        0x2::event::emit<UpgradeCommitted<T0>>(v0);
    }

    public(friend) fun upgrade_custody_created<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u8) {
        let v0 = UpgradeCustodyCreated<T0>{
            custodian_id   : arg0,
            publisher_id   : arg1,
            upgrade_cap_id : arg2,
            package_id     : arg3,
            native_version : arg4,
            policy         : arg5,
        };
        0x2::event::emit<UpgradeCustodyCreated<T0>>(v0);
    }

    public(friend) fun upgrade_policy_restricted<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u8, arg5: u8) {
        let v0 = UpgradePolicyRestricted<T0>{
            custodian_id    : arg0,
            upgrade_cap_id  : arg1,
            package_id      : arg2,
            native_version  : arg3,
            previous_policy : arg4,
            new_policy      : arg5,
        };
        0x2::event::emit<UpgradePolicyRestricted<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

