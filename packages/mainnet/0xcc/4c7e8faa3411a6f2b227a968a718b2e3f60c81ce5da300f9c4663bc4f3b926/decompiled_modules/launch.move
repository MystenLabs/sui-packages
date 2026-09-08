module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::launch {
    struct InstadexMintLock<phantom T0> has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun launch<T0, T1>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg1: &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T1>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u8, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::id<T1>(arg1);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::take_launch_fee(arg0, arg4);
        let (v0, v1) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::quote_params<T1>(arg0);
        let v2 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::virtual_token(arg0);
        let v3 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::new<T0, T1>(arg2, arg3, v0, v2, v1, arg5, arg6, arg7, arg8);
        let v4 = 0x2::object::id<0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::Pool<T0, T1>>(&v3);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_launch(v4, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x2::tx_context::sender(arg8), arg5, arg6, v0, v2, 0x2::coin::get_name<T0>(arg3), 0x2::coin::get_symbol<T0>(arg3));
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::share<T0, T1>(v3);
        v4
    }

    public(friend) fun assert_instadex_amounts(arg0: u64, arg1: u64) {
        assert!(arg0 > 0 && arg1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
    }

    public fun burn_from_mint_lock<T0>(arg0: &mut InstadexMintLock<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::object::id<InstadexMintLock<T0>>(arg0);
        burn_pit_buy<T0>(arg0, v0, arg1);
    }

    public fun burn_pit_buy<T0>(arg0: &mut InstadexMintLock<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return
        };
        0x2::coin::burn<T0>(&mut arg0.cap, arg2);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_instadex_burn(arg1, v0);
    }

    public fun collect_instadex_fees<T0, T1>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::lock::BluefinPositionLock, arg1: &mut InstadexMintLock<T0>, arg2: &0x2::clock::Clock, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg6: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::lock::collect_lp_fees_return_token<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
        } else {
            0x2::coin::burn<T0>(&mut arg1.cap, 0x2::coin::from_balance<T0>(v0, arg7));
        };
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_instadex_burn(0x2::object::id<0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::lock::BluefinPositionLock>(arg0), v1);
    }

    public entry fun launch_entry<T0, T1>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg1: &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T1>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u8, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        launch<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun launch_instadex<T0, T1>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::take_launch_fee(arg0, arg8);
        let v0 = 0x2::coin::value<T0>(&arg6);
        let v1 = 0x2::coin::value<T1>(&arg7);
        assert_instadex_amounts(v0, v1);
        let (v2, v3, v4, _) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::lock::seed_and_lock_internal<T0, T1>(0x2::object::id_from_address(@0x0), 0x2::tx_context::sender(arg10), 0, arg1, arg2, arg4, arg5, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::lock::take_creation_fee(arg2, arg9, 0x2::tx_context::sender(arg10), arg10), 0x2::coin::into_balance<T0>(arg6), 0x2::coin::into_balance<T1>(arg7), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::sqrt_price_x64(v0, v1), arg10);
        let v6 = InstadexMintLock<T0>{
            id  : 0x2::object::new(arg10),
            cap : arg3,
        };
        0x2::transfer::share_object<InstadexMintLock<T0>>(v6);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_instadex_launch(v2, v3, v4, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x2::tx_context::sender(arg10), v0, v1, 0, 0x2::coin::get_name<T0>(arg4), 0x2::coin::get_symbol<T0>(arg4));
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_instadex_mint_lock(v2, 0x2::object::id<InstadexMintLock<T0>>(&v6));
        v2
    }

    public entry fun launch_instadex_entry<T0, T1>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        launch_instadex<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun launch_instant<T0, T1>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::take_launch_fee(arg0, arg7);
        let v0 = 0x2::coin::value<T0>(&arg6);
        assert!(v0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        let (v1, v2, v3, _) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::lock::seed_and_lock_instant<T0, T1>(0x2::tx_context::sender(arg9), arg1, arg2, arg4, arg5, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::lock::take_creation_fee(arg2, arg8, 0x2::tx_context::sender(arg9), arg9), 0x2::coin::into_balance<T0>(arg6), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::instant_virtual_quote<T1>(arg0), arg9);
        let v5 = InstadexMintLock<T0>{
            id  : 0x2::object::new(arg9),
            cap : arg3,
        };
        0x2::transfer::share_object<InstadexMintLock<T0>>(v5);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_instadex_launch(v1, v2, v3, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), 0x2::tx_context::sender(arg9), v0, 0, 0, 0x2::coin::get_name<T0>(arg4), 0x2::coin::get_symbol<T0>(arg4));
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_instadex_mint_lock(v1, 0x2::object::id<InstadexMintLock<T0>>(&v5));
        v1
    }

    public entry fun launch_instant_entry<T0, T1>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        launch_instant<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun pit_buy_and_burn() : u8 {
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::pit_buy_and_burn()
    }

    public fun pit_holders() : u8 {
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::pit_holders()
    }

    // decompiled from Move bytecode v7
}

