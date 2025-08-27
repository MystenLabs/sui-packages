module 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::acl {
    struct Acl has store {
        managers: 0x2::vec_map::VecMap<address, u8>,
    }

    fun err_invalid_role() {
        abort 201
    }

    public(friend) fun exists_role(arg0: &Acl, arg1: address) : bool {
        0x2::vec_map::contains<address, u8>(&arg0.managers, &arg1)
    }

    public(friend) fun new() : Acl {
        Acl{managers: 0x2::vec_map::empty<address, u8>()}
    }

    public(friend) fun remove_role(arg0: &mut Acl, arg1: address) {
        if (0x2::vec_map::contains<address, u8>(&arg0.managers, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u8>(&mut arg0.managers, &arg1);
        };
    }

    public fun role_level(arg0: &Acl, arg1: address) : u8 {
        *0x2::vec_map::get<address, u8>(&arg0.managers, &arg1)
    }

    public(friend) fun set_role(arg0: &mut Acl, arg1: address, arg2: u8) {
        if (arg2 == 0) {
            err_invalid_role();
        };
        if (0x2::vec_map::contains<address, u8>(&arg0.managers, &arg1)) {
            *0x2::vec_map::get_mut<address, u8>(&mut arg0.managers, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<address, u8>(&mut arg0.managers, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

