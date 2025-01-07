module 0xc469bd27bf7817294d89994c5c582039ece1f0e47620c4a8d97aeb25c70a320d::allocator {
    struct Allocator_value<T0> has store {
        rewards: 0x2::bag::Bag,
        weights: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        last_update_time: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        key: T0,
    }

    struct Allocator<T0: copy> has store, key {
        id: 0x2::object::UID,
        total_weights: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        members: 0x2::vec_map::VecMap<T0, Allocator_value<T0>>,
    }

    public(friend) fun add_new_reward_token_to_key<T0: copy + drop, T1>(arg0: &mut Allocator<T0>, arg1: T0, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::vec_map::contains<T0, Allocator_value<T0>>(&arg0.members, &arg1) == true) {
            let v0 = 0x2::vec_map::get_mut<T0, Allocator_value<T0>>(&mut arg0.members, &arg1);
            let v1 = 0x1::type_name::get<T1>();
            assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.weights, &v1) == false, 8);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0.weights, 0x1::type_name::get<T1>(), arg2);
        } else {
            let v2 = Allocator_value<T0>{
                rewards          : 0x2::bag::new(arg4),
                weights          : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                last_update_time : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                key              : arg1,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2.weights, 0x1::type_name::get<T1>(), arg2);
            0x2::vec_map::insert<T0, Allocator_value<T0>>(&mut arg0.members, arg1, v2);
        };
        let v3 = 0x1::type_name::get<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_weights, &v3) == true) {
            let v4 = 0x1::type_name::get<T1>();
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_weights, &v4);
            *v5 = *v5 + arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.total_weights, 0x1::type_name::get<T1>(), arg2);
        };
    }

    public(friend) fun change_weight<T0: copy + drop, T1>(arg0: &mut Allocator<T0>, arg1: T0, arg2: u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_weights, &v0);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut 0x2::vec_map::get_mut<T0, Allocator_value<T0>>(&mut arg0.members, &arg1).weights, &v2);
        *v1 = *v1 - *v3;
        *v1 = *v1 + arg2;
        *v3 = arg2;
    }

    public(friend) fun create_allocator<T0: copy>(arg0: &mut 0x2::tx_context::TxContext) : Allocator<T0> {
        Allocator<T0>{
            id            : 0x2::object::new(arg0),
            total_weights : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            members       : 0x2::vec_map::empty<T0, Allocator_value<T0>>(),
        }
    }

    public(friend) fun get_rewards<T0: copy + drop, T1>(arg0: &mut Allocator<T0>, arg1: T0, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::vec_map::get_mut<T0, Allocator_value<T0>>(&mut arg0.members, &arg1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v0.rewards, 0x1::type_name::get<T1>());
        let v2 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v3 = 0x1::string::utf8(b"ALPHA");
        if (0x1::string::index_of(&v2, &v3) < 0x1::string::length(&v2)) {
            0x2::balance::withdraw_all<T1>(v1)
        } else {
            let v5 = 0x1::type_name::get<T1>();
            let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v0.last_update_time, &v5);
            let v7 = 0x2::math::min(0x2::balance::value<T1>(v1), (0x2::clock::timestamp_ms(arg3) - *v6) * 1000 * arg2);
            *v6 = 0x2::clock::timestamp_ms(arg3);
            if (v7 == 0x2::balance::value<T1>(v1)) {
                let v8 = 0x1::type_name::get<T1>();
                let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v0.last_update_time, &v8);
            };
            0x2::balance::split<T1>(v1, v7)
        }
    }

    public(friend) fun get_rewards_from_distributor<T0: copy, T1>(arg0: &mut Allocator<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) {
        update_members<T0, T1>(arg0, arg1, arg2);
    }

    fun transfer_rewards_direct<T0>(arg0: &mut Allocator<address>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut 0x2::vec_map::get_mut<address, Allocator_value<address>>(&mut arg0.members, &arg1).rewards, 0x1::type_name::get<T0>())), arg3), arg1);
    }

    public(friend) fun transfer_rewards_to_all_wallets<T0>(arg0: &mut Allocator<address>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<address, Allocator_value<address>>(&arg0.members)) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx_mut<address, Allocator_value<address>>(&mut arg0.members, v0);
            transfer_rewards_direct<T0>(arg0, v2.key, arg1, arg2);
            v0 = v0 + 1;
        };
    }

    fun update_members<T0: copy, T1>(arg0: &mut Allocator<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<T0, Allocator_value<T0>>(&arg0.members)) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx_mut<T0, Allocator_value<T0>>(&mut arg0.members, v0);
            let v3 = 0x1::type_name::get<T1>();
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
                (v4 as u128) * (0x2::balance::value<T1>(&arg1) as u128) / (v5 as u128)
            };
            if (0x2::bag::contains<0x1::type_name::TypeName>(&v2.rewards, v3) == true) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v2.rewards, v3), 0x2::balance::split<T1>(&mut arg1, (v6 as u64)));
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v2.rewards, v3, 0x2::balance::split<T1>(&mut arg1, (v6 as u64)));
            };
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2.last_update_time, &v3) == false) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2.last_update_time, v3, 0x2::clock::timestamp_ms(arg2));
            };
            v0 = v0 + 1;
        };
        0x2::balance::destroy_zero<T1>(arg1);
    }

    // decompiled from Move bytecode v6
}

