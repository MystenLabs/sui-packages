module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events {
    struct CapStored has copy, drop {
        cap_type: 0x1::type_name::TypeName,
        cap_id: 0x2::object::ID,
    }

    struct CapRemoved has copy, drop {
        cap_type: 0x1::type_name::TypeName,
        cap_id: 0x2::object::ID,
    }

    struct UpgradeCapStored has copy, drop {
        cap_id: 0x2::object::ID,
        package: 0x2::object::ID,
    }

    struct UpgradeCommitted has copy, drop {
        cap_id: 0x2::object::ID,
        package: 0x2::object::ID,
        version: u64,
    }

    struct CapStoreMigrated has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct RoleGranted has copy, drop {
        role: 0x1::type_name::TypeName,
        account: address,
    }

    struct RoleRevoked has copy, drop {
        role: 0x1::type_name::TypeName,
        account: address,
    }

    struct GuardianRemovalPending has copy, drop {
        guardian: address,
    }

    struct GuardianRemovalCompleted has copy, drop {
        guardian: address,
    }

    struct RolesFinalized has copy, drop {
        dummy_field: bool,
    }

    struct SetupComplete has copy, drop {
        dummy_field: bool,
    }

    public(friend) fun emit_cap_removed(arg0: 0x1::type_name::TypeName, arg1: 0x2::object::ID) {
        let v0 = CapRemoved{
            cap_type : arg0,
            cap_id   : arg1,
        };
        0x2::event::emit<CapRemoved>(v0);
    }

    public(friend) fun emit_cap_store_migrated(arg0: u64, arg1: u64) {
        let v0 = CapStoreMigrated{
            old_version : arg0,
            new_version : arg1,
        };
        0x2::event::emit<CapStoreMigrated>(v0);
    }

    public(friend) fun emit_cap_stored(arg0: 0x1::type_name::TypeName, arg1: 0x2::object::ID) {
        let v0 = CapStored{
            cap_type : arg0,
            cap_id   : arg1,
        };
        0x2::event::emit<CapStored>(v0);
    }

    public(friend) fun emit_guardian_removal_completed(arg0: address) {
        let v0 = GuardianRemovalCompleted{guardian: arg0};
        0x2::event::emit<GuardianRemovalCompleted>(v0);
    }

    public(friend) fun emit_guardian_removal_pending(arg0: address) {
        let v0 = GuardianRemovalPending{guardian: arg0};
        0x2::event::emit<GuardianRemovalPending>(v0);
    }

    public(friend) fun emit_role_granted(arg0: 0x1::type_name::TypeName, arg1: address) {
        let v0 = RoleGranted{
            role    : arg0,
            account : arg1,
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public(friend) fun emit_role_revoked(arg0: 0x1::type_name::TypeName, arg1: address) {
        let v0 = RoleRevoked{
            role    : arg0,
            account : arg1,
        };
        0x2::event::emit<RoleRevoked>(v0);
    }

    public(friend) fun emit_roles_finalized() {
        let v0 = RolesFinalized{dummy_field: false};
        0x2::event::emit<RolesFinalized>(v0);
    }

    public(friend) fun emit_setup_complete() {
        let v0 = SetupComplete{dummy_field: false};
        0x2::event::emit<SetupComplete>(v0);
    }

    public(friend) fun emit_upgrade_cap_stored(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = UpgradeCapStored{
            cap_id  : arg0,
            package : arg1,
        };
        0x2::event::emit<UpgradeCapStored>(v0);
    }

    public(friend) fun emit_upgrade_committed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = UpgradeCommitted{
            cap_id  : arg0,
            package : arg1,
            version : arg2,
        };
        0x2::event::emit<UpgradeCommitted>(v0);
    }

    // decompiled from Move bytecode v7
}

