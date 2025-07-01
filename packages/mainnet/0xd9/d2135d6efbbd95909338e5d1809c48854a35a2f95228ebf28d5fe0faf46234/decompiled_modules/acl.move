module 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::acl {
    struct ACL has store {
        permissions: 0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::LinkedTable<address, u128>,
    }

    struct Member has copy, drop, store {
        address: address,
        permission: u128,
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 973452362306456);
        if (0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v0 = 0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
        };
    }

    public fun fee_tier_manager_role() : u8 {
        1
    }

    public fun get_members(arg0: &ACL) : vector<Member> {
        let v0 = 0x1::vector::empty<Member>();
        let v1 = 0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::head<address, u128>(&arg0.permissions);
        while (0x1::option::is_some<address>(&v1)) {
            let v2 = *0x1::option::borrow<address>(&v1);
            let v3 = 0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::borrow_node<address, u128>(&arg0.permissions, v2);
            let v4 = Member{
                address    : v2,
                permission : *0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::borrow_value<address, u128>(v3),
            };
            0x1::vector::push_back<Member>(&mut v0, v4);
            v1 = 0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::next<address, u128>(v3);
        };
        v0
    }

    public fun get_permission(arg0: &ACL, arg1: address) : u128 {
        if (!0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            0
        } else {
            *0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::borrow<address, u128>(&arg0.permissions, arg1)
        }
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 973452362306456);
        0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::contains<address, u128>(&arg0.permissions, arg1) && *0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::borrow<address, u128>(&arg0.permissions, arg1) & 1 << arg2 > 0
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        ACL{permissions: 0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::new<address, u128>(arg0)}
    }

    public fun partner_manager_role() : u8 {
        3
    }

    public fun pool_manager_role() : u8 {
        0
    }

    public fun protocol_fee_claim_role() : u8 {
        2
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        if (0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::remove<address, u128>(&mut arg0.permissions, arg1);
        };
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 973452362306456);
        if (0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v0 = 0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            if (*v0 & 1 << arg2 > 0) {
                *v0 = *v0 - (1 << arg2);
            };
        };
    }

    public fun rewarder_manager_role() : u8 {
        4
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        if (0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            *0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1) = arg2;
        } else {
            0xf469e6021c21013c21b842c71231e06c4227ed2bf76f93408db70dc62e9f8182::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

