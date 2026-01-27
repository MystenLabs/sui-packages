module 0xa34a715f3ad75c65b43d5c88c67cdc0e91262436bb5335eba514e4584e12980::acl {
    struct ACL has store {
        permissions: 0x2::table::Table<address, u128>,
        members: 0x2::vec_set::VecSet<address>,
    }

    struct Member has copy, drop, store {
        address: address,
        permission: u128,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        ACL{
            permissions : 0x2::table::new<address, u128>(arg0),
            members     : 0x2::vec_set::empty<address>(),
        }
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0);
        if (0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0x2::table::add<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
            0x2::vec_set::insert<address>(&mut arg0.members, arg1);
        };
    }

    public fun get_members(arg0: &ACL) : vector<Member> {
        let v0 = 0x1::vector::empty<Member>();
        let v1 = 0x2::vec_set::keys<address>(&arg0.members);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = *0x1::vector::borrow<address>(v1, v2);
            let v4 = Member{
                address    : v3,
                permission : *0x2::table::borrow<address, u128>(&arg0.permissions, v3),
            };
            0x1::vector::push_back<Member>(&mut v0, v4);
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_permission(arg0: &ACL, arg1: address) : u128 {
        if (!0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u128>(&arg0.permissions, arg1)
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 0);
        if (!0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            return false
        };
        *0x2::table::borrow<address, u128>(&arg0.permissions, arg1) & 1 << arg2 > 0
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        if (0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            0x2::table::remove<address, u128>(&mut arg0.permissions, arg1);
            0x2::vec_set::remove<address>(&mut arg0.members, &arg1);
        };
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0);
        if (0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            *v0 = *v0 & 340282366920938463463374607431768211455 - (1 << arg2);
        };
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        if (0x2::table::contains<address, u128>(&arg0.permissions, arg1)) {
            *0x2::table::borrow_mut<address, u128>(&mut arg0.permissions, arg1) = arg2;
        } else {
            0x2::table::add<address, u128>(&mut arg0.permissions, arg1, arg2);
            0x2::vec_set::insert<address>(&mut arg0.members, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

