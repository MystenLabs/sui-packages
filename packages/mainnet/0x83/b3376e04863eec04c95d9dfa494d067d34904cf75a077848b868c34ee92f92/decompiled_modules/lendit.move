module 0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::lendit {
    struct LENDIT has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<LENDIT>,
    }

    struct Reserve<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
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

    fun mint(arg0: &mut TreasuryCapHolder<LENDIT>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LENDIT> {
        0x2::coin::mint<LENDIT>(&mut arg0.treasury, convert_to_shares(arg0, arg1, arg2), arg3)
    }

    fun convert_to_assets(arg0: &TreasuryCapHolder<LENDIT>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::coin::total_supply<LENDIT>(&arg0.treasury);
        if (v0 == 0) {
            return arg1
        };
        arg1 * arg2 / v0
    }

    fun convert_to_shares(arg0: &TreasuryCapHolder<LENDIT>, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return arg1
        };
        arg1 * 0x2::coin::total_supply<LENDIT>(&arg0.treasury) / arg2
    }

    fun current_balance<T0, T1>(arg0: &mut Reserve<T0, T1>) : u64 {
        0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::navi::navi_balance<T1>(&arg0.navi.account_cap, &arg0.navi.pool, arg0.navi.asset, &mut arg0.navi.storage) + 0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::suilend::suilend_balance<T0, T1>(&arg0.suilend.lending_market, arg0.suilend.reserve_array_index, &arg0.suilend.obligation) + 0x2::coin::value<T1>(&arg0.availible_balance)
    }

    public fun deposit<T0, T1>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T1>, arg2: &mut Reserve<T0, T1>, arg3: &mut TreasuryCapHolder<LENDIT>, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LENDIT> {
        let v0 = current_balance<T0, T1>(arg2);
        0x2::coin::join<T1>(&mut arg2.availible_balance, arg1);
        let v1 = mint(arg3, 0x2::coin::value<T1>(&arg1), v0, arg5);
        optimise<T0, T1>(arg0, arg2, arg4, arg5);
        v1
    }

    fun init(arg0: LENDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENDIT>(arg0, 6, b"LUSDC", b"LendItUSDC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LENDIT>>(v1);
        let v2 = TreasuryCapHolder<LENDIT>{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<TreasuryCapHolder<LENDIT>>(v2);
    }

    public fun init_asset<T0, T1>(arg0: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg1: u8, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg4: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: u64, arg8: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::new(arg9);
        let v2 = navi_create_account_cap(arg9);
        let v3 = Navi<T1>{
            id          : v1,
            account_cap : v2,
            pool        : arg0,
            asset       : arg1,
            storage     : arg2,
            inc_v1      : arg3,
            inc_v2      : arg4,
        };
        let v4 = 0x2::object::new(arg9);
        let v5 = suilend_create_obligation<T0>(arg5, arg9);
        let v6 = Suilend<T0>{
            id                  : v4,
            obligation          : v5,
            lending_market      : arg6,
            reserve_array_index : arg7,
            price_info          : arg8,
        };
        let v7 = Reserve<T0, T1>{
            id                : v0,
            navi              : v3,
            suilend           : v6,
            availible_balance : 0x2::coin::zero<T1>(arg9),
        };
        0x2::transfer::share_object<Reserve<T0, T1>>(v7);
    }

    fun navi_create_account_cap(arg0: &mut 0x2::tx_context::TxContext) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0)
    }

    public fun optimise<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Reserve<T0, T1>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.suilend.reserve_array_index;
        let v1 = arg1.navi.asset;
        let v2 = 0x2::coin::value<T1>(&arg1.availible_balance);
        let v3 = if (0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::navi::navi_apr(&mut arg1.navi.storage, v1) >= 0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::suilend::suilend_apr<T0, T1>(&arg1.suilend.lending_market)) {
            1
        } else {
            2
        };
        let v4 = if (v2 == 0) {
            if (0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::navi::navi_balance<T1>(&arg1.navi.account_cap, &arg1.navi.pool, v1, &mut arg1.navi.storage) == 0) {
                0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::suilend::suilend_balance<T0, T1>(&arg1.suilend.lending_market, v0, &arg1.suilend.obligation) == 0
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
            0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::navi::navi_deposit<T1>(arg0, &mut arg1.navi.storage, &mut arg1.navi.pool, v1, v6, v5, &mut arg1.navi.inc_v1, &mut arg1.navi.inc_v2);
        } else {
            0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::suilend::suilend_deposit<T0, T1>(&mut arg1.suilend.lending_market, v0, arg0, v5, v7, arg3);
        };
    }

    public fun redeem<T0, T1>(arg0: 0x2::coin::Coin<LENDIT>, arg1: &mut Reserve<T0, T1>, arg2: &mut TreasuryCapHolder<LENDIT>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::burn<LENDIT>(&mut arg2.treasury, arg0);
        let v0 = current_balance<T0, T1>(arg1);
        let v1 = convert_to_assets(arg2, 0x2::coin::value<LENDIT>(&arg0), v0);
        if (v1 == 0) {
            abort 4098
        };
        let v2 = withdraw<T0, T1>(arg1, v1, arg3, arg4, arg5);
        optimise<T0, T1>(arg3, arg1, arg4, arg5);
        v2
    }

    fun suilend_create_obligation<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg1)
    }

    public fun withdraw<T0, T1>(arg0: &mut Reserve<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::navi::navi_balance<T1>(&arg0.navi.account_cap, &arg0.navi.pool, arg0.navi.asset, &mut arg0.navi.storage);
        if (v0 > 0) {
            let v1 = if (arg1 == 0) {
                v0
            } else {
                arg1
            };
            if (v1 > v0) {
                abort 4097
            };
            return 0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::navi::navi_withdraw<T1>(arg2, arg3, &mut arg0.navi.storage, &mut arg0.navi.pool, arg0.navi.asset, v1, &mut arg0.navi.inc_v1, &mut arg0.navi.inc_v2, &arg0.navi.account_cap, arg4)
        };
        let v2 = arg0.suilend.reserve_array_index;
        let v3 = &arg0.suilend.obligation;
        let v4 = &arg0.suilend.price_info;
        let v5 = 0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::suilend::suilend_balance<T0, T1>(&arg0.suilend.lending_market, v2, v3);
        assert!(v5 > 0, 4097);
        let v6 = if (arg1 == 0) {
            v5
        } else {
            arg1
        };
        if (v6 > v5) {
            abort 4097
        };
        0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::suilend::suilend_withdraw<T0, T1>(&mut arg0.suilend.lending_market, v2, arg2, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), 0x83b3376e04863eec04c95d9dfa494d067d34904cf75a077848b868c34ee92f92::suilend::conv_to_ctoken<T0, T1>(&arg0.suilend.lending_market, v6), v3, v4, arg4)
    }

    // decompiled from Move bytecode v6
}

