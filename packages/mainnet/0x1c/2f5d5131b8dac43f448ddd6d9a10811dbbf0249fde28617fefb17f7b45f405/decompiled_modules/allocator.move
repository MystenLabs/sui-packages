module 0x1c2f5d5131b8dac43f448ddd6d9a10811dbbf0249fde28617fefb17f7b45f405::allocator {
    struct PoolData has drop, store {
        pending_rewards: u64,
        weight: u64,
        last_update_time: u64,
    }

    struct PoolInfo has store {
        pool_data: 0x2::vec_map::VecMap<0x1::type_name::TypeName, PoolData>,
    }

    struct Allocator has store, key {
        id: 0x2::object::UID,
        total_weights: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        members: 0x2::vec_map::VecMap<0x2::object::ID, PoolInfo>,
        rewards: 0x2::bag::Bag,
    }

    public(friend) fun add_new_pool(arg0: &mut Allocator, arg1: 0x2::object::ID) {
        assert!(0x2::vec_map::contains<0x2::object::ID, PoolInfo>(&arg0.members, &arg1) == false, 0x1c2f5d5131b8dac43f448ddd6d9a10811dbbf0249fde28617fefb17f7b45f405::error::pool_already_present_error());
        let v0 = PoolInfo{pool_data: 0x2::vec_map::empty<0x1::type_name::TypeName, PoolData>()};
        0x2::vec_map::insert<0x2::object::ID, PoolInfo>(&mut arg0.members, arg1, v0);
    }

    public(friend) fun create_allocator(arg0: &mut 0x2::tx_context::TxContext) : Allocator {
        Allocator{
            id            : 0x2::object::new(arg0),
            total_weights : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            members       : 0x2::vec_map::empty<0x2::object::ID, PoolInfo>(),
            rewards       : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun delete_pool(arg0: &mut Allocator, arg1: 0x2::object::ID) {
        assert!(0x2::vec_map::contains<0x2::object::ID, PoolInfo>(&arg0.members, &arg1) == true, 0x1c2f5d5131b8dac43f448ddd6d9a10811dbbf0249fde28617fefb17f7b45f405::error::pool_not_present_error());
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, PoolInfo>(&mut arg0.members, &arg1);
        let v2 = v1;
        let v3 = true;
        let v4 = false;
        let v5 = 0;
        while (v5 < 0x2::vec_map::size<0x1::type_name::TypeName, PoolData>(&v2.pool_data)) {
            let (_, v7) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, PoolData>(&v2.pool_data, v5);
            if (v7.weight != 0) {
                v3 = false;
                break
            };
            if (v7.pending_rewards > 0) {
                v4 = true;
                break
            };
            v5 = v5 + 1;
        };
        assert!(v3 == true, 0x1c2f5d5131b8dac43f448ddd6d9a10811dbbf0249fde28617fefb17f7b45f405::error::pool_has_weight_error());
        assert!(v4 == false, 0x1c2f5d5131b8dac43f448ddd6d9a10811dbbf0249fde28617fefb17f7b45f405::error::pending_rewards_error());
        let PoolInfo { pool_data: v8 } = v2;
        let v9 = 0;
        while (v9 < 0x2::vec_map::size<0x1::type_name::TypeName, PoolData>(&v8)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, PoolData>(&mut v8);
            v9 = v9 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, PoolData>(v8);
    }

    public(friend) fun get_reward_value<T0>(arg0: &Allocator) : u64 {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.rewards, 0x1::type_name::get<T0>()))
        } else {
            0
        }
    }

    public(friend) fun get_rewards<T0>(arg0: &mut Allocator, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x2::object::ID, PoolInfo>(&arg0.members, &arg1) == true) {
            let v2 = 0x2::vec_map::get_mut<0x2::object::ID, PoolInfo>(&mut arg0.members, &arg1);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, PoolData>(&v2.pool_data, &v0) == true) {
                let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PoolData>(&mut v2.pool_data, &v0);
                let v4 = v3.pending_rewards;
                let v5 = v4;
                if (v3.weight > 0) {
                    v5 = v4 + (arg3 - v3.last_update_time) * arg2 * v3.weight / *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.total_weights, &v0);
                };
                v3.last_update_time = arg3;
                v3.pending_rewards = 0;
                0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v0), v5)
            } else {
                0x2::balance::zero<T0>()
            }
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public(friend) fun get_rewards_from_distributor<T0>(arg0: &mut Allocator, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, 0x1::type_name::get<T0>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, 0x1::type_name::get<T0>(), arg1);
        };
    }

    public(friend) fun set_weight<T0>(arg0: &mut Allocator, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::vec_map::contains<0x2::object::ID, PoolInfo>(&arg0.members, &arg1) == true, 0x1c2f5d5131b8dac43f448ddd6d9a10811dbbf0249fde28617fefb17f7b45f405::error::pool_not_present_error());
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, PoolInfo>(&mut arg0.members, &arg1);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_weights, &v1) == true) {
            let v2 = 0x1::type_name::get<T0>();
            let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_weights, &v2);
            let v4 = 0x1::type_name::get<T0>();
            if (0x2::vec_map::contains<0x1::type_name::TypeName, PoolData>(&v0.pool_data, &v4)) {
                let v5 = 0x1::type_name::get<T0>();
                let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PoolData>(&mut v0.pool_data, &v5);
                *v3 = *v3 - v6.weight;
                *v3 = *v3 + arg2;
                v6.weight = arg2;
            } else {
                *v3 = *v3 + arg2;
                let v7 = PoolData{
                    pending_rewards  : 0,
                    weight           : arg2,
                    last_update_time : 0x2::clock::timestamp_ms(arg3),
                };
                0x2::vec_map::insert<0x1::type_name::TypeName, PoolData>(&mut v0.pool_data, 0x1::type_name::get<T0>(), v7);
            };
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.total_weights, 0x1::type_name::get<T0>(), arg2);
            let v8 = PoolData{
                pending_rewards  : 0,
                weight           : arg2,
                last_update_time : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, PoolData>(&mut v0.pool_data, 0x1::type_name::get<T0>(), v8);
        };
    }

    public(friend) fun top_up_pools<T0>(arg0: &mut Allocator, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg2 <= arg3, 0x1c2f5d5131b8dac43f448ddd6d9a10811dbbf0249fde28617fefb17f7b45f405::error::unlock_time_exceeded_error());
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, 0x1::type_name::get<T0>()) == false) {
            return
        };
        update_members<T0>(arg0, arg1, arg2);
    }

    fun update_members<T0>(arg0: &mut Allocator, arg1: u64, arg2: u64) {
        let v0 = 0;
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_weights, &v1) == false) {
            return
        };
        let v2 = *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_weights, &v1);
        if (v2 == 0) {
            return
        };
        while (v0 < 0x2::vec_map::size<0x2::object::ID, PoolInfo>(&arg0.members)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, PoolInfo>(&mut arg0.members, v0);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, PoolData>(&v4.pool_data, &v1) == true) {
                let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PoolData>(&mut v4.pool_data, &v1);
                v5.last_update_time = arg2;
                v5.pending_rewards = v5.pending_rewards + (((v5.weight as u128) * (((arg2 - v5.last_update_time) * arg1) as u128) / (v2 as u128)) as u64);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

