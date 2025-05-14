module 0x3f37a15530ea5e67b9c708ec39b1c4c0aa33c136b334fbc01d0fa35265c77a96::acl {
    struct ACL has store {
        permissions: 0x2::linked_table::LinkedTable<address, u128>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        ACL{permissions: 0x2::linked_table::new<address, u128>(arg0)}
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 0x3f37a15530ea5e67b9c708ec39b1c4c0aa33c136b334fbc01d0fa35265c77a96::errors::role_num_too_large());
        0x2::linked_table::contains<address, u128>(&arg0.permissions, arg1) && *0x2::linked_table::borrow<address, u128>(&arg0.permissions, arg1) & 1 << arg2 > 0
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        if (0x2::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            *0x2::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1) = arg2;
        } else {
            0x2::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

