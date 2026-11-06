module 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_admin_events {
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

    struct SuperAdminTransferred has copy, drop {
        previous_super_admin_cap_id: 0x2::object::ID,
        new_super_admin_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct SuperAdminCapDestroyed has copy, drop {
        super_admin_cap_id: 0x2::object::ID,
    }

    struct VersionAdvanced<phantom T0: drop> has copy, drop {
        container_id: 0x2::object::ID,
        original_package_id: address,
        previous_version: u64,
        new_version: u64,
    }

    struct PackageVersionCreated<phantom T0: drop> has copy, drop {
        package_version_id: 0x2::object::ID,
        package_admin_id: 0x2::object::ID,
        valid_pause_bits: u8,
        paused: u8,
        package_witness: 0x1::type_name::TypeName,
        version: u64,
    }

    struct PackageAdminCreated<phantom T0: drop> has copy, drop {
        package_admin_id: 0x2::object::ID,
        publisher_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        original_package_id: 0x2::object::ID,
        upgrade_cap_version: u64,
        policy: u8,
    }

    struct UpgradeAuthorized<phantom T0: drop> has copy, drop {
        package_admin_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        current_package_id: 0x2::object::ID,
        upgrade_cap_version: u64,
        policy: u8,
        digest: vector<u8>,
    }

    struct UpgradeCommitted<phantom T0: drop> has copy, drop {
        package_admin_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        original_package_id: address,
        new_package_id: 0x2::object::ID,
        previous_upgrade_cap_version: u64,
        new_upgrade_cap_version: u64,
    }

    struct UpgradeCapDestroyed<phantom T0: drop> has copy, drop {
        package_admin_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        original_package_id: address,
        final_upgrade_cap_version: u64,
        final_policy: u8,
    }

    struct Paused<phantom T0: drop> has copy, drop {
        package_version_id: 0x2::object::ID,
        bits: u8,
        paused: u8,
    }

    struct Unpaused<phantom T0: drop> has copy, drop {
        package_version_id: 0x2::object::ID,
        bits: u8,
        paused: u8,
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

    public(friend) fun package_admin_created<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u8) {
        let v0 = PackageAdminCreated<T0>{
            package_admin_id    : arg0,
            publisher_id        : arg1,
            upgrade_cap_id      : arg2,
            original_package_id : arg3,
            upgrade_cap_version : arg4,
            policy              : arg5,
        };
        0x2::event::emit<PackageAdminCreated<T0>>(v0);
    }

    public(friend) fun package_version_created<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u8, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = PackageVersionCreated<T0>{
            package_version_id : arg0,
            package_admin_id   : arg1,
            valid_pause_bits   : arg2,
            paused             : arg3,
            package_witness    : arg4,
            version            : arg5,
        };
        0x2::event::emit<PackageVersionCreated<T0>>(v0);
    }

    public(friend) fun paused<T0: drop>(arg0: 0x2::object::ID, arg1: u8, arg2: u8) {
        let v0 = Paused<T0>{
            package_version_id : arg0,
            bits               : arg1,
            paused             : arg2,
        };
        0x2::event::emit<Paused<T0>>(v0);
    }

    public(friend) fun super_admin_cap_destroyed(arg0: 0x2::object::ID) {
        let v0 = SuperAdminCapDestroyed{super_admin_cap_id: arg0};
        0x2::event::emit<SuperAdminCapDestroyed>(v0);
    }

    public(friend) fun super_admin_transferred(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = SuperAdminTransferred{
            previous_super_admin_cap_id : arg0,
            new_super_admin_cap_id      : arg1,
            recipient                   : arg2,
        };
        0x2::event::emit<SuperAdminTransferred>(v0);
    }

    public(friend) fun unpaused<T0: drop>(arg0: 0x2::object::ID, arg1: u8, arg2: u8) {
        let v0 = Unpaused<T0>{
            package_version_id : arg0,
            bits               : arg1,
            paused             : arg2,
        };
        0x2::event::emit<Unpaused<T0>>(v0);
    }

    public(friend) fun upgrade_authorized<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u8, arg5: vector<u8>) {
        let v0 = UpgradeAuthorized<T0>{
            package_admin_id    : arg0,
            upgrade_cap_id      : arg1,
            current_package_id  : arg2,
            upgrade_cap_version : arg3,
            policy              : arg4,
            digest              : arg5,
        };
        0x2::event::emit<UpgradeAuthorized<T0>>(v0);
    }

    public(friend) fun upgrade_cap_destroyed<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u8) {
        let v0 = UpgradeCapDestroyed<T0>{
            package_admin_id          : arg0,
            upgrade_cap_id            : arg1,
            original_package_id       : arg2,
            final_upgrade_cap_version : arg3,
            final_policy              : arg4,
        };
        0x2::event::emit<UpgradeCapDestroyed<T0>>(v0);
    }

    public(friend) fun upgrade_committed<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let v0 = UpgradeCommitted<T0>{
            package_admin_id             : arg0,
            upgrade_cap_id               : arg1,
            original_package_id          : arg2,
            new_package_id               : arg3,
            previous_upgrade_cap_version : arg4,
            new_upgrade_cap_version      : arg5,
        };
        0x2::event::emit<UpgradeCommitted<T0>>(v0);
    }

    public(friend) fun version_advanced<T0: drop>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = VersionAdvanced<T0>{
            container_id        : arg0,
            original_package_id : arg1,
            previous_version    : arg2,
            new_version         : arg3,
        };
        0x2::event::emit<VersionAdvanced<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

