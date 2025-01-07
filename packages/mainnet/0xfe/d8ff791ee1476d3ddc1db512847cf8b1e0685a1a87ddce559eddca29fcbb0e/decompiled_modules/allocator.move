module 0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator {
    struct Pool_info has store {
        rewards: 0x2::bag::Bag,
        weights: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct Allocator has store, key {
        id: 0x2::object::UID,
        total_weights: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        members: 0x2::vec_map::VecMap<0x2::object::ID, Pool_info>,
        rewards: 0x2::bag::Bag,
        last_update_time: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public(friend) fun add_new_pool(arg0: &mut Allocator, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Pool_info>(&arg0.members, &arg1) == false, 5);
        let v0 = Pool_info{
            rewards : 0x2::bag::new(arg2),
            weights : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::vec_map::insert<0x2::object::ID, Pool_info>(&mut arg0.members, arg1, v0);
    }

    public(friend) fun create_allocator(arg0: &mut 0x2::tx_context::TxContext) : Allocator {
        Allocator{
            id               : 0x2::object::new(arg0),
            total_weights    : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            members          : 0x2::vec_map::empty<0x2::object::ID, Pool_info>(),
            rewards          : 0x2::bag::new(arg0),
            last_update_time : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        }
    }

    fun delete_pool(arg0: &mut Allocator, arg1: 0x2::object::ID) {
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, Pool_info>(&mut arg0.members, &arg1);
        let Pool_info {
            rewards : v2,
            weights : v3,
        } = v1;
        let v4 = v3;
        let v5 = 0;
        while (v5 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v4)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, u64>(&mut v4);
            v5 = v5 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u64>(v4);
        0x2::bag::destroy_empty(v2);
    }

    public(friend) fun get_rewards<T0>(arg0: &mut Allocator, arg1: 0x2::object::ID) : 0x2::balance::Balance<T0> {
        if (0x2::vec_map::contains<0x2::object::ID, Pool_info>(&arg0.members, &arg1) == true) {
            let v1 = 0x2::vec_map::get_mut<0x2::object::ID, Pool_info>(&mut arg0.members, &arg1);
            let v2 = 0x1::type_name::get<T0>();
            let v3 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v1.weights, &v2) == true) {
                let v4 = 0x1::type_name::get<T0>();
                *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v1.weights, &v4)
            } else {
                0
            };
            if (0x2::bag::contains<0x1::type_name::TypeName>(&v1.rewards, 0x1::type_name::get<T0>()) == true) {
                if (v3 == 0) {
                    0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.rewards, 0x1::type_name::get<T0>())
                } else {
                    0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.rewards, 0x1::type_name::get<T0>()))
                }
            } else {
                if (v3 == 0 && 0x2::bag::length(&v1.rewards) == 0) {
                    delete_pool(arg0, arg1);
                };
                0x2::balance::zero<T0>()
            }
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public(friend) fun get_rewards_from_distributor<T0>(arg0: &mut Allocator, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, 0x1::type_name::get<T0>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, 0x1::type_name::get<T0>(), arg1);
        };
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.last_update_time, &v0) == false) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.last_update_time, 0x1::type_name::get<T0>(), 0x2::clock::timestamp_ms(arg2));
        };
    }

    public(friend) fun set_weight<T0>(arg0: &mut Allocator, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Pool_info>(&arg0.members, &arg1) == true, 3);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Pool_info>(&mut arg0.members, &arg1);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_weights, &v1) == true) {
            let v2 = 0x1::type_name::get<T0>();
            let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_weights, &v2);
            let v4 = 0x1::type_name::get<T0>();
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&mut v0.weights, &v4)) {
                let v5 = 0x1::type_name::get<T0>();
                let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v0.weights, &v5);
                *v3 = *v3 - *v6;
                *v3 = *v3 + arg2;
                *v6 = arg2;
            } else {
                *v3 = *v3 + arg2;
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0.weights, 0x1::type_name::get<T0>(), arg2);
            };
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.total_weights, 0x1::type_name::get<T0>(), arg2);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0.weights, 0x1::type_name::get<T0>(), arg2);
        };
    }

    public(friend) fun top_up_pools<T0>(arg0: &mut Allocator, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, 0x1::type_name::get<T0>());
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v2 = 0x1::string::utf8(b"ALPHA");
        let v3 = if (0x1::string::index_of(&v1, &v2) < 0x1::string::length(&v1)) {
            0x2::balance::withdraw_all<T0>(v0)
        } else {
            let v4 = 0x1::type_name::get<T0>();
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.last_update_time, &v4);
            let v6 = 0x2::math::min(0x2::balance::value<T0>(v0), (0x2::clock::timestamp_ms(arg2) - *v5) / 1000 * arg1);
            *v5 = 0x2::clock::timestamp_ms(arg2);
            if (v6 == 0x2::balance::value<T0>(v0)) {
                let v7 = 0x1::type_name::get<T0>();
                let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.last_update_time, &v7);
            };
            0x2::balance::split<T0>(v0, v6)
        };
        update_members<T0>(arg0, v3);
    }

    fun update_members<T0>(arg0: &mut Allocator, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<0x2::object::ID, Pool_info>(&arg0.members)) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, Pool_info>(&mut arg0.members, v0);
            let v3 = 0x1::type_name::get<T0>();
            let v4 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2.weights, &v3) == true) {
                *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v2.weights, &v3)
            } else {
                0
            };
            let v5 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_weights, &v3) == true) {
                *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_weights, &v3)
            } else {
                0
            };
            let v6 = if (v5 == 0) {
                0
            } else {
                (v4 as u128) * (0x2::balance::value<T0>(&arg1) as u128) / (v5 as u128)
            };
            if (0x2::bag::contains<0x1::type_name::TypeName>(&v2.rewards, v3) == true) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2.rewards, v3), 0x2::balance::split<T0>(&mut arg1, (v6 as u64)));
            } else if (v6 > 0) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2.rewards, v3, 0x2::balance::split<T0>(&mut arg1, (v6 as u64)));
            } else {
                0x2::balance::destroy_zero<T0>(0x2::balance::split<T0>(&mut arg1, (v6 as u64)));
            };
            v0 = v0 + 1;
        };
        0x2::balance::destroy_zero<T0>(arg1);
    }

    // decompiled from Move bytecode v6
}

