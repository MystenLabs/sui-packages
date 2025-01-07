module 0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::kriya_adapter {
    public fun process<T0>(arg0: &mut 0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::safu_receipt::SafuReceipt<T0>, arg1: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::DefaultConfig, arg4: u64, arg5: address, arg6: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::safu_receipt::target<T0>(arg0) == 0, 0);
        let (v0, v1) = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::create_pool::create_pool<0x2::sui::SUI, T0>(arg3, arg1, arg2, false, arg4, arg6, arg7);
        let v2 = v0;
        let (v3, v4) = 0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::safu_receipt::extract_assets<T0>(arg0);
        let (v5, v6, v7, v8) = to_coins<0x2::sui::SUI, T0>(v3, v4, arg7);
        let (v9, v10, v11, _) = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::add_liquidity::add_liquidity<0x2::sui::SUI, T0>(&mut v2, v6, v5, v8, v7, false, arg6, arg7);
        let v13 = v11;
        let v14 = v10;
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v14)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v14), arg5);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v14);
        };
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v13)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v13), arg5);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v13);
        };
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::transfer<0x2::sui::SUI, T0>(v2);
        0x2::transfer::public_transfer<0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::PoolCap>(v1, arg5);
        0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::freezer::freeze_object<0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::KdxLpToken<0x2::sui::SUI, T0>>(v9, arg7);
    }

    fun to_coins<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        (0x2::coin::from_balance<T0>(arg0, arg2), 0x2::coin::from_balance<T1>(arg1, arg2), 0x2::balance::value<T0>(&arg0), 0x2::balance::value<T1>(&arg1))
    }

    // decompiled from Move bytecode v6
}

