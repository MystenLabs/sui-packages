module 0x1ba416526af31544feaa64b0aa0c61de99aad9bfd474f2fa3ff3351e709df7ac::factory {
    struct Bill has store, key {
        id: 0x2::object::UID,
        result: u64,
        decimal: u64,
        count: u64,
    }

    struct CoinReserve<phantom T0> has key {
        id: 0x2::object::UID,
        coin_balance: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        initial_market_cap: u64,
        total_supply: u64,
        initial_price: u64,
        fee: u64,
    }

    struct PriceForToken {
        coin_reserve_id: 0x2::object::ID,
        count: u64,
        price: u64,
        decimal: u64,
    }

    struct Receipt<phantom T0> {
        coin_reserve_id: 0x2::object::ID,
        count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        coin_reserve_id: 0x2::object::ID,
    }

    struct AssetCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
        total_supply: u64,
        burnable: bool,
    }

    struct AssetMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        total_supply: u64,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        market_cap_usd: u64,
        market_cap: u64,
        initial_price: u64,
    }

    struct CoinToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun new<T0: drop>(arg0: T0, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: bool, arg7: 0x1::fixed_point32::FixedPoint32, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 8);
        assert!(arg1 > 0, 2);
        let v0 = 0x1::fixed_point32::multiply_u64(5600 * 1000000000, arg7);
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg0, 0, arg2, arg3, arg4, arg5, arg8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        let v3 = 0x2::coin::treasury_into_supply<T0>(v1);
        let v4 = AssetCap<T0>{
            id           : 0x2::object::new(arg8),
            supply       : v3,
            total_supply : arg1,
            burnable     : arg6,
        };
        let v5 = 0x2::object::new(arg8);
        let v6 = CoinReserve<T0>{
            id                 : v5,
            coin_balance       : 0x2::balance::increase_supply<T0>(&mut v3, arg1),
            sui_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            initial_market_cap : v0,
            total_supply       : arg1,
            initial_price      : v0 / arg1,
            fee                : 1000000,
        };
        0x2::transfer::share_object<CoinReserve<T0>>(v6);
        let v7 = AdminCap{
            id              : 0x2::object::new(arg8),
            coin_reserve_id : 0x2::object::uid_to_inner(&v5),
        };
        0x2::transfer::public_transfer<AssetCap<T0>>(v4, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<AdminCap>(v7, 0x2::tx_context::sender(arg8));
    }

    public fun buyCoins<T0: drop>(arg0: &mut CoinReserve<T0>, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &0x1ba416526af31544feaa64b0aa0c61de99aad9bfd474f2fa3ff3351e709df7ac::collector::Collector, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = getBuyPriceForCoin<T0>(arg0, arg1, arg5);
        let v1 = &mut arg0.coin_balance;
        let PriceForToken {
            coin_reserve_id : _,
            count           : v3,
            price           : v4,
            decimal         : _,
        } = v0;
        let v6 = v4 / 100;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v4 + v6, 14);
        assert!(0x2::balance::value<T0>(v1) >= v3, 17);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::split<0x2::sui::SUI>(arg2, v4, arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, v3, arg5), arg3);
        0x1ba416526af31544feaa64b0aa0c61de99aad9bfd474f2fa3ff3351e709df7ac::collector::sendFee(arg4, 0x2::coin::split<0x2::sui::SUI>(arg2, v6, arg5), arg5);
    }

    fun calculateTokenPrice(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg1 * arg0 / arg2
    }

    fun check_admin<T0>(arg0: &CoinReserve<T0>, arg1: &AdminCap) {
        assert!(0x2::object::borrow_id<CoinReserve<T0>>(arg0) == &arg1.coin_reserve_id, 12);
    }

    public fun coin_reserve_id<T0>(arg0: &Receipt<T0>) : 0x2::object::ID {
        arg0.coin_reserve_id
    }

    public fun fee<T0>(arg0: &CoinReserve<T0>) : u64 {
        arg0.fee
    }

    fun fetchSUIToUSDPrice() : u64 {
        1
    }

    public fun getBuyPrice<T0>(arg0: &mut CoinReserve<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = (arg0.initial_market_cap as u128) + (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) as u128);
        let v1 = (0x2::balance::value<T0>(&arg0.coin_balance) as u128);
        ((v0 - v0 * v1 / (v1 + (arg1 as u128))) as u64)
    }

    public fun getBuyPriceForCoin<T0>(arg0: &mut CoinReserve<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : PriceForToken {
        let v0 = (arg0.initial_market_cap as u128) + (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) as u128);
        let v1 = (0x2::balance::value<T0>(&arg0.coin_balance) as u128);
        PriceForToken{
            coin_reserve_id : 0x2::object::uid_to_inner(&arg0.id),
            count           : arg1,
            price           : ((v0 - v0 * v1 / (v1 + (arg1 as u128))) as u64),
            decimal         : 1000,
        }
    }

    public fun getMyBalance<T0: drop>(arg0: &mut CoinReserve<T0>, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&mut arg0.coin_balance) <= arg1) {
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::split<0x2::sui::SUI>(arg2, 2224795, arg3));
            let v0 = Bill{
                id      : 0x2::object::new(arg3),
                result  : 0x2::coin::value<0x2::sui::SUI>(arg2),
                decimal : 1000,
                count   : arg1,
            };
            0x2::transfer::public_transfer<Bill>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::split<0x2::sui::SUI>(arg2, 5224795, arg3));
            let v1 = Bill{
                id      : 0x2::object::new(arg3),
                result  : 0x2::coin::value<0x2::sui::SUI>(arg2),
                decimal : 1000,
                count   : arg1,
            };
            0x2::transfer::public_transfer<Bill>(v1, 0x2::tx_context::sender(arg3));
        };
    }

    public fun sellCoins<T0>(arg0: &mut CoinReserve<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x1ba416526af31544feaa64b0aa0c61de99aad9bfd474f2fa3ff3351e709df7ac::collector::Collector, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 16);
        let v0 = getBuyPriceForCoin<T0>(arg0, arg2, arg4);
        let PriceForToken {
            coin_reserve_id : _,
            count           : v2,
            price           : v3,
            decimal         : _,
        } = v0;
        let v5 = v3 / 100;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= v3, 15);
        0x2::coin::put<T0>(&mut arg0.coin_balance, 0x2::coin::split<T0>(arg1, v2, arg4));
        0x1ba416526af31544feaa64b0aa0c61de99aad9bfd474f2fa3ff3351e709df7ac::collector::sendFee(arg3, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v5, arg4), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v3 - v5, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun update_fee<T0>(arg0: &mut CoinReserve<T0>, arg1: &AdminCap, arg2: u64) {
        check_admin<T0>(arg0, arg1);
        arg0.fee = arg2;
    }

    // decompiled from Move bytecode v6
}

