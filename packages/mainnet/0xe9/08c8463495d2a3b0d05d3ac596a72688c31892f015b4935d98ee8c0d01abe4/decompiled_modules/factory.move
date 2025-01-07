module 0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory {
    struct TradeOperation<phantom T0> has copy, drop {
        operation: 0x1::string::String,
        wallet: address,
        quantity: u64,
        total_amount: u64,
        platform_fee: u64,
        coin_balance: u64,
        sui_balance: u64,
        initial_market_cap: u64,
        latest_price: u64,
        referrer: 0x1::string::String,
    }

    struct BondingCurveGoalEvent<phantom T0> has copy, drop {
        coin_balance: u64,
        sui_balance: u64,
        initial_market_cap: u64,
        latest_price: u64,
        referrer: 0x1::string::String,
    }

    struct CoinReserve<phantom T0> has key {
        id: 0x2::object::UID,
        coin_balance: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        initial_market_cap: u64,
        total_supply: u64,
        is_bonding_curve_goal_reached: bool,
    }

    struct PriceForToken {
        coin_reserve_id: 0x2::object::ID,
        count: u64,
        price: u64,
        decimal: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        coin_reserve_id: 0x2::object::ID,
    }

    struct FAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct AssetCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
        total_supply: u64,
        burnable: bool,
    }

    public fun new<T0: drop>(arg0: T0, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: bool, arg7: 0x1::fixed_point32::FixedPoint32, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 8);
        assert!(arg1 > 0, 2);
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 0, arg2, arg3, arg4, arg5, arg8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        let v2 = 0x2::coin::treasury_into_supply<T0>(v0);
        let v3 = AssetCap<T0>{
            id           : 0x2::object::new(arg8),
            supply       : v2,
            total_supply : arg1,
            burnable     : arg6,
        };
        let v4 = 0x2::object::new(arg8);
        let v5 = CoinReserve<T0>{
            id                            : v4,
            coin_balance                  : 0x2::balance::increase_supply<T0>(&mut v2, arg1),
            sui_balance                   : 0x2::balance::zero<0x2::sui::SUI>(),
            initial_market_cap            : 0x1::fixed_point32::multiply_u64(500 * 1000000000, arg7),
            total_supply                  : arg1,
            is_bonding_curve_goal_reached : false,
        };
        0x2::transfer::share_object<CoinReserve<T0>>(v5);
        let v6 = AdminCap{
            id              : 0x2::object::new(arg8),
            coin_reserve_id : 0x2::object::uid_to_inner(&v4),
        };
        0x2::transfer::public_transfer<AssetCap<T0>>(v3, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg8));
    }

    public fun buyCoins<T0: drop>(arg0: &mut CoinReserve<T0>, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0xd2a5dabef718a5908aa92dd10bf1fb2fe0a5305f18c7dc53c1753501ea96f6e2::collector::Collector, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_bonding_curve_goal_reached == false, 3);
        assert!(arg1 > 0, 1);
        let v0 = arg1 / 100;
        let v1 = arg1 - v0;
        assert!(v1 > 0, 1);
        let v2 = getTokensForSui<T0>(arg0, v1);
        let v3 = &mut arg0.coin_balance;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg1, 14);
        assert!(0x2::balance::value<T0>(v3) >= v2, 17);
        assert!(v2 >= arg5, 10);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v3, v2, arg7), arg3);
        0xd2a5dabef718a5908aa92dd10bf1fb2fe0a5305f18c7dc53c1753501ea96f6e2::collector::sendFee(arg4, 0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg7), arg7);
        let v4 = getBuyPriceForTokens<T0>(arg0, 1, arg7);
        let v5 = TradeOperation<T0>{
            operation          : 0x1::string::utf8(b"BUY"),
            wallet             : arg3,
            quantity           : v2,
            total_amount       : arg1,
            platform_fee       : v0,
            coin_balance       : 0x2::balance::value<T0>(&arg0.coin_balance),
            sui_balance        : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
            initial_market_cap : arg0.initial_market_cap,
            latest_price       : v4,
            referrer           : arg6,
        };
        0x2::event::emit<TradeOperation<T0>>(v5);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= 0xd2a5dabef718a5908aa92dd10bf1fb2fe0a5305f18c7dc53c1753501ea96f6e2::collector::getBondingCurveThreshold(arg4)) {
            arg0.is_bonding_curve_goal_reached = true;
            let v6 = BondingCurveGoalEvent<T0>{
                coin_balance       : 0x2::balance::value<T0>(&arg0.coin_balance),
                sui_balance        : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
                initial_market_cap : arg0.initial_market_cap,
                latest_price       : v4,
                referrer           : arg6,
            };
            0x2::event::emit<BondingCurveGoalEvent<T0>>(v6);
        };
    }

    fun check_admin<T0>(arg0: &CoinReserve<T0>, arg1: &AdminCap) {
        assert!(0x2::object::borrow_id<CoinReserve<T0>>(arg0) == &arg1.coin_reserve_id, 12);
    }

    public fun getBuyPriceForCoin<T0>(arg0: &mut CoinReserve<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : PriceForToken {
        let v0 = getBuyPriceForTokens<T0>(arg0, arg1, arg2);
        PriceForToken{
            coin_reserve_id : 0x2::object::uid_to_inner(&arg0.id),
            count           : arg1,
            price           : v0,
            decimal         : 1000000000,
        }
    }

    public fun getBuyPriceForTokens<T0>(arg0: &mut CoinReserve<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = (arg0.initial_market_cap as u128) + (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) as u128);
        let v1 = (0x2::balance::value<T0>(&arg0.coin_balance) as u128);
        ((v0 * v1 / (v1 - (arg1 as u128)) - v0) as u64)
    }

    public fun getNumberOfTokensForSui<T0>(arg0: &mut CoinReserve<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : PriceForToken {
        let v0 = getTokensForSui<T0>(arg0, arg1);
        PriceForToken{
            coin_reserve_id : 0x2::object::uid_to_inner(&arg0.id),
            count           : arg1,
            price           : v0,
            decimal         : 1000000000,
        }
    }

    public fun getTokensForSui<T0>(arg0: &mut CoinReserve<T0>, arg1: u64) : u64 {
        let v0 = (arg0.initial_market_cap as u128) + (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) as u128);
        let v1 = (0x2::balance::value<T0>(&arg0.coin_balance) as u128);
        ((v1 - v0 * v1 / (v0 + (arg1 as u128))) as u64)
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<FAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun moveToFlowX<T0>(arg0: &mut CoinReserve<T0>, arg1: &AdminCap, arg2: &mut 0xd2a5dabef718a5908aa92dd10bf1fb2fe0a5305f18c7dc53c1753501ea96f6e2::collector::Collector, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_admin<T0>(arg0, arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= 0xd2a5dabef718a5908aa92dd10bf1fb2fe0a5305f18c7dc53c1753501ea96f6e2::collector::getBondingCurveThreshold(arg2), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, 0x2::balance::value<T0>(&arg0.coin_balance), arg4), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg4), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, 0xd2a5dabef718a5908aa92dd10bf1fb2fe0a5305f18c7dc53c1753501ea96f6e2::collector::getBondingCurveFee(arg2), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun sellCoins<T0>(arg0: &mut CoinReserve<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &0xd2a5dabef718a5908aa92dd10bf1fb2fe0a5305f18c7dc53c1753501ea96f6e2::collector::Collector, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_bonding_curve_goal_reached == false, 3);
        assert!(arg2 > 0, 6);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 16);
        let v0 = getBuyPriceForTokens<T0>(arg0, arg2, arg6);
        let v1 = v0;
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) <= v0) {
            v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) / (1000000000 - 0x2::balance::value<T0>(&arg0.coin_balance)) * arg2;
        };
        let v2 = v1 / 100;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= v1, 15);
        assert!(v1 >= arg4, 9);
        0x2::coin::put<T0>(&mut arg0.coin_balance, 0x2::coin::split<T0>(arg1, arg2, arg6));
        0xd2a5dabef718a5908aa92dd10bf1fb2fe0a5305f18c7dc53c1753501ea96f6e2::collector::sendFee(arg3, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v2, arg6), arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v1 - v2, arg6), v3);
        let v4 = getBuyPriceForTokens<T0>(arg0, 1, arg6);
        let v5 = TradeOperation<T0>{
            operation          : 0x1::string::utf8(b"BUY"),
            wallet             : v3,
            quantity           : arg2,
            total_amount       : v1 - v2,
            platform_fee       : v2,
            coin_balance       : 0x2::balance::value<T0>(&arg0.coin_balance),
            sui_balance        : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
            initial_market_cap : arg0.initial_market_cap,
            latest_price       : v4,
            referrer           : arg5,
        };
        0x2::event::emit<TradeOperation<T0>>(v5);
    }

    // decompiled from Move bytecode v6
}

