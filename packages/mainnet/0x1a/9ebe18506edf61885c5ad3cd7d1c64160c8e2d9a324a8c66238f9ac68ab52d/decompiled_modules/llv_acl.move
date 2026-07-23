module 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_acl {
    struct Acl has store {
        roles: 0x2::vec_map::VecMap<address, u64>,
        role_counts: 0x2::vec_map::VecMap<u64, u64>,
    }

    public(friend) fun empty() : Acl {
        Acl{
            roles       : 0x2::vec_map::empty<address, u64>(),
            role_counts : 0x2::vec_map::empty<u64, u64>(),
        }
    }

    fun decrement_role_count(arg0: &mut Acl, arg1: u64) {
        if (arg1 == 0 || !0x2::vec_map::contains<u64, u64>(&arg0.role_counts, &arg1)) {
            return
        };
        let v0 = *0x2::vec_map::get<u64, u64>(&arg0.role_counts, &arg1);
        if (v0 <= 1) {
            let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.role_counts, &arg1);
        } else {
            *0x2::vec_map::get_mut<u64, u64>(&mut arg0.role_counts, &arg1) = v0 - 1;
        };
    }

    public(friend) fun has_role(arg0: &Acl, arg1: address, arg2: u64) : bool {
        role_of(arg0, arg1) == arg2
    }

    fun increment_role_count(arg0: &mut Acl, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        if (0x2::vec_map::contains<u64, u64>(&arg0.role_counts, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u64, u64>(&mut arg0.role_counts, &arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::vec_map::insert<u64, u64>(&mut arg0.role_counts, arg1, 1);
        };
    }

    public(friend) fun members_with_role(arg0: &Acl, arg1: u64) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<address, u64>(&arg0.roles)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.roles, v1);
            if (*v3 == arg1) {
                0x1::vector::push_back<address>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun remove_role(arg0: &mut Acl, arg1: address) : u64 {
        if (!0x2::vec_map::contains<address, u64>(&arg0.roles, &arg1)) {
            return 0
        };
        let (_, v1) = 0x2::vec_map::remove<address, u64>(&mut arg0.roles, &arg1);
        decrement_role_count(arg0, v1);
        v1
    }

    public(friend) fun role_count(arg0: &Acl, arg1: u64) : u64 {
        if (0x2::vec_map::contains<u64, u64>(&arg0.role_counts, &arg1)) {
            *0x2::vec_map::get<u64, u64>(&arg0.role_counts, &arg1)
        } else {
            0
        }
    }

    public(friend) fun role_of(arg0: &Acl, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.roles, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.roles, &arg1)
        } else {
            0
        }
    }

    public(friend) fun set_role(arg0: &mut Acl, arg1: address, arg2: u64) : u64 {
        if (arg2 == 0) {
            return remove_role(arg0, arg1)
        };
        let v0 = role_of(arg0, arg1);
        if (v0 == arg2) {
            return v0
        };
        decrement_role_count(arg0, v0);
        increment_role_count(arg0, arg2);
        if (0x2::vec_map::contains<address, u64>(&arg0.roles, &arg1)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.roles, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.roles, arg1, arg2);
        };
        v0
    }

    // decompiled from Move bytecode v7
}

