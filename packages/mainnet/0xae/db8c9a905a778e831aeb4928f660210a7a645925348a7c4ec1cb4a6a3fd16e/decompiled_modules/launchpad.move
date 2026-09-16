module 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::launchpad {
    struct Launchpad has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Adopted has copy, drop {
        pool: 0x2::object::ID,
        adopter: address,
        reserve: u64,
    }

    public fun new(arg0: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::authorize(arg0, arg1);
        let v0 = Launchpad{
            id     : 0x2::object::new(arg2),
            config : 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg0),
            fees   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Launchpad>(v0);
    }

    public fun adopt_composite<T0, T1, T2>(arg0: &mut Launchpad, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::Settings, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::composite_pool::PoolCap, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.config == 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), 3);
        assert!(0x2::coin::value<T0>(&arg7) > 0, 1);
        let v0 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::launch_fee(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= v0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg9, v0, arg16)));
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::platform_fees::accrued<0x2::sui::SUI>(0x2::object::id<Launchpad>(arg0), 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.fees));
        let (v1, v2) = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::composite_pool::prepare<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11, arg12, arg13, arg14, 0, arg15, arg16);
        let v3 = v1;
        let v4 = Adopted{
            pool    : 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::composite_pool::CompositePool<T0, T1, T2>>(&v3),
            adopter : 0x2::tx_context::sender(arg16),
            reserve : 0x2::coin::value<T0>(&arg7),
        };
        0x2::event::emit<Adopted>(v4);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::composite_pool::share<T0, T1, T2>(v3);
        (v2, arg9)
    }

    public fun adopt_spot<T0, T1>(arg0: &mut Launchpad, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::Settings, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::PoolCap, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::LpPosition, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.config == 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), 3);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 1);
        let v0 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::launch_fee(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg7)));
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::platform_fees::accrued<0x2::sui::SUI>(0x2::object::id<Launchpad>(arg0), 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.fees));
        let (v1, v2, v3) = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::create<T0, T1>(arg1, arg2, arg3, arg5, 0, arg6, arg7);
        let v4 = v1;
        let v5 = Adopted{
            pool    : 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::Pool<T0, T1>>(&v4),
            adopter : 0x2::tx_context::sender(arg7),
            reserve : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<Adopted>(v5);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::share<T0, T1>(v4);
        (v2, v3, arg4)
    }

    public fun collect(arg0: &mut Launchpad, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.config == 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), 3);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::authorize(arg1, arg2);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fees);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::platform_fees::collected<0x2::sui::SUI>(0x2::object::id<Launchpad>(arg0), 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.fees), 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fees, v0), arg3)
    }

    public fun launch<T0, T1>(arg0: &mut Launchpad, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::Settings, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::PoolCap, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::LpPosition, 0x2::coin::Coin<0x2::sui::SUI>) {
        abort 4
    }

    public fun launch_registered<T0, T1>(arg0: &mut Launchpad, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::CurrencyInitializer<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::Settings, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::PoolCap, 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::LpPosition, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.config == 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), 3);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0 && arg6 > 0, 1);
        let v0 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::launch_fee(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v0, arg10)));
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::platform_fees::accrued<0x2::sui::SUI>(0x2::object::id<Launchpad>(arg0), 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.fees));
        let (v1, v2, v3) = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::create<T0, T1>(arg1, 0x2::coin::mint<T0>(&mut arg2, arg6, arg10), arg4, arg7, arg8, arg9, arg10);
        0x2::coin_registry::make_supply_fixed_init<T0>(&mut arg3, arg2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<T0>(arg3, arg10);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::share<T0, T1>(v1);
        (v2, v3, arg5)
    }

    public fun prepare_composite_registered<T0, T1, T2>(arg0: &mut Launchpad, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin_registry::CurrencyInitializer<T0>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::settings::Settings, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::composite_pool::PoolCap, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.config == 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), 3);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0 && arg11 > 0, 1);
        let v0 = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::launch_fee(0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::params(arg1));
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg10) >= v0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg10, v0, arg19)));
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::platform_fees::accrued<0x2::sui::SUI>(0x2::object::id<Launchpad>(arg0), 0x2::object::id<0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config>(arg1), v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.fees));
        let (v1, v2) = 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::composite_pool::prepare<T0, T1, T2>(arg1, arg4, arg5, arg6, arg7, arg8, 0x2::coin::mint<T0>(&mut arg2, arg11, arg19), arg9, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        0x2::coin_registry::make_supply_fixed_init<T0>(&mut arg3, arg2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<T0>(arg3, arg19);
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::composite_pool::share<T0, T1, T2>(v1);
        (v2, arg10)
    }

    // decompiled from Move bytecode v7
}

