module 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::acl {
    struct ACL has store {
        permissions: 0x2::vec_map::VecMap<address, u128>,
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::error::invalid_argument(0));
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.permissions, &arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0x2::vec_map::insert<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
        };
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::error::invalid_argument(0));
        0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1) && *0x2::vec_map::get<address, u128>(&arg0.permissions, &arg1) & 1 << arg2 > 0
    }

    public fun new() : ACL {
        ACL{permissions: 0x2::vec_map::empty<address, u128>()}
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::error::invalid_argument(0));
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.permissions, &arg1);
            *v0 = *v0 - (1 << arg2);
        };
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            *0x2::vec_map::get_mut<address, u128>(&mut arg0.permissions, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<address, u128>(&mut arg0.permissions, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

