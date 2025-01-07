module 0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::acl {
    struct ACL has store {
        permissions: 0x2::vec_map::VecMap<address, u128>,
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0);
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.permissions, &arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0x2::vec_map::insert<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
        };
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 0);
        0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1) && *0x2::vec_map::get<address, u128>(&arg0.permissions, &arg1) & 1 << arg2 > 0
    }

    public fun new() : ACL {
        ACL{permissions: 0x2::vec_map::empty<address, u128>()}
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        if (0x2::vec_map::contains<address, u128>(&arg0.permissions, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u128>(&mut arg0.permissions, &arg1);
        };
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0);
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

