module 0xd89aa86e8929db34f1049403b3d7b41390deb28089d23ec40c6a9d1707d27eba::acl {
    struct ACL has store {
        permissions: 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::LinkedTable<address, u128>,
    }

    struct Member has copy, drop, store {
        address: address,
        permission: u128,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        ACL{permissions: 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::new<address, u128>(arg0)}
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0);
        if (0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v0 = 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
        };
    }

    public fun get_members(arg0: &ACL) : vector<Member> {
        let v0 = 0x1::vector::empty<Member>();
        let v1 = 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::head<address, u128>(&arg0.permissions);
        while (0x1::option::is_some<address>(&v1)) {
            let v2 = *0x1::option::borrow<address>(&v1);
            let v3 = 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow_node<address, u128>(&arg0.permissions, v2);
            let v4 = Member{
                address    : v2,
                permission : *0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow_value<address, u128>(v3),
            };
            0x1::vector::push_back<Member>(&mut v0, v4);
            v1 = 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::next<address, u128>(v3);
        };
        v0
    }

    public fun get_permission(arg0: &ACL, arg1: address) : u128 {
        if (!0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            0
        } else {
            *0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow<address, u128>(&arg0.permissions, arg1)
        }
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 0);
        0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::contains<address, u128>(&arg0.permissions, arg1) && *0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow<address, u128>(&arg0.permissions, arg1) & 1 << arg2 > 0
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        if (0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::remove<address, u128>(&mut arg0.permissions, arg1);
        };
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0);
        if (has_role(arg0, arg1, arg2)) {
            let v0 = 0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            *v0 = *v0 ^ 1 << arg2;
        };
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        if (0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            *0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1) = arg2;
        } else {
            0x6fb44bc08db47ce51eed4341019ec3efa01f8571c9f29d13c83ca3bcc1abee23::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

