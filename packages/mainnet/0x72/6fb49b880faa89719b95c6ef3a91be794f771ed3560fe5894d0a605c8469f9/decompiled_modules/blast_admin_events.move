module 0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_admin_events {
    struct AdminGranted has copy, drop {
        admin_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct AdminRevoked has copy, drop {
        admin_cap_id: 0x2::object::ID,
        roles: vector<0x1::type_name::TypeName>,
    }

    struct AdminRoleGranted has copy, drop {
        admin_cap_id: 0x2::object::ID,
        role: 0x1::type_name::TypeName,
    }

    struct AdminRoleRevoked has copy, drop {
        admin_cap_id: 0x2::object::ID,
        role: 0x1::type_name::TypeName,
    }

    struct AdminDestroyed has copy, drop {
        admin_cap_id: 0x2::object::ID,
        roles: vector<0x1::type_name::TypeName>,
        was_active: bool,
    }

    struct SuperAdminTransferStarted has copy, drop {
        recipient: address,
        execute_after_ms: u64,
    }

    struct SuperAdminTransferCancelled has copy, drop {
        recipient: address,
        execute_after_ms: u64,
    }

    struct SuperAdminTransferred has copy, drop {
        previous_super_admin_cap_id: 0x2::object::ID,
        new_super_admin_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct SuperAdminCapDestroyed has copy, drop {
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

    public(friend) fun admin_destroyed(arg0: 0x2::object::ID, arg1: vector<0x1::type_name::TypeName>, arg2: bool) {
        let v0 = AdminDestroyed{
            admin_cap_id : arg0,
            roles        : arg1,
            was_active   : arg2,
        };
        0x2::event::emit<AdminDestroyed>(v0);
    }

    public(friend) fun admin_granted(arg0: 0x2::object::ID, arg1: address) {
        let v0 = AdminGranted{
            admin_cap_id : arg0,
            recipient    : arg1,
        };
        0x2::event::emit<AdminGranted>(v0);
    }

    public(friend) fun admin_revoked(arg0: 0x2::object::ID, arg1: vector<0x1::type_name::TypeName>) {
        let v0 = AdminRevoked{
            admin_cap_id : arg0,
            roles        : arg1,
        };
        0x2::event::emit<AdminRevoked>(v0);
    }

    public(friend) fun admin_role_granted(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName) {
        let v0 = AdminRoleGranted{
            admin_cap_id : arg0,
            role         : arg1,
        };
        0x2::event::emit<AdminRoleGranted>(v0);
    }

    public(friend) fun admin_role_revoked(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName) {
        let v0 = AdminRoleRevoked{
            admin_cap_id : arg0,
            role         : arg1,
        };
        0x2::event::emit<AdminRoleRevoked>(v0);
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

    public(friend) fun super_admin_cap_destroyed(arg0: 0x2::object::ID) {
        let v0 = SuperAdminCapDestroyed{super_admin_cap_id: arg0};
        0x2::event::emit<SuperAdminCapDestroyed>(v0);
    }

    public(friend) fun super_admin_transfer_cancelled(arg0: address, arg1: u64) {
        let v0 = SuperAdminTransferCancelled{
            recipient        : arg0,
            execute_after_ms : arg1,
        };
        0x2::event::emit<SuperAdminTransferCancelled>(v0);
    }

    public(friend) fun super_admin_transfer_started(arg0: address, arg1: u64) {
        let v0 = SuperAdminTransferStarted{
            recipient        : arg0,
            execute_after_ms : arg1,
        };
        0x2::event::emit<SuperAdminTransferStarted>(v0);
    }

    public(friend) fun super_admin_transferred(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = SuperAdminTransferred{
            previous_super_admin_cap_id : arg0,
            new_super_admin_cap_id      : arg1,
            recipient                   : arg2,
        };
        0x2::event::emit<SuperAdminTransferred>(v0);
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

