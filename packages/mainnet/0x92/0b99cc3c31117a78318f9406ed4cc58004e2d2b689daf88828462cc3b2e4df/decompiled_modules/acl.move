module 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::acl {
    struct ACL has store {
        roles_by_member: 0x2::linked_table::LinkedTable<address, u128>,
    }

    struct Member has copy, drop, store {
        address: address,
        roles: u128,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        ACL{roles_by_member: 0x2::linked_table::new<address, u128>(arg0)}
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0);
        assert!(arg1 != @0x0, 1);
        if (0x2::linked_table::contains<address, u128>(&arg0.roles_by_member, arg1)) {
            let v0 = 0x2::linked_table::borrow_mut<address, u128>(&mut arg0.roles_by_member, arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0x2::linked_table::push_back<address, u128>(&mut arg0.roles_by_member, arg1, 1 << arg2);
        };
    }

    public fun get_members(arg0: &ACL) : vector<Member> {
        let v0 = 0x1::vector::empty<Member>();
        let v1 = 0x2::linked_table::front<address, u128>(&arg0.roles_by_member);
        while (0x1::option::is_some<address>(v1)) {
            let v2 = *0x1::option::borrow<address>(v1);
            let v3 = Member{
                address : v2,
                roles   : *0x2::linked_table::borrow<address, u128>(&arg0.roles_by_member, v2),
            };
            0x1::vector::push_back<Member>(&mut v0, v3);
            v1 = 0x2::linked_table::next<address, u128>(&arg0.roles_by_member, v2);
        };
        v0
    }

    public fun get_roles(arg0: &ACL, arg1: address) : u128 {
        if (0x2::linked_table::contains<address, u128>(&arg0.roles_by_member, arg1)) {
            *0x2::linked_table::borrow<address, u128>(&arg0.roles_by_member, arg1)
        } else {
            0
        }
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 0);
        0x2::linked_table::contains<address, u128>(&arg0.roles_by_member, arg1) && *0x2::linked_table::borrow<address, u128>(&arg0.roles_by_member, arg1) & 1 << arg2 > 0
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        if (0x2::linked_table::contains<address, u128>(&arg0.roles_by_member, arg1)) {
            0x2::linked_table::remove<address, u128>(&mut arg0.roles_by_member, arg1);
        };
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0);
        if (0x2::linked_table::contains<address, u128>(&arg0.roles_by_member, arg1)) {
            let v0 = 0x2::linked_table::borrow_mut<address, u128>(&mut arg0.roles_by_member, arg1);
            *v0 = *v0 & 340282366920938463463374607431768211455 - (1 << arg2);
            if (*v0 == 0) {
                0x2::linked_table::remove<address, u128>(&mut arg0.roles_by_member, arg1);
            };
        };
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        assert!(arg1 != @0x0, 1);
        if (0x2::linked_table::contains<address, u128>(&arg0.roles_by_member, arg1)) {
            if (arg2 == 0) {
                0x2::linked_table::remove<address, u128>(&mut arg0.roles_by_member, arg1);
            } else {
                *0x2::linked_table::borrow_mut<address, u128>(&mut arg0.roles_by_member, arg1) = arg2;
            };
        } else if (arg2 != 0) {
            0x2::linked_table::push_back<address, u128>(&mut arg0.roles_by_member, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

