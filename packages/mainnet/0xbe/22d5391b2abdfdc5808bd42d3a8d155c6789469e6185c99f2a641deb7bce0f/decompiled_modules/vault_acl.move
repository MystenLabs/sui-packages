module 0xbe22d5391b2abdfdc5808bd42d3a8d155c6789469e6185c99f2a641deb7bce0f::vault_acl {
    struct ACL has store {
        permissions: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<address, u128>,
    }

    struct Member has copy, drop, store {
        address: address,
        permission: u128,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        ACL{permissions: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<address, u128>(arg0)}
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 13906834711214358530);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
        };
    }

    public fun get_permission(arg0: &ACL, arg1: address) : u128 {
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            0
        } else {
            *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<address, u128>(&arg0.permissions, arg1)
        }
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 13906834548005601282);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, u128>(&arg0.permissions, arg1) && *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<address, u128>(&arg0.permissions, arg1) & 1 << arg2 > 0
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, u128>(&arg0.permissions, arg1), 13906834904488017924);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<address, u128>(&mut arg0.permissions, arg1);
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 13906834805703639042);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, u128>(&arg0.permissions, arg1), 13906834827178606596);
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
        *v0 = *v0 & 340282366920938463463374607431768211455 - (1 << arg2);
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1) = arg2;
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

