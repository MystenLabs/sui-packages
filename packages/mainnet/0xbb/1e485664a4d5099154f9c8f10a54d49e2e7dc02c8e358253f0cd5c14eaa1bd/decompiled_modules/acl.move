module 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::acl {
    struct ACL has store {
        permissions: 0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::LinkedTable<address, u128>,
    }

    struct Member has copy, drop, store {
        address: address,
        permission: u128,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        ACL{permissions: 0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::new<address, u128>(arg0)}
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 1);
        if (0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v0 = 0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
        };
    }

    public fun get_members(arg0: &ACL) : vector<Member> {
        let v0 = 0x1::vector::empty<Member>();
        let v1 = 0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::head<address, u128>(&arg0.permissions);
        while (0x1::option::is_some<address>(&v1)) {
            let v2 = *0x1::option::borrow<address>(&v1);
            let v3 = 0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::borrow_node<address, u128>(&arg0.permissions, v2);
            let v4 = Member{
                address    : v2,
                permission : *0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::borrow_value<address, u128>(v3),
            };
            0x1::vector::push_back<Member>(&mut v0, v4);
            v1 = 0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::next<address, u128>(v3);
        };
        v0
    }

    public fun get_permission(arg0: &ACL, arg1: address) : u128 {
        if (!0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            0
        } else {
            *0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::borrow<address, u128>(&arg0.permissions, arg1)
        }
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 1);
        0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::contains<address, u128>(&arg0.permissions, arg1) && *0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::borrow<address, u128>(&arg0.permissions, arg1) & 1 << arg2 > 0
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        if (0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::remove<address, u128>(&mut arg0.permissions, arg1);
        };
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 1);
        if (0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v0 = 0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            if (*v0 & 1 << arg2 > 0) {
                *v0 = *v0 - (1 << arg2);
            };
        };
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        if (0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            *0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1) = arg2;
        } else {
            0xafb7215f61e59a98006a9dd6550b133704d5fb7b72ce10ef02ddeae74c2332ed::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

