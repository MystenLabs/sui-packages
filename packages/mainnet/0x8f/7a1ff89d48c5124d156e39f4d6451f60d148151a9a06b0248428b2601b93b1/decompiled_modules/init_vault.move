module 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::init_vault {
    struct SeedReceipt {
        vault_id: 0x2::object::ID,
        current_sqrt_price: u128,
        lower_tick_index: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32,
        upper_tick_index: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32,
    }

    fun check_receipt_vault_compatibility<T0, T1, T2, T3: copy + drop + store>(arg0: &SeedReceipt, arg1: &0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::Vault<T0, T1, T2, T3>) {
        assert!(arg0.vault_id == 0x2::object::id<0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::Vault<T0, T1, T2, T3>>(arg1), 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::error::seed_receipt_vault_incompatible());
    }

    public fun drift_vault_seed_handler<T0, T1, T2>(arg0: &mut 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::Vault<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Drift>, arg1: SeedReceipt, arg2: &0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::version::Version) {
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::version::assert_supported_version(arg2);
        check_receipt_vault_compatibility<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Drift>(&arg1, arg0);
        let SeedReceipt {
            vault_id           : _,
            current_sqrt_price : v1,
            lower_tick_index   : _,
            upper_tick_index   : _,
        } = arg1;
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::set_drift_trigger_price(0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::borrow_mut_config<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Drift>(arg0), 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::utils::scale(v1, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::drift_trigger_price_scalling(0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::borrow_config<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Drift>(arg0))));
    }

    public fun seed<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::VaultCap, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::version::Version, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SeedReceipt {
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::version::assert_supported_version(arg6);
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg2);
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::check_vault_cap_compatibility<T0, T1, T2, T3>(arg0, arg1);
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::check_vault_cap_uninitialised(arg1);
        assert!(arg3 > 0, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::error::seed_val_is_zero());
        assert!(arg3 <= 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::constants::max_vc_amount_per_seed(), 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::error::exceeded_max_seed_val());
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        let (v2, v3) = 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::get_price_scalling<T0, T1, T2, T3>(arg0);
        let (v4, v5) = 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::utils::get_scalled_position_bounds(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg2), v2, v3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg2));
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::utils::create_position<T0, T1, T2, T3>(arg0, arg2, v5, v4, arg7, arg9);
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::utils::add_liquidity<T0, T1, T2, T3>(arg0, arg2, &mut v0, &mut v1, arg8, arg7, arg9);
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::update_ticks_info<T0, T1, T2, T3>(arg0, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v4), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v5));
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg9), 0x2::tx_context::sender(arg9));
        };
        if (0x2::balance::value<T1>(&v1) == 0) {
            0x2::balance::destroy_zero<T1>(v1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg9), 0x2::tx_context::sender(arg9));
        };
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::seed<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T2>(0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::mint_vault_coin_unsafe<T0, T1, T2, T3>(arg0, arg3, arg9)));
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::set_intialised(arg1);
        SeedReceipt{
            vault_id           : 0x2::object::id<0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::Vault<T0, T1, T2, T3>>(arg0),
            current_sqrt_price : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg2),
            lower_tick_index   : v4,
            upper_tick_index   : v5,
        }
    }

    public fun stable_seed_handler<T0, T1, T2>(arg0: &mut 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::Vault<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Stable>, arg1: SeedReceipt, arg2: &0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::version::Version) {
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::version::assert_supported_version(arg2);
        check_receipt_vault_compatibility<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Stable>(&arg1, arg0);
        let SeedReceipt {
            vault_id           : _,
            current_sqrt_price : _,
            lower_tick_index   : _,
            upper_tick_index   : _,
        } = arg1;
    }

    public fun uncorrelated_seed_handler<T0, T1, T2>(arg0: &mut 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::Vault<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Uncorrelated>, arg1: SeedReceipt, arg2: &0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::version::Version) {
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::version::assert_supported_version(arg2);
        check_receipt_vault_compatibility<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Uncorrelated>(&arg1, arg0);
        let SeedReceipt {
            vault_id           : _,
            current_sqrt_price : v1,
            lower_tick_index   : _,
            upper_tick_index   : _,
        } = arg1;
        let (v4, v5) = 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::get_trigger_price_scalling(0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::borrow_config<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Uncorrelated>(arg0));
        0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::set_trigger_price(0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::vault::borrow_mut_config<T0, T1, T2, 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::config::Uncorrelated>(arg0), 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::utils::scale(v1, v4), 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::utils::scale(v1, v5));
    }

    // decompiled from Move bytecode v6
}

