module 0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority {
    struct Authority has store {
        owner: address,
        pending_owner: 0x1::option::Option<address>,
        roles: 0x2::vec_map::VecMap<address, u64>,
    }

    public fun accept(arg0: &mut Authority, arg1: address) {
        assert!(0x1::option::is_some<address>(&arg0.pending_owner) && *0x1::option::borrow<address>(&arg0.pending_owner) == arg1, 1);
        arg0.owner = arg1;
        arg0.pending_owner = 0x1::option::none<address>();
        arg0.roles = 0x2::vec_map::empty<address, u64>();
    }

    public fun assert_owner(arg0: &Authority, arg1: address) {
        assert!(arg1 != @0x0 && arg0.owner == arg1, 1);
    }

    public fun assert_role(arg0: &Authority, arg1: address, arg2: u64) {
        assert!(arg1 != @0x0 && (arg0.owner == arg1 || 0x2::vec_map::contains<address, u64>(&arg0.roles, &arg1) && *0x2::vec_map::get<address, u64>(&arg0.roles, &arg1) & arg2 == arg2), 1);
    }

    public fun cancel_nomination(arg0: &mut Authority, arg1: address) {
        assert_owner(arg0, arg1);
        arg0.pending_owner = 0x1::option::none<address>();
    }

    public fun new(arg0: address) : Authority {
        assert!(arg0 != @0x0, 2);
        Authority{
            owner         : arg0,
            pending_owner : 0x1::option::none<address>(),
            roles         : 0x2::vec_map::empty<address, u64>(),
        }
    }

    public fun nominate(arg0: &mut Authority, arg1: address, arg2: address) {
        assert_owner(arg0, arg1);
        assert!(arg2 != @0x0 && arg2 != arg1, 2);
        arg0.pending_owner = 0x1::option::some<address>(arg2);
    }

    public fun owner(arg0: &Authority) : address {
        arg0.owner
    }

    public fun pending_owner(arg0: &Authority) : 0x1::option::Option<address> {
        arg0.pending_owner
    }

    public fun renounce(arg0: &mut Authority, arg1: address) {
        assert_owner(arg0, arg1);
        arg0.owner = @0x0;
        arg0.pending_owner = 0x1::option::none<address>();
        arg0.roles = 0x2::vec_map::empty<address, u64>();
    }

    public fun renounced() : Authority {
        Authority{
            owner         : @0x0,
            pending_owner : 0x1::option::none<address>(),
            roles         : 0x2::vec_map::empty<address, u64>(),
        }
    }

    public fun set_role(arg0: &mut Authority, arg1: address, arg2: address, arg3: u64) {
        assert_owner(arg0, arg1);
        assert!(arg2 != @0x0 && arg3 <= 15, 3);
        if (0x2::vec_map::contains<address, u64>(&arg0.roles, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.roles, &arg2);
        };
        if (arg3 > 0) {
            0x2::vec_map::insert<address, u64>(&mut arg0.roles, arg2, arg3);
        };
    }

    public fun with_roles(arg0: address, arg1: vector<address>, arg2: vector<u64>) : Authority {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2) && 0x1::vector::length<address>(&arg1) <= 32, 3);
        let v0 = new(arg0);
        let v1 = 0x2::vec_set::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            assert!(!0x2::vec_set::contains<address>(&v1, 0x1::vector::borrow<address>(&arg1, v2)), 3);
            0x2::vec_set::insert<address>(&mut v1, *0x1::vector::borrow<address>(&arg1, v2));
            let v3 = &mut v0;
            set_role(v3, arg0, *0x1::vector::borrow<address>(&arg1, v2), *0x1::vector::borrow<u64>(&arg2, v2));
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

