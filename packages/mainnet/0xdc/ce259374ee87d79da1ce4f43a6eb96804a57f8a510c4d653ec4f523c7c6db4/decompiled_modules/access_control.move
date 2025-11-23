module 0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::access_control {
    struct AccessControlCap has key {
        id: 0x2::object::UID,
        admins: 0x2::table::Table<address, bool>,
        verifiers: 0x2::table::Table<address, bool>,
    }

    struct RoleGranted has copy, drop {
        role: u8,
        account: address,
        granted_by: address,
    }

    struct RoleRevoked has copy, drop {
        role: u8,
        account: address,
        revoked_by: address,
    }

    public entry fun grant_role(arg0: &mut AccessControlCap, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin_internal(arg0, v0), 4000);
        assert!(arg1 <= 2, 4001);
        if (arg1 == 0) {
            if (!0x2::table::contains<address, bool>(&arg0.admins, arg2)) {
                0x2::table::add<address, bool>(&mut arg0.admins, arg2, true);
            };
        } else if (arg1 == 2) {
            if (!0x2::table::contains<address, bool>(&arg0.verifiers, arg2)) {
                0x2::table::add<address, bool>(&mut arg0.verifiers, arg2, true);
            };
        };
        let v1 = RoleGranted{
            role       : arg1,
            account    : arg2,
            granted_by : v0,
        };
        0x2::event::emit<RoleGranted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessControlCap{
            id        : 0x2::object::new(arg0),
            admins    : 0x2::table::new<address, bool>(arg0),
            verifiers : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<AccessControlCap>(v0);
    }

    public fun is_admin(arg0: &AccessControlCap, arg1: address) : bool {
        is_admin_internal(arg0, arg1)
    }

    fun is_admin_internal(arg0: &AccessControlCap, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.admins, arg1)
    }

    public fun is_verifier(arg0: &AccessControlCap, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.verifiers, arg1)
    }

    public entry fun revoke_role(arg0: &mut AccessControlCap, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin_internal(arg0, v0), 4000);
        assert!(arg1 <= 2, 4001);
        if (arg1 == 0 && 0x2::table::contains<address, bool>(&arg0.admins, arg2)) {
            0x2::table::remove<address, bool>(&mut arg0.admins, arg2);
        } else if (arg1 == 2 && 0x2::table::contains<address, bool>(&arg0.verifiers, arg2)) {
            0x2::table::remove<address, bool>(&mut arg0.verifiers, arg2);
        };
        let v1 = RoleRevoked{
            role       : arg1,
            account    : arg2,
            revoked_by : v0,
        };
        0x2::event::emit<RoleRevoked>(v1);
    }

    // decompiled from Move bytecode v6
}

