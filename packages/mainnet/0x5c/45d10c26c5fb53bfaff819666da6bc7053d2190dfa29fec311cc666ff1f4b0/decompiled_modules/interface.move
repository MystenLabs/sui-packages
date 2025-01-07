module 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::interface {
    public entry fun add_liquidity<T0, T1, T2>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T1>>, arg3: vector<0x2::coin::Coin<T2>>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T1, T2>()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::LPCoin<T0, T1, T2>>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::add_liquidity<T0, T1, T2>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T1>(arg2, arg4, arg7), 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T2>(arg3, arg5, arg7), arg6, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::LPCoin<T0, T2, T1>>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::add_liquidity<T0, T2, T1>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T2>(arg3, arg5, arg7), 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T1>(arg2, arg4, arg7), arg6, arg7), 0x2::tx_context::sender(arg7));
        };
    }

    public entry fun create_s_pool<T0, T1>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T0, T1>()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::LPCoin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::create_s_pool<T0, T1>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T0>(arg2, arg4, arg8), 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T1>(arg3, arg5, arg8), arg6, arg7, arg8), 0x2::tx_context::sender(arg8));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::LPCoin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T1, T0>>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::create_s_pool<T1, T0>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T1>(arg3, arg5, arg8), 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T0>(arg2, arg4, arg8), arg7, arg6, arg8), 0x2::tx_context::sender(arg8));
        };
    }

    public entry fun create_v_pool<T0, T1>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T0, T1>()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::LPCoin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Volatile, T0, T1>>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::create_v_pool<T0, T1>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T0>(arg2, arg4, arg6), 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T1>(arg3, arg5, arg6), arg6), 0x2::tx_context::sender(arg6));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::LPCoin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Volatile, T1, T0>>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::create_v_pool<T1, T0>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T1>(arg3, arg5, arg6), 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T0>(arg2, arg4, arg6), arg6), 0x2::tx_context::sender(arg6));
        };
    }

    public fun get_pool_id<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage) : 0x2::object::ID {
        if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T1, T2>()) {
            0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_pool_id<T0, T1, T2>(arg0)
        } else {
            0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_pool_id<T0, T2, T1>(arg0)
        }
    }

    public entry fun remove_liquidity<T0, T1, T2>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::LPCoin<T0, T1, T2>>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::remove_liquidity<T0, T1, T2>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::LPCoin<T0, T1, T2>>(arg2, arg3, arg6), arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, v0);
    }

    public entry fun burn_ipx(arg0: &mut 0x49d87b9af35c4fef28def2cd65884aa9c49bb4eedbcee647f4dafb5c8f36ba57::ipx::IPXStorage, arg1: 0x2::coin::Coin<0x49d87b9af35c4fef28def2cd65884aa9c49bb4eedbcee647f4dafb5c8f36ba57::ipx::IPX>) {
        0x49d87b9af35c4fef28def2cd65884aa9c49bb4eedbcee647f4dafb5c8f36ba57::ipx::burn(arg0, arg1);
    }

    fun get_farm<T0>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::MasterChefStorage, arg1: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::AccountStorage, arg2: address, arg3: &mut vector<vector<u64>>) {
        let v0 = 0x1::vector::empty<u64>();
        let (v1, _, _, v4) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::get_pool_info<T0>(arg0);
        0x1::vector::push_back<u64>(&mut v0, v1);
        0x1::vector::push_back<u64>(&mut v0, v4);
        if (0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::account_exists<T0>(arg0, arg1, arg2)) {
            let (v5, _) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::get_account_info<T0>(arg0, arg1, arg2);
            0x1::vector::push_back<u64>(&mut v0, v5);
        } else {
            0x1::vector::push_back<u64>(&mut v0, 0);
        };
        0x1::vector::push_back<vector<u64>>(arg3, v0);
    }

    public fun get_farms<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::MasterChefStorage, arg1: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::AccountStorage, arg2: address, arg3: u64) : vector<vector<u64>> {
        let v0 = 0x1::vector::empty<vector<u64>>();
        let v1 = &mut v0;
        get_farm<T0>(arg0, arg1, arg2, v1);
        if (arg3 == 1) {
            return v0
        };
        let v2 = &mut v0;
        get_farm<T1>(arg0, arg1, arg2, v2);
        if (arg3 == 2) {
            return v0
        };
        let v3 = &mut v0;
        get_farm<T2>(arg0, arg1, arg2, v3);
        v0
    }

    public entry fun get_rewards<T0>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::MasterChefStorage, arg1: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::AccountStorage, arg2: &mut 0x49d87b9af35c4fef28def2cd65884aa9c49bb4eedbcee647f4dafb5c8f36ba57::ipx::IPXStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x49d87b9af35c4fef28def2cd65884aa9c49bb4eedbcee647f4dafb5c8f36ba57::ipx::IPX>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::get_rewards<T0>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun one_hop_swap<T0, T1, T2>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::one_hop_swap<T0, T1, T2>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T0>(arg2, arg3, arg6), arg4, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun stake<T0>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::MasterChefStorage, arg1: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::AccountStorage, arg2: &mut 0x49d87b9af35c4fef28def2cd65884aa9c49bb4eedbcee647f4dafb5c8f36ba57::ipx::IPXStorage, arg3: &0x2::clock::Clock, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x49d87b9af35c4fef28def2cd65884aa9c49bb4eedbcee647f4dafb5c8f36ba57::ipx::IPX>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::stake<T0>(arg0, arg1, arg2, arg3, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T0>(arg4, arg5, arg6), arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun swap_x<T0, T1>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::swap_token_x<T0, T1>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T0>(arg2, arg3, arg6), arg4, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun swap_y<T0, T1>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::swap_token_y<T0, T1>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T1>(arg2, arg3, arg6), arg4, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun two_hop_swap<T0, T1, T2, T3>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::two_hop_swap<T0, T1, T2, T3>(arg0, arg1, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T0>(arg2, arg3, arg6), arg4, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun unstake<T0>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::MasterChefStorage, arg1: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::AccountStorage, arg2: &mut 0x49d87b9af35c4fef28def2cd65884aa9c49bb4eedbcee647f4dafb5c8f36ba57::ipx::IPXStorage, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::unstake<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x49d87b9af35c4fef28def2cd65884aa9c49bb4eedbcee647f4dafb5c8f36ba57::ipx::IPX>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
    }

    public entry fun update_all_pools(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::MasterChefStorage, arg1: &0x2::clock::Clock) {
        0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::update_all_pools(arg0, arg1);
    }

    public entry fun update_pool<T0>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::MasterChefStorage, arg1: &0x2::clock::Clock) {
        0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::master_chef::update_pool<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

