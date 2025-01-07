module 0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::lendit {
    struct LENDIT_COIN has drop {
        dummy_field: bool,
    }

    struct Reserve<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<LENDIT_COIN>,
        reserve_coin: address,
        navi: Navi<T1>,
        suilend: Suilend<T0>,
        availible_balance: 0x2::coin::Coin<T1>,
    }

    struct Navi<phantom T0> has store, key {
        id: 0x2::object::UID,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        pool: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,
        asset: u8,
        storage: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,
        inc_v1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,
        inc_v2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,
    }

    struct Suilend<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        lending_market: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>,
        reserve_array_index: u64,
        price_info: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject,
    }

    fun mint<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LENDIT_COIN> {
        0x2::coin::mint<LENDIT_COIN>(&mut arg0.treasury, convert_to_shares<T0, T1>(arg0, arg1, arg2), arg3)
    }

    fun convert_to_assets<T0, T1>(arg0: &Reserve<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::coin::total_supply<LENDIT_COIN>(&arg0.treasury);
        if (v0 == 0) {
            return arg1
        };
        arg1 * arg2 / v0
    }

    fun convert_to_shares<T0, T1>(arg0: &Reserve<T0, T1>, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return arg1
        };
        arg1 * 0x2::coin::total_supply<LENDIT_COIN>(&arg0.treasury) / arg2
    }

    fun create_lendit_coin(arg0: LENDIT_COIN, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<LENDIT_COIN> {
        let (v0, v1) = 0x2::coin::create_currency<LENDIT_COIN>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<0x2::url::Url>(), arg5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LENDIT_COIN>>(v1);
        v0
    }

    fun current_balance<T0, T1>(arg0: &mut Reserve<T0, T1>) : u64 {
        0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::navi::navi_balance<T1>(&arg0.navi.account_cap, &arg0.navi.pool, arg0.navi.asset, &mut arg0.navi.storage) + 0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::suilend::suilend_balance<T0, T1>(&arg0.suilend.lending_market, arg0.suilend.reserve_array_index, &arg0.suilend.obligation) + 0x2::coin::value<T1>(&arg0.availible_balance)
    }

    public fun deposit<T0, T1>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T1>, arg2: &mut Reserve<T0, T1>, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LENDIT_COIN> {
        let v0 = current_balance<T0, T1>(arg2);
        0x2::coin::join<T1>(&mut arg2.availible_balance, arg1);
        let v1 = mint<T0, T1>(arg2, 0x2::coin::value<T1>(&arg1), v0, arg4);
        optimise<T0, T1>(arg0, arg2, arg3, arg4);
        v1
    }

    public fun init_with_asset<T0, T1>(arg0: LENDIT_COIN, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: u8, arg8: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg10: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg12: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg13: u64, arg14: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg15);
        let v1 = create_lendit_coin(arg0, arg1, arg2, arg3, arg4, arg15);
        let v2 = 0x2::object::new(arg15);
        let v3 = navi_create_account_cap(arg15);
        let v4 = Navi<T1>{
            id          : v2,
            account_cap : v3,
            pool        : arg6,
            asset       : arg7,
            storage     : arg8,
            inc_v1      : arg9,
            inc_v2      : arg10,
        };
        let v5 = 0x2::object::new(arg15);
        let v6 = suilend_create_obligation<T0>(arg11, arg15);
        let v7 = Suilend<T0>{
            id                  : v5,
            obligation          : v6,
            lending_market      : arg12,
            reserve_array_index : arg13,
            price_info          : arg14,
        };
        let v8 = Reserve<T0, T1>{
            id                : v0,
            treasury          : v1,
            reserve_coin      : arg5,
            navi              : v4,
            suilend           : v7,
            availible_balance : 0x2::coin::zero<T1>(arg15),
        };
        0x2::transfer::share_object<Reserve<T0, T1>>(v8);
    }

    fun navi_create_account_cap(arg0: &mut 0x2::tx_context::TxContext) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0)
    }

    public fun optimise<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Reserve<T0, T1>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.suilend.reserve_array_index;
        let v1 = arg1.navi.asset;
        let v2 = 0x2::coin::value<T1>(&arg1.availible_balance);
        let v3 = if (0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::navi::navi_apr(&mut arg1.navi.storage, v1) >= 0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::suilend::suilend_apr<T0, T1>(&arg1.suilend.lending_market)) {
            1
        } else {
            2
        };
        let v4 = if (v2 == 0) {
            if (0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::navi::navi_balance<T1>(&arg1.navi.account_cap, &arg1.navi.pool, v1, &mut arg1.navi.storage) == 0) {
                0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::suilend::suilend_balance<T0, T1>(&arg1.suilend.lending_market, v0, &arg1.suilend.obligation) == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            return
        };
        let v5 = withdraw<T0, T1>(arg1, 0, arg0, arg2, arg3);
        0x2::coin::join<T1>(&mut v5, 0x2::coin::split<T1>(&mut arg1.availible_balance, v2, arg3));
        let v6 = &arg1.navi.account_cap;
        let v7 = &arg1.suilend.obligation;
        if (v3 == 1) {
            0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::navi::navi_deposit<T1>(arg0, &mut arg1.navi.storage, &mut arg1.navi.pool, v1, v6, v5, &mut arg1.navi.inc_v1, &mut arg1.navi.inc_v2);
        } else {
            0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::suilend::suilend_deposit<T0, T1>(&mut arg1.suilend.lending_market, v0, arg0, v5, v7, arg3);
        };
    }

    public fun redeem<T0, T1>(arg0: 0x2::coin::Coin<LENDIT_COIN>, arg1: &mut Reserve<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::burn<LENDIT_COIN>(&mut arg1.treasury, arg0);
        let v0 = current_balance<T0, T1>(arg1);
        let v1 = convert_to_assets<T0, T1>(arg1, 0x2::coin::value<LENDIT_COIN>(&arg0), v0);
        if (v1 == 0) {
            abort 4098
        };
        let v2 = withdraw<T0, T1>(arg1, v1, arg2, arg3, arg4);
        optimise<T0, T1>(arg2, arg1, arg3, arg4);
        v2
    }

    fun suilend_create_obligation<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg1)
    }

    public fun withdraw<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::navi::navi_balance<T1>(&arg0.navi.account_cap, &arg0.navi.pool, arg0.navi.asset, &mut arg0.navi.storage);
        if (v0 > 0) {
            let v1 = if (arg1 == 0) {
                v0
            } else {
                arg1
            };
            if (v1 > v0) {
                abort 4097
            };
            return 0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::navi::navi_withdraw<T1>(arg2, arg3, &mut arg0.navi.storage, &mut arg0.navi.pool, arg0.navi.asset, v1, &mut arg0.navi.inc_v1, &mut arg0.navi.inc_v2, &arg0.navi.account_cap, arg4)
        };
        let v2 = arg0.suilend.reserve_array_index;
        let v3 = &arg0.suilend.obligation;
        let v4 = &arg0.suilend.price_info;
        let v5 = 0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::suilend::suilend_balance<T0, T1>(&arg0.suilend.lending_market, v2, v3);
        assert!(v5 > 0, 4097);
        let v6 = if (arg1 == 0) {
            v5
        } else {
            arg1
        };
        if (v6 > v5) {
            abort 4097
        };
        0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::suilend::suilend_withdraw<T0, T1>(&mut arg0.suilend.lending_market, v2, arg2, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), 0x8528fcf8b7d9b77a8be251aff131313915414374a8d637a6c8cc0e16c9eec596::suilend::conv_to_ctoken<T0, T1>(&arg0.suilend.lending_market, v6), v3, v4, arg4)
    }

    // decompiled from Move bytecode v6
}

