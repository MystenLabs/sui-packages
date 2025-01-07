module 0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::distributor {
    struct Distributor has store, key {
        id: 0x2::object::UID,
        last_update_timestamp: u64,
        start_day: u64,
        next_halving_timestamp: u64,
        target: u64,
        pool_allocator: 0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::Allocator<0x2::object::ID>,
        tokenomics_allocator: 0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::Allocator<address>,
        treasury: 0x2::coin::TreasuryCap<0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::ALPHA>,
        fee_wallet: address,
        airdrop_wallet: address,
        cliff_for_wallets_in_days: u64,
        unlock_per_second: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public(friend) fun change_weight<T0>(arg0: &mut Distributor, arg1: 0x2::object::ID, arg2: u64) {
        0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::change_weight<0x2::object::ID, T0>(&mut arg0.pool_allocator, arg1, arg2);
    }

    public(friend) fun get_rewards<T0>(arg0: &mut Distributor, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        withdraw_vested(arg0, arg2, arg3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v0) == true, 7);
        let v1 = 0x1::type_name::get<T0>();
        0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::get_rewards<0x2::object::ID, T0>(&mut arg0.pool_allocator, arg1, *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.unlock_per_second, &v1), arg2)
    }

    public fun add_new_reward_token_to_pool<T0>(arg0: &0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::Admin_cap, arg1: &mut Distributor, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::add_new_reward_token_to_key<0x2::object::ID, T0>(&mut arg1.pool_allocator, arg2, arg3, arg4, arg5);
    }

    public fun add_wallet<T0>(arg0: &0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::Admin_cap, arg1: &mut Distributor, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::add_new_reward_token_to_key<address, T0>(&mut arg1.tokenomics_allocator, arg2, arg3, arg4, arg5);
    }

    public fun change_airdrop_wallet_address(arg0: &0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::Admin_cap, arg1: &mut Distributor, arg2: address) {
        arg1.airdrop_wallet = arg2;
    }

    public fun change_fee_wallet_address(arg0: &0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::Admin_cap, arg1: &mut Distributor, arg2: address) {
        arg1.fee_wallet = arg2;
    }

    public fun create(arg0: &0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::Admin_cap, arg1: 0x2::coin::TreasuryCap<0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::ALPHA>, arg2: &0x2::clock::Clock, arg3: u64, arg4: address, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Distributor{
            id                        : 0x2::object::new(arg7),
            last_update_timestamp     : 0x2::clock::timestamp_ms(arg2),
            start_day                 : 0x2::clock::timestamp_ms(arg2),
            next_halving_timestamp    : 0x2::clock::timestamp_ms(arg2) + 100 * 86400000,
            target                    : arg3 * 1000000000,
            pool_allocator            : 0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::create_allocator<0x2::object::ID>(arg7),
            tokenomics_allocator      : 0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::create_allocator<address>(arg7),
            treasury                  : arg1,
            fee_wallet                : arg4,
            airdrop_wallet            : arg5,
            cliff_for_wallets_in_days : arg6,
            unlock_per_second         : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
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
        0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::get_rewards_from_distributor<0x2::object::ID, T0>(&mut arg0.pool_allocator, 0x2::coin::into_balance<T0>(arg1), arg2);
    }

    fun send_rewards_to_tokenomics_allocator<T0>(arg0: &mut Distributor, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::get_rewards_from_distributor<address, T0>(&mut arg0.tokenomics_allocator, 0x2::coin::into_balance<T0>(arg1), arg2);
        if ((0x2::clock::timestamp_ms(arg2) - arg0.start_day) / 86400000 >= arg0.cliff_for_wallets_in_days) {
            0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::allocator::transfer_rewards_to_all_wallets<T0>(&mut arg0.tokenomics_allocator, arg2, arg3);
        };
    }

    public fun set_unlock_per_second<T0>(arg0: &0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::Admin_cap, arg1: &mut Distributor, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.unlock_per_second, &v0) == true) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.unlock_per_second, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.unlock_per_second, v0, arg2);
        };
    }

    public fun withdraw_vested(arg0: &mut Distributor, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0;
        while (arg0.next_halving_timestamp < v0) {
            v1 = v1 + (arg0.next_halving_timestamp - arg0.last_update_timestamp) * 1000 * arg0.target * 10 / 86400000;
            arg0.last_update_timestamp = arg0.next_halving_timestamp;
            arg0.next_halving_timestamp = arg0.next_halving_timestamp + 100 * 86400000;
            arg0.target = arg0.target / 2;
        };
        let v2 = v1 + (v0 - arg0.last_update_timestamp) * 1000 * arg0.target * 10 / 86400000;
        arg0.last_update_timestamp = v0;
        let v3 = 0x2::coin::mint<0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::ALPHA>(&mut arg0.treasury, 40 * v2 / 100, arg2);
        let v4 = 0x2::coin::mint<0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::ALPHA>(&mut arg0.treasury, 5 * v2 / 100, arg2);
        let v5 = 0x2::coin::mint<0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::ALPHA>(&mut arg0.treasury, 55 * v2 / 100, arg2);
        send_rewards_to_pool_allocator<0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::ALPHA>(arg0, v5, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::ALPHA>>(v4, arg0.airdrop_wallet);
        send_rewards_to_tokenomics_allocator<0x6681daaa600db3140190cecfd05fbe5eedcbd5f683fc80886b0f6c9566202f71::alpha::ALPHA>(arg0, v3, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

