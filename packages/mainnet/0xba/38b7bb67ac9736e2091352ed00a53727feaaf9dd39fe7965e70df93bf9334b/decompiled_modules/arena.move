module 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::arena {
    struct Arena has key {
        id: 0x2::object::UID,
        win_points: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        participants: 0x2::vec_map::VecMap<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>,
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
            participants : 0x2::vec_map::empty<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(),
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

    entry fun delist_role(arg0: &mut Arena, arg1: 0x2::object::ID) {
        assert!(arg0.is_active, 0);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&mut arg0.participants, &arg1);
        let (_, v3) = 0x2::vec_map::remove<0x2::object::ID, address>(&mut arg0.role_owners, &arg1);
        0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(v1, v3);
    }

    fun gen_rand(arg0: &0x2::random::Random, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        0x2::random::generate_u64_in_range(&mut v0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArenaAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ArenaAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun list_role(arg0: &mut Arena, arg1: 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 0);
        assert!(0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::attack_points(&arg1) > 0, 1);
        assert!(0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::defense_points(&arg1) > 0, 1);
        0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::check_pending(&arg1, arg2);
        let v0 = 0x2::object::id<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&arg1);
        0x2::vec_map::insert<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&mut arg0.participants, v0, arg1);
        0x2::vec_map::insert<0x2::object::ID, address>(&mut arg0.role_owners, v0, 0x2::tx_context::sender(arg3));
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.win_points, &v0)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.win_points, v0, 0);
        };
    }

    entry fun pk(arg0: &mut Arena, arg1: &0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::config::Config, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::attack_points(0x2::vec_map::get<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&arg0.participants, &arg2));
        if (gen_rand(arg4, 1, v0 + 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::defense_points(0x2::vec_map::get<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&arg0.participants, &arg3)), arg6) < v0) {
            let (_, v2) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.win_points, &arg2);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.win_points, arg2, v2 + 1);
            let v3 = 0x2::vec_map::get_mut<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&mut arg0.participants, &arg3);
            0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::hurt(v3);
            if (0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::hp(v3) == 0) {
                let (_, v5) = 0x2::vec_map::remove<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&mut arg0.participants, &arg3);
                let v6 = v5;
                0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::set_pending(&mut v6, arg1, arg5);
                let (_, v8) = 0x2::vec_map::remove<0x2::object::ID, address>(&mut arg0.role_owners, &arg3);
                0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(v6, v8);
            };
        } else {
            let (_, v10) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.win_points, &arg3);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.win_points, arg3, v10 + 1);
            let v11 = 0x2::vec_map::get_mut<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&mut arg0.participants, &arg2);
            0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::hurt(v11);
            if (0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::hp(v11) == 0) {
                let (_, v13) = 0x2::vec_map::remove<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&mut arg0.participants, &arg2);
                let v14 = v13;
                0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::set_pending(&mut v14, arg1, arg5);
                let (_, v16) = 0x2::vec_map::remove<0x2::object::ID, address>(&mut arg0.role_owners, &arg2);
                0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(v14, v16);
            };
        };
    }

    entry fun pk_with_admin_cap(arg0: &mut Arena, arg1: &0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::config::AdminCap, arg2: &0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::config::Config, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::attack_points(0x2::vec_map::get<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&arg0.participants, &arg3)) * 120 / 100;
        if (gen_rand(arg5, 1, v0 + 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::defense_points(0x2::vec_map::get<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&arg0.participants, &arg4)), arg7) < v0) {
            let (_, v2) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.win_points, &arg3);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.win_points, arg3, v2 + 1);
            let v3 = 0x2::vec_map::get_mut<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&mut arg0.participants, &arg4);
            0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::hurt(v3);
            if (0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::hp(v3) == 0) {
                let (_, v5) = 0x2::vec_map::remove<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&mut arg0.participants, &arg4);
                let v6 = v5;
                0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::set_pending(&mut v6, arg2, arg6);
                let (_, v8) = 0x2::vec_map::remove<0x2::object::ID, address>(&mut arg0.role_owners, &arg4);
                0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(v6, v8);
            };
        } else {
            let (_, v10) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.win_points, &arg4);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.win_points, arg4, v10 + 1);
            let v11 = 0x2::vec_map::get_mut<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&mut arg0.participants, &arg3);
            0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::hurt(v11);
            if (0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::hp(v11) == 0) {
                let (_, v13) = 0x2::vec_map::remove<0x2::object::ID, 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(&mut arg0.participants, &arg3);
                let v14 = v13;
                0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::set_pending(&mut v14, arg2, arg6);
                let (_, v16) = 0x2::vec_map::remove<0x2::object::ID, address>(&mut arg0.role_owners, &arg3);
                0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role>(v14, v16);
            };
        };
    }

    // decompiled from Move bytecode v6
}

