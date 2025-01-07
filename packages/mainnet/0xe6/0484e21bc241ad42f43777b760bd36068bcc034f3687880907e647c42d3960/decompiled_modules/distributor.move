module 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::distributor {
    struct Unlock_data has drop, store {
        unlock_per_ms: u64,
        last_unlock_time: u64,
    }

    struct Distributor has store, key {
        id: 0x2::object::UID,
        last_update_timestamp: u64,
        start_timestamp: u64,
        next_halving_timestamp: u64,
        target: u64,
        pool_allocator: 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::Allocator,
        treasury: 0x2::coin::TreasuryCap<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>,
        fee_wallet: address,
        airdrop_wallet: address,
        airdrop_wallet_balance: 0x2::balance::Balance<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>,
        team_wallet_address: address,
        team_wallet_balance: 0x2::balance::Balance<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>,
        reward_unlock: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Unlock_data>,
    }

    public fun add_new_pool(arg0: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Admin_cap, arg1: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::Version, arg2: &mut Distributor, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::assert_current_version(arg1);
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::add_new_pool(&mut arg2.pool_allocator, arg3, arg4);
    }

    public(friend) fun get_rewards<T0>(arg0: &mut Distributor, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(v0));
        let v2 = 0x1::string::utf8(b"ALPHA");
        let (v3, v4) = if (0x1::string::index_of(&v1, &v2) < 0x1::string::length(&v1)) {
            if (0x2::clock::timestamp_ms(arg2) > arg0.next_halving_timestamp) {
                withdraw_vested(arg0, arg2, arg3);
            };
            (((arg0.target / 100 * 86400000) as u64), 0x2::clock::timestamp_ms(arg2))
        } else if (0x2::vec_map::contains<0x1::type_name::TypeName, Unlock_data>(&arg0.reward_unlock, &v0) == true) {
            let v5 = 0x2::vec_map::get<0x1::type_name::TypeName, Unlock_data>(&arg0.reward_unlock, &v0);
            (v5.unlock_per_ms, (0x2::math::min(v5.last_unlock_time, 0x2::clock::timestamp_ms(arg2)) as u64))
        } else {
            (0, 0x2::clock::timestamp_ms(arg2))
        };
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::get_rewards<T0>(&mut arg0.pool_allocator, arg1, v3, v4)
    }

    public fun add_reward<T0>(arg0: &mut Distributor, arg1: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Admin_cap, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock) {
        set_unlock_per_second<T0>(arg0, arg1, arg3, arg4);
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::coin::into_balance<T0>(arg2));
    }

    entry fun change_airdrop_wallet_address(arg0: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Admin_cap, arg1: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::Version, arg2: &mut Distributor, arg3: address) {
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::assert_current_version(arg1);
        arg2.airdrop_wallet = arg3;
    }

    entry fun change_fee_wallet_address(arg0: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Admin_cap, arg1: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::Version, arg2: &mut Distributor, arg3: address) {
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::assert_current_version(arg1);
        arg2.fee_wallet = arg3;
    }

    entry fun change_team_wallet_address(arg0: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Admin_cap, arg1: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::Version, arg2: &mut Distributor, arg3: address) {
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::assert_current_version(arg1);
        arg2.team_wallet_address = arg3;
    }

    public fun create(arg0: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Admin_cap, arg1: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::Version, arg2: 0x2::coin::TreasuryCap<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>, arg3: address, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Distributor{
            id                     : 0x2::object::new(arg6),
            last_update_timestamp  : 0,
            start_timestamp        : 0,
            next_halving_timestamp : 0,
            target                 : 0,
            pool_allocator         : 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::create_allocator(arg6),
            treasury               : arg2,
            fee_wallet             : arg3,
            airdrop_wallet         : arg4,
            airdrop_wallet_balance : 0x2::balance::zero<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(),
            team_wallet_address    : arg5,
            team_wallet_balance    : 0x2::balance::zero<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(),
            reward_unlock          : 0x2::vec_map::empty<0x1::type_name::TypeName, Unlock_data>(),
        };
        0x2::transfer::public_share_object<Distributor>(v0);
    }

    public fun delete_pool_from_allocator(arg0: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Admin_cap, arg1: &mut Distributor, arg2: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::Version, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::assert_current_version(arg2);
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::delete_pool(&mut arg1.pool_allocator, arg3);
    }

    public fun get_airdrop_wallet_address(arg0: &mut Distributor) : address {
        arg0.airdrop_wallet
    }

    public fun get_fee_wallet_address(arg0: &mut Distributor) : address {
        arg0.fee_wallet
    }

    public fun remove_unlock_per_second<T0>(arg0: &mut Distributor, arg1: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Admin_cap, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, Unlock_data>(&arg0.reward_unlock, &v0) == true, 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::error::reward_not_set_error());
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, Unlock_data>(&arg0.reward_unlock, &v0).unlock_per_ms;
        if (v1 > 0) {
            0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, v1, 0x2::clock::timestamp_ms(arg2));
        };
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, Unlock_data>(&mut arg0.reward_unlock, &v0);
    }

    fun send_rewards_to_pool_allocator<T0>(arg0: &mut Distributor, arg1: 0x2::coin::Coin<T0>) {
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun set_start_timestamp_and_destroy_cap(arg0: 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Burn_start_cap, arg1: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::Version, arg2: &mut Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::assert_current_version(arg1);
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::destroy_start_cap(arg0);
        arg2.target = 8500000 * 1000000000;
        arg2.start_timestamp = 0x2::clock::timestamp_ms(arg3);
        arg2.last_update_timestamp = arg2.start_timestamp;
        arg2.next_halving_timestamp = arg2.start_timestamp;
        withdraw_vested(arg2, arg3, arg4);
    }

    public fun set_unlock_per_second<T0>(arg0: &mut Distributor, arg1: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Admin_cap, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Unlock_data>(&arg0.reward_unlock, &v0) == true) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Unlock_data>(&mut arg0.reward_unlock, &v0);
            0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, v1.unlock_per_ms, 0x2::clock::timestamp_ms(arg3));
            v1.unlock_per_ms = arg2;
        } else {
            let v2 = Unlock_data{
                unlock_per_ms    : arg2,
                last_unlock_time : 0x2::clock::timestamp_ms(arg3) + 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::get_reward_value<T0>(&mut arg0.pool_allocator) / arg2,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, Unlock_data>(&mut arg0.reward_unlock, v0, v2);
        };
    }

    public fun set_weights<T0>(arg0: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::Admin_cap, arg1: &mut Distributor, arg2: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::Version, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::assert_current_version(arg2);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == 0x1::vector::length<u64>(&arg4), 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::error::input_error());
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(v0));
        let v2 = 0;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Unlock_data>(&arg1.reward_unlock, &v0) == true) {
            v2 = 0x2::vec_map::get<0x1::type_name::TypeName, Unlock_data>(&arg1.reward_unlock, &v0).unlock_per_ms;
        };
        let v3 = 0x1::string::utf8(b"ALPHA");
        if (0x1::string::index_of(&v1, &v3) < 0x1::string::length(&v1)) {
            withdraw_vested(arg1, arg5, arg6);
            v2 = arg1.target / 100 * 86400000;
        };
        if (v2 > 0) {
            0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::top_up_pools<T0>(&mut arg1.pool_allocator, v2, 0x2::clock::timestamp_ms(arg5));
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::set_weight<T0>(&mut arg1.pool_allocator, 0x1::vector::pop_back<0x2::object::ID>(&mut arg3), 0x1::vector::pop_back<u64>(&mut arg4), arg5);
            v4 = v4 + 1;
        };
    }

    entry fun withdraw_airdrop_balance(arg0: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::Version, arg1: &mut Distributor, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::assert_current_version(arg0);
        assert!(0x2::balance::value<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&arg1.airdrop_wallet_balance) >= arg2, 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::error::insufficient_balance_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>>(0x2::coin::from_balance<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(0x2::balance::split<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&mut arg1.airdrop_wallet_balance, arg2), arg3), arg1.airdrop_wallet);
    }

    entry fun withdraw_team_balance(arg0: &0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::Version, arg1: &mut Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::version::assert_current_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.start_timestamp + 300 * 86400000, 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::error::withdraw_before_cliff_error());
        assert!(0x2::balance::value<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&arg1.team_wallet_balance) > 0, 0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::error::insufficient_balance_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>>(0x2::coin::from_balance<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(0x2::balance::withdraw_all<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&mut arg1.team_wallet_balance), arg3), arg1.team_wallet_address);
    }

    public fun withdraw_vested(arg0: &mut Distributor, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.target == 0 || 0x2::coin::total_supply<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&arg0.treasury) >= 10000000) {
            return
        };
        let v0 = 0;
        while (arg0.next_halving_timestamp <= 0x2::clock::timestamp_ms(arg1)) {
            0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::allocator::top_up_pools<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&mut arg0.pool_allocator, arg0.target / 100 * 86400000, arg0.next_halving_timestamp);
            arg0.last_update_timestamp = arg0.next_halving_timestamp;
            arg0.next_halving_timestamp = arg0.next_halving_timestamp + 100 * 86400000;
            let v1 = (arg0.last_update_timestamp - arg0.start_timestamp) / 86400000;
            if (v1 < 890) {
                arg0.target = arg0.target / 2;
            };
            if (v1 >= 1000) {
                arg0.target = 0;
                break
            };
            let v2 = (arg0.next_halving_timestamp - arg0.last_update_timestamp) * arg0.target / 86400000 * 100;
            let v3 = 2850000 * v2 / 4250000;
            let v4 = 0x2::coin::mint<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&mut arg0.treasury, v3, arg2);
            send_rewards_to_pool_allocator<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(arg0, v4);
            let v5 = v0 + v2;
            v0 = v5 - v3;
        };
        arg0.last_update_timestamp = arg0.next_halving_timestamp;
        let v6 = 150000 * v0 / 4250000;
        0x2::balance::join<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&mut arg0.airdrop_wallet_balance, 0x2::coin::into_balance<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(0x2::coin::mint<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&mut arg0.treasury, v6, arg2)));
        0x2::balance::join<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&mut arg0.team_wallet_balance, 0x2::coin::into_balance<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(0x2::coin::mint<0xe60484e21bc241ad42f43777b760bd36068bcc034f3687880907e647c42d3960::alpha::ALPHA>(&mut arg0.treasury, v0 - v6, arg2)));
    }

    // decompiled from Move bytecode v6
}

