module 0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::distributor {
    struct Distributor has store, key {
        id: 0x2::object::UID,
        last_update_timestamp: u64,
        start_timestamp: u64,
        next_halving_timestamp: u64,
        target: u64,
        pool_allocator: 0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::Allocator,
        treasury: 0x2::coin::TreasuryCap<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>,
        fee_wallet: address,
        airdrop_wallet: address,
        team_wallet_address: address,
        team_wallet_balance: 0x2::balance::Balance<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>,
        unlock_per_second: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public fun add_new_pool(arg0: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::Admin_cap, arg1: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::Version, arg2: &mut Distributor, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::assert_current_version(arg1);
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::add_new_pool(&mut arg2.pool_allocator, arg3, arg4);
    }

    public(friend) fun get_rewards<T0>(arg0: &mut Distributor, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v0) == true) {
            let v2 = 0x1::type_name::get<T0>();
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v2)
        } else {
            0
        };
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, v1, arg2);
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::get_rewards<T0>(&mut arg0.pool_allocator, arg1)
    }

    public fun add_reward<T0>(arg0: &mut Distributor, arg1: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::Admin_cap, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock) {
        set_unlock_per_second<T0>(arg0, arg3, arg4);
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::coin::into_balance<T0>(arg2), arg4);
    }

    entry fun change_airdrop_wallet_address(arg0: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::Admin_cap, arg1: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::Version, arg2: &mut Distributor, arg3: address) {
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::assert_current_version(arg1);
        arg2.airdrop_wallet = arg3;
    }

    entry fun change_fee_wallet_address(arg0: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::Admin_cap, arg1: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::Version, arg2: &mut Distributor, arg3: address) {
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::assert_current_version(arg1);
        arg2.fee_wallet = arg3;
    }

    entry fun change_team_wallet_address(arg0: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::Admin_cap, arg1: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::Version, arg2: &mut Distributor, arg3: address) {
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::assert_current_version(arg1);
        arg2.team_wallet_address = arg3;
    }

    public fun create(arg0: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::Admin_cap, arg1: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::Version, arg2: 0x2::coin::TreasuryCap<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>, arg3: address, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Distributor{
            id                     : 0x2::object::new(arg6),
            last_update_timestamp  : 0,
            start_timestamp        : 0,
            next_halving_timestamp : 0,
            target                 : 0,
            pool_allocator         : 0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::create_allocator(arg6),
            treasury               : arg2,
            fee_wallet             : arg3,
            airdrop_wallet         : arg4,
            team_wallet_address    : arg5,
            team_wallet_balance    : 0x2::balance::zero<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>(),
            unlock_per_second      : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::transfer::public_share_object<Distributor>(v0);
    }

    public fun get_airdrop_wallet_address(arg0: &mut Distributor) : address {
        arg0.airdrop_wallet
    }

    public fun get_fee_wallet_address(arg0: &mut Distributor) : address {
        arg0.fee_wallet
    }

    public fun mark_for_deletion<T0>(arg0: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::Admin_cap, arg1: &mut Distributor, arg2: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::Version, arg3: vector<0x2::object::ID>, arg4: &0x2::clock::Clock) {
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::assert_current_version(arg2);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        set_weights<T0>(arg0, arg1, arg2, arg3, v0, arg4);
    }

    public fun remove_unlock_per_second<T0>(arg0: &mut Distributor, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v0) == true, 9);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v1) == true) {
            let v3 = 0x1::type_name::get<T0>();
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v3)
        } else {
            0
        };
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, v2, arg1);
        let v4 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.unlock_per_second, &v4);
    }

    fun send_rewards_to_pool_allocator<T0>(arg0: &mut Distributor, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::coin::into_balance<T0>(arg1), arg2);
    }

    entry fun set_start_timestamp_and_destroy_cap(arg0: 0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::Burn_start_cap, arg1: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::Version, arg2: &mut Distributor, arg3: &0x2::clock::Clock) {
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::assert_current_version(arg1);
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::destroy_start_cap(arg0);
        arg2.target = 4250000 * 1000000000;
        arg2.start_timestamp = 0x2::clock::timestamp_ms(arg3);
        arg2.last_update_timestamp = arg2.start_timestamp;
        arg2.next_halving_timestamp = arg2.start_timestamp + 100 * 86400000;
    }

    fun set_unlock_per_second<T0>(arg0: &mut Distributor, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v0) == true) {
            let v2 = 0x1::type_name::get<T0>();
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v2)
        } else {
            0
        };
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::top_up_pools<T0>(&mut arg0.pool_allocator, v1, arg2);
        let v3 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v3) == true) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.unlock_per_second, &v3) = arg1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.unlock_per_second, v3, arg1);
        };
    }

    public fun set_weights<T0>(arg0: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::Admin_cap, arg1: &mut Distributor, arg2: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::Version, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: &0x2::clock::Clock) {
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::assert_current_version(arg2);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == 0x1::vector::length<u64>(&arg4), 4);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.unlock_per_second, &v0) == true) {
            let v2 = 0x1::type_name::get<T0>();
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg1.unlock_per_second, &v2)
        } else {
            0
        };
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::top_up_pools<T0>(&mut arg1.pool_allocator, v1, arg5);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::allocator::set_weight<T0>(&mut arg1.pool_allocator, 0x1::vector::pop_back<0x2::object::ID>(&mut arg3), 0x1::vector::pop_back<u64>(&mut arg4));
            v3 = v3 + 1;
        };
    }

    entry fun withdraw_team_balance(arg0: &0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::Version, arg1: &mut Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::version::assert_current_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.start_timestamp + 300 * 86400000, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>>(0x2::coin::from_balance<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>(0x2::balance::withdraw_all<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>(&mut arg1.team_wallet_balance), arg3), arg1.team_wallet_address);
    }

    public fun withdraw_vested(arg0: &mut Distributor, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.target == 0) {
            return
        };
        let v1 = 0;
        while (arg0.next_halving_timestamp < v0) {
            v1 = v1 + (arg0.next_halving_timestamp - arg0.last_update_timestamp) / 1000 * arg0.target * 10 / 86400000;
            arg0.last_update_timestamp = arg0.next_halving_timestamp;
            arg0.next_halving_timestamp = arg0.next_halving_timestamp + 100 * 86400000;
            let v2 = (arg0.last_update_timestamp - arg0.start_timestamp) / 86400000;
            if (v2 < 900) {
                arg0.target = arg0.target / 2;
            };
            if (v2 >= 1000) {
                arg0.target = 0;
                break
            };
        };
        let v3 = v1 + (v0 - arg0.last_update_timestamp) / 1000 * arg0.target * 10 / 86400000;
        arg0.last_update_timestamp = v0;
        let v4 = 2850000 * v3 / 4250000;
        let v5 = 150000 * v3 / 4250000;
        let v6 = 0x2::coin::mint<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>(&mut arg0.treasury, v3 - v4 - v5, arg2);
        let v7 = 0x2::coin::mint<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>(&mut arg0.treasury, v5, arg2);
        let v8 = 0x2::coin::mint<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>(&mut arg0.treasury, v4, arg2);
        send_rewards_to_pool_allocator<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>(arg0, v8, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>>(v7, arg0.airdrop_wallet);
        0x2::balance::join<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>(&mut arg0.team_wallet_balance, 0x2::coin::into_balance<0xfed8ff791ee1476d3ddc1db512847cf8b1e0685a1a87ddce559eddca29fcbb0e::alpha::ALPHA>(v6));
    }

    // decompiled from Move bytecode v6
}

