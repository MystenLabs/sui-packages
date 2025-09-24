module 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::arena {
    struct Arena has key {
        id: 0x2::object::UID,
        win_points: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        participants: 0x2::vec_map::VecMap<0x2::object::ID, 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>,
        role_owners: 0x2::vec_map::VecMap<0x2::object::ID, address>,
        is_active: bool,
    }

    struct ArenaAdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun new(arg0: &ArenaAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Arena{
            id           : 0x2::object::new(arg1),
            win_points   : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            participants : 0x2::vec_map::empty<0x2::object::ID, 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(),
            role_owners  : 0x2::vec_map::empty<0x2::object::ID, address>(),
            is_active    : false,
        };
        0x2::transfer::share_object<Arena>(v0);
    }

    entry fun active(arg0: &mut Arena, arg1: &ArenaAdminCap) {
        arg0.is_active = true;
    }

    entry fun deactive(arg0: &mut Arena, arg1: &ArenaAdminCap) {
        arg0.is_active = false;
    }

    entry fun delist_role(arg0: &mut Arena, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 0);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(&mut arg0.participants, &arg1);
        0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(v1, 0x2::tx_context::sender(arg2));
    }

    fun gen_rand(arg0: &0x2::random::Random, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        0x2::random::generate_u64_in_range(&mut v0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArenaAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ArenaAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun list_role(arg0: &mut Arena, arg1: 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role, arg2: &0x2::clock::Clock) {
        assert!(arg0.is_active, 0);
        assert!(0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::attack_points(&arg1) > 0, 1);
        assert!(0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::defense_points(&arg1) > 0, 1);
        0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::check_pending(&arg1, arg2);
        let v0 = 0x2::object::id<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(&arg1);
        0x2::vec_map::insert<0x2::object::ID, 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(&mut arg0.participants, v0, arg1);
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.win_points, &v0)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.win_points, v0, 0);
        };
    }

    entry fun pk(arg0: &mut Arena, arg1: &0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::config::Config, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::attack_points(0x2::vec_map::get<0x2::object::ID, 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(&arg0.participants, &arg2));
        if (gen_rand(arg4, 1, v0 + 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::defense_points(0x2::vec_map::get<0x2::object::ID, 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(&arg0.participants, &arg3)), arg6) < v0) {
            let v1 = 0x2::vec_map::get_mut<0x2::object::ID, 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(&mut arg0.participants, &arg3);
            0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::hurt(v1);
            if (0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::hp(v1) == 0) {
                let (_, v3) = 0x2::vec_map::remove<0x2::object::ID, 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(&mut arg0.participants, &arg3);
                let v4 = v3;
                0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::set_pending(&mut v4, arg1, arg5);
                0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(v4, *0x2::vec_map::get<0x2::object::ID, address>(&arg0.role_owners, &arg3));
            };
        } else {
            let v5 = 0x2::vec_map::get_mut<0x2::object::ID, 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(&mut arg0.participants, &arg2);
            0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::hurt(v5);
            if (0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::hp(v5) == 0) {
                let (_, v7) = 0x2::vec_map::remove<0x2::object::ID, 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(&mut arg0.participants, &arg2);
                let v8 = v7;
                0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::set_pending(&mut v8, arg1, arg5);
                0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role::Role>(v8, *0x2::vec_map::get<0x2::object::ID, address>(&arg0.role_owners, &arg2));
            };
        };
    }

    // decompiled from Move bytecode v6
}

