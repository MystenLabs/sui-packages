module 0x1750009b129171cf11d4cc991edb1d5cf115e072a747edd4d4988fc6c019055a::farm {
    struct RewardPool has key {
        id: 0x2::object::UID,
        admin: address,
        claim_end_timestamp: u64,
        unclaimed_distributed_rewards_table: 0x2::table::Table<0x1::ascii::String, u64>,
        rewards_bag: 0x2::object_bag::ObjectBag,
        user_rewards_table: 0x2::table::Table<address, 0x2::table::Table<0x1::ascii::String, u64>>,
        is_paused: bool,
    }

    public fun batch_increase_user_rewards<T0>(arg0: &mut RewardPool, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 8);
        while (0x1::vector::length<address>(&arg1) > 0) {
            increase_user_rewards<T0>(arg0, 0x1::vector::pop_back<address>(&mut arg1), 0x1::vector::pop_back<u64>(&mut arg2), arg3);
        };
        0x1::vector::destroy_empty<address>(arg1);
        0x1::vector::destroy_empty<u64>(arg2);
    }

    public fun claim<T0>(arg0: &mut RewardPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 9);
        assert!(0x2::table::contains<address, 0x2::table::Table<0x1::ascii::String, u64>>(&arg0.user_rewards_table, 0x2::tx_context::sender(arg2)), 5);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.claim_end_timestamp, 6);
        let v0 = remove_user_reward_amount<T0>(arg0, 0x2::tx_context::sender(arg2));
        let v1 = get_global_coin<T0>(arg0);
        let v2 = 0x2::coin::split<T0>(v1, v0, arg2);
        let v3 = get_unclaimed_distributed_amount<T0>(arg0) - v0;
        set_unclaimed_distributed_amount<T0>(arg0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun deposit<T0>(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::object_bag::contains<0x1::ascii::String>(&arg0.rewards_bag, v0)) {
            0x2::coin::join<T0>(get_global_coin<T0>(arg0), arg1);
        } else {
            0x2::object_bag::add<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.rewards_bag, v0, arg1);
        };
    }

    public fun get_claim_end_timestamp(arg0: &RewardPool) : u64 {
        arg0.claim_end_timestamp
    }

    fun get_global_coin<T0>(arg0: &mut RewardPool) : &mut 0x2::coin::Coin<T0> {
        0x2::object_bag::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.rewards_bag, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun get_global_coin_amount<T0>(arg0: &RewardPool) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0;
        if (0x2::object_bag::contains<0x1::ascii::String>(&arg0.rewards_bag, v0)) {
            v1 = 0x2::coin::value<T0>(0x2::object_bag::borrow<0x1::ascii::String, 0x2::coin::Coin<T0>>(&arg0.rewards_bag, v0));
        };
        v1
    }

    public fun get_unclaimed_distributed_amount<T0>(arg0: &RewardPool) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0;
        let v2 = &v1;
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg0.unclaimed_distributed_rewards_table, v0)) {
            v2 = 0x2::table::borrow<0x1::ascii::String, u64>(&arg0.unclaimed_distributed_rewards_table, v0);
        };
        *v2
    }

    public fun get_undistributed_amount<T0>(arg0: &RewardPool) : u64 {
        get_global_coin_amount<T0>(arg0) - get_unclaimed_distributed_amount<T0>(arg0)
    }

    public fun get_user_reward_amount<T0>(arg0: &RewardPool, arg1: address) : &u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::table::borrow<address, 0x2::table::Table<0x1::ascii::String, u64>>(&arg0.user_rewards_table, arg1);
        assert!(0x2::table::contains<0x1::ascii::String, u64>(v1, v0), 2);
        0x2::table::borrow<0x1::ascii::String, u64>(v1, v0)
    }

    fun get_user_reward_amount_mut<T0>(arg0: &mut RewardPool, arg1: address) : &mut u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::ascii::String, u64>>(&mut arg0.user_rewards_table, arg1);
        if (0x2::table::contains<0x1::ascii::String, u64>(v1, v0)) {
            0x2::table::borrow_mut<0x1::ascii::String, u64>(v1, v0)
        } else {
            0x2::table::add<0x1::ascii::String, u64>(v1, v0, 0);
            0x2::table::borrow_mut<0x1::ascii::String, u64>(v1, v0)
        }
    }

    fun increase_user_rewards<T0>(arg0: &mut RewardPool, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_global_coin<T0>(arg0);
        assert!(0x2::coin::value<T0>(v0) >= arg2, 4);
        if (0x2::table::contains<address, 0x2::table::Table<0x1::ascii::String, u64>>(&arg0.user_rewards_table, arg1)) {
            let v1 = get_user_reward_amount_mut<T0>(arg0, arg1);
            *v1 = *v1 + arg2;
        } else {
            let v2 = 0x2::table::new<0x1::ascii::String, u64>(arg3);
            0x2::table::add<0x1::ascii::String, u64>(&mut v2, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
            0x2::table::add<address, 0x2::table::Table<0x1::ascii::String, u64>>(&mut arg0.user_rewards_table, arg1, v2);
        };
        let v3 = get_unclaimed_distributed_amount<T0>(arg0) + arg2;
        set_unclaimed_distributed_amount<T0>(arg0, v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id                                  : 0x2::object::new(arg0),
            admin                               : 0x2::tx_context::sender(arg0),
            claim_end_timestamp                 : 0,
            unclaimed_distributed_rewards_table : 0x2::table::new<0x1::ascii::String, u64>(arg0),
            rewards_bag                         : 0x2::object_bag::new(arg0),
            user_rewards_table                  : 0x2::table::new<address, 0x2::table::Table<0x1::ascii::String, u64>>(arg0),
            is_paused                           : false,
        };
        0x2::transfer::share_object<RewardPool>(v0);
    }

    fun remove_user_reward_amount<T0>(arg0: &mut RewardPool, arg1: address) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::ascii::String, u64>>(&mut arg0.user_rewards_table, arg1);
        assert!(0x2::table::contains<0x1::ascii::String, u64>(v1, v0), 2);
        0x2::table::remove<0x1::ascii::String, u64>(v1, v0)
    }

    public fun set_claim_end_timestamp(arg0: &mut RewardPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.claim_end_timestamp = arg1;
    }

    public fun set_paused_config(arg0: &mut RewardPool, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.is_paused = arg1;
    }

    fun set_unclaimed_distributed_amount<T0>(arg0: &mut RewardPool, arg1: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(arg1 <= get_global_coin_amount<T0>(arg0), 10);
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg0.unclaimed_distributed_rewards_table, v0)) {
            *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.unclaimed_distributed_rewards_table, v0) = arg1;
        } else {
            0x2::table::add<0x1::ascii::String, u64>(&mut arg0.unclaimed_distributed_rewards_table, v0, arg1);
        };
    }

    public fun set_user_rewards<T0>(arg0: &mut RewardPool, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1);
            let v1 = 0x1::vector::pop_back<u64>(&mut arg2);
            let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
            let v3 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::ascii::String, u64>>(&mut arg0.user_rewards_table, v0);
            let v4 = if (0x2::table::contains<0x1::ascii::String, u64>(v3, v2)) {
                let v5 = 0x2::table::borrow_mut<0x1::ascii::String, u64>(v3, v2);
                let v4 = if (*v5 > v1) {
                    get_unclaimed_distributed_amount<T0>(arg0) - *v5 - v1
                } else {
                    get_unclaimed_distributed_amount<T0>(arg0) + v1 - *v5
                };
                *v5 = v1;
                v4
            } else {
                let v6 = 0x2::table::new<0x1::ascii::String, u64>(arg3);
                0x2::table::add<0x1::ascii::String, u64>(&mut v6, v2, v1);
                0x2::table::add<address, 0x2::table::Table<0x1::ascii::String, u64>>(&mut arg0.user_rewards_table, v0, v6);
                get_unclaimed_distributed_amount<T0>(arg0) + v1
            };
            set_unclaimed_distributed_amount<T0>(arg0, v4);
        };
    }

    public fun withdraw_final<T0>(arg0: &mut RewardPool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        let v0 = get_global_coin<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v0, 0x2::coin::value<T0>(v0), arg1), arg0.admin);
    }

    public fun withdraw_unclaimed<T0>(arg0: &mut RewardPool, arg1: &0x2::clock::Clock, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.claim_end_timestamp, 7);
        let v0 = 0;
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::table::contains<0x1::ascii::String, u64>(0x2::table::borrow_mut<address, 0x2::table::Table<0x1::ascii::String, u64>>(&mut arg0.user_rewards_table, v1), 0x1::type_name::into_string(0x1::type_name::get<T0>()))) {
                let v2 = remove_user_reward_amount<T0>(arg0, v1);
                v0 = v0 + v2;
            };
        };
        let v3 = get_global_coin<T0>(arg0);
        let v4 = 0x2::coin::split<T0>(v3, v0, arg3);
        let v5 = get_unclaimed_distributed_amount<T0>(arg0) - v0;
        set_unclaimed_distributed_amount<T0>(arg0, v5);
        0x1::vector::destroy_empty<address>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, arg0.admin);
    }

    public fun withdraw_undistributed<T0>(arg0: &mut RewardPool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        assert!(0x2::object_bag::contains<0x1::ascii::String>(&arg0.rewards_bag, 0x1::type_name::into_string(0x1::type_name::get<T0>())), 2);
        let v0 = get_unclaimed_distributed_amount<T0>(arg0);
        let v1 = get_global_coin<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, 0x2::coin::value<T0>(v1) - v0, arg1), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

