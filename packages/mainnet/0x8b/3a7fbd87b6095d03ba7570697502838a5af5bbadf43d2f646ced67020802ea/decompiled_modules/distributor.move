module 0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::distributor {
    struct Distributor has store, key {
        id: 0x2::object::UID,
        last_update_timestamp: u64,
        start_timestamp: u64,
        next_halving_timestamp: u64,
        target: u64,
        pool_allocator: 0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::allocator::Allocator,
        treasury: 0x2::coin::TreasuryCap<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>,
        fee_wallet: address,
        airdrop_wallet: address,
        team_wallet_balance: 0x2::balance::Balance<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>,
        cliff_for_team_wallet_in_days: u64,
        unlock_per_second: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public(friend) fun change_weight<T0>(arg0: &mut Distributor, arg1: 0x2::object::ID, arg2: u64) {
        0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::allocator::change_weight<T0>(&mut arg0.pool_allocator, arg1, arg2);
    }

    public(friend) fun get_rewards<T0>(arg0: &mut Distributor, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        withdraw_vested(arg0, arg2, arg3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v0) == true, 7);
        let v1 = 0x1::type_name::get<T0>();
        0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::allocator::get_rewards<T0>(&mut arg0.pool_allocator, arg1, *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v1), arg2)
    }

    public fun add_new_reward_token_to_pool<T0>(arg0: &0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::Admin_cap, arg1: &mut Distributor, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::allocator::add_new_reward_token_to_key<T0>(&mut arg1.pool_allocator, arg2, arg3, arg4, arg5);
    }

    public fun change_airdrop_wallet_address(arg0: &0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::Admin_cap, arg1: &mut Distributor, arg2: address) {
        arg1.airdrop_wallet = arg2;
    }

    public fun change_fee_wallet_address(arg0: &0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::Admin_cap, arg1: &mut Distributor, arg2: address) {
        arg1.fee_wallet = arg2;
    }

    public fun create(arg0: &0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::Admin_cap, arg1: 0x2::coin::TreasuryCap<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>, arg2: &0x2::clock::Clock, arg3: address, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Distributor{
            id                            : 0x2::object::new(arg6),
            last_update_timestamp         : 0x2::clock::timestamp_ms(arg2),
            start_timestamp               : 0x2::clock::timestamp_ms(arg2) + 1000 * 86400000,
            next_halving_timestamp        : 0,
            target                        : 0,
            pool_allocator                : 0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::allocator::create_allocator(arg6),
            treasury                      : arg1,
            fee_wallet                    : arg3,
            airdrop_wallet                : arg4,
            team_wallet_balance           : 0x2::balance::zero<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>(),
            cliff_for_team_wallet_in_days : arg5,
            unlock_per_second             : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::transfer::public_share_object<Distributor>(v0);
    }

    public fun get_airdrop_wallet_address(arg0: &mut Distributor) : address {
        arg0.airdrop_wallet
    }

    public fun get_fee_wallet_address(arg0: &mut Distributor) : address {
        arg0.fee_wallet
    }

    public fun send_rewards_to_pool_allocator<T0>(arg0: &mut Distributor, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::allocator::get_rewards_from_distributor<T0>(&mut arg0.pool_allocator, 0x2::coin::into_balance<T0>(arg1), arg2);
    }

    entry fun set_start_timestamp_and_destroy_cap(arg0: 0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::Burn_start_cap, arg1: &mut Distributor, arg2: &0x2::clock::Clock) {
        0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::destroy_start_cap(arg0);
        arg1.target = 4250000 * 1000000000;
        arg1.start_timestamp = 0x2::clock::timestamp_ms(arg2);
        arg1.last_update_timestamp = arg1.start_timestamp;
        arg1.next_halving_timestamp = arg1.start_timestamp + 100 * 86400000;
    }

    public fun set_unlock_per_second<T0>(arg0: &0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::Admin_cap, arg1: &mut Distributor, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.unlock_per_second, &v0) == true) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.unlock_per_second, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.unlock_per_second, v0, arg2);
        };
    }

    entry fun withdraw_team_balance(arg0: &0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::Admin_cap, arg1: &mut Distributor, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) > arg1.start_timestamp + arg1.cliff_for_team_wallet_in_days * 86400000, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>>(0x2::coin::from_balance<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>(0x2::balance::withdraw_all<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>(&mut arg1.team_wallet_balance), arg4), arg2);
    }

    public fun withdraw_vested(arg0: &mut Distributor, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start_timestamp) {
            return
        };
        let v1 = 0;
        while (arg0.next_halving_timestamp < v0) {
            v1 = v1 + (arg0.next_halving_timestamp - arg0.last_update_timestamp) * 1000 * arg0.target * 10 / 86400000;
            arg0.last_update_timestamp = arg0.next_halving_timestamp;
            arg0.next_halving_timestamp = arg0.next_halving_timestamp + 100 * 86400000;
            arg0.target = arg0.target / 2;
        };
        let v2 = v1 + (v0 - arg0.last_update_timestamp) * 1000 * arg0.target * 10 / 86400000;
        arg0.last_update_timestamp = v0;
        let v3 = 2850000 * v2 / 4250000;
        let v4 = 150000 * v2 / 4250000;
        let v5 = 0x2::coin::mint<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>(&mut arg0.treasury, v2 - v3 - v4, arg2);
        let v6 = 0x2::coin::mint<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>(&mut arg0.treasury, v4, arg2);
        let v7 = 0x2::coin::mint<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>(&mut arg0.treasury, v3, arg2);
        send_rewards_to_pool_allocator<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>(arg0, v7, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>>(v6, arg0.airdrop_wallet);
        0x2::balance::join<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>(&mut arg0.team_wallet_balance, 0x2::coin::into_balance<0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::alpha::ALPHA>(v5));
    }

    // decompiled from Move bytecode v6
}

