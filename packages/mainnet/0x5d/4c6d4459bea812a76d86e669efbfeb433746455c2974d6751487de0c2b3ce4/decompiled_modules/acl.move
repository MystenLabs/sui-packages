module 0x5d4c6d4459bea812a76d86e669efbfeb433746455c2974d6751487de0c2b3ce4::acl {
    struct ACL has store {
        permissions: 0x2::linked_table::LinkedTable<address, u128>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        ACL{permissions: 0x2::linked_table::new<address, u128>(arg0)}
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 13906834346142072833);
        if (0x2::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v0 = 0x2::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0x2::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
        };
    }

    public fun get_permission(arg0: &ACL, arg1: address) : u128 {
        if (!0x2::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            0
        } else {
            *0x2::linked_table::borrow<address, u128>(&arg0.permissions, arg1)
        }
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 13906834290307497985);
        0x2::linked_table::contains<address, u128>(&arg0.permissions, arg1) && *0x2::linked_table::borrow<address, u128>(&arg0.permissions, arg1) & 1 << arg2 > 0
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        assert!(0x2::linked_table::contains<address, u128>(&arg0.permissions, arg1), 13906834419156647939);
        0x2::linked_table::remove<address, u128>(&mut arg0.permissions, arg1);
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 13906834389091745793);
        assert!(0x2::linked_table::contains<address, u128>(&arg0.permissions, arg1), 13906834393386844163);
        let v0 = 0x2::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
        *v0 = *v0 & 340282366920938463463374607431768211455 - (1 << arg2);
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

