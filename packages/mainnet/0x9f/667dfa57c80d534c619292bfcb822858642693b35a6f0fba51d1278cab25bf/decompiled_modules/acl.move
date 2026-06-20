module 0x9f667dfa57c80d534c619292bfcb822858642693b35a6f0fba51d1278cab25bf::acl {
    struct ACL has store {
        permissions: 0x2::table::Table<address, u128>,
    }

    struct AclRoleGranted has copy, drop {
        member: address,
        role: u8,
    }

    struct AclRoleRevoked has copy, drop {
        member: address,
        role: u8,
    }

    struct AclRolesSet has copy, drop {
        member: address,
        roles: u128,
    }

    struct AclMemberRemoved has copy, drop {
        member: address,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        ACL{permissions: 0x2::table::new<address, u128>(arg0)}
    }

    public fun contains(arg0: &ACL, arg1: address) : bool {
        0x2::table::contains<address, u128>(&arg0.permissions, arg1)
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!((arg2 as u64) < 128, 1);
        let v0 = 1 << arg2;
        if (0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            if (*v1 & v0 == 0) {
                *v1 = *v1 | v0;
                let v2 = AclRoleGranted{
                    member : arg1,
                    role   : arg2,
                };
                0x2::event::emit<AclRoleGranted>(v2);
            };
        } else {
            0x2::table::add<address, u128>(&mut arg0.permissions, arg1, v0);
            let v3 = AclRoleGranted{
                member : arg1,
                role   : arg2,
            };
            0x2::event::emit<AclRoleGranted>(v3);
        };
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        if ((arg2 as u64) >= 128) {
            return false
        };
        if (!0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            return false
        };
        *0x2::table::borrow<address, u128>(&arg0.permissions, arg1) & 1 << arg2 > 0
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        if (0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            0x2::table::remove<address, u128>(&mut arg0.permissions, arg1);
            let v0 = AclMemberRemoved{member: arg1};
            0x2::event::emit<AclMemberRemoved>(v0);
        };
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!((arg2 as u64) < 128, 1);
        if (!0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            return
        };
        let v0 = 1 << arg2;
        let v1 = 0x2::table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
        if (*v1 & v0 == 0) {
            return
        };
        *v1 = *v1 & (v0 ^ 340282366920938463463374607431768211455);
        if (*v1 == 0) {
            0x2::table::remove<address, u128>(&mut arg0.permissions, arg1);
            let v2 = AclMemberRemoved{member: arg1};
            0x2::event::emit<AclMemberRemoved>(v2);
        };
        let v3 = AclRoleRevoked{
            member : arg1,
            role   : arg2,
        };
        0x2::event::emit<AclRoleRevoked>(v3);
    }

    public fun roles_of(arg0: &ACL, arg1: address) : u128 {
        if (!0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u128>(&arg0.permissions, arg1)
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        if (arg2 == 0) {
            if (0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
                0x2::table::remove<address, u128>(&mut arg0.permissions, arg1);
                let v0 = AclMemberRemoved{member: arg1};
                0x2::event::emit<AclMemberRemoved>(v0);
            };
            return
        };
        if (0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            *0x2::table::borrow_mut<address, u128>(&mut arg0.permissions, arg1) = arg2;
        } else {
            0x2::table::add<address, u128>(&mut arg0.permissions, arg1, arg2);
        };
        let v1 = AclRolesSet{
            member : arg1,
            roles  : arg2,
        };
        0x2::event::emit<AclRolesSet>(v1);
    }

    public fun size(arg0: &ACL) : u64 {
        0x2::table::length<address, u128>(&arg0.permissions)
    }

    // decompiled from Move bytecode v7
}

