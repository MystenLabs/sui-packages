module 0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::lendit {
    struct LENDIT has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<LENDIT>,
    }

    struct AccountCapHolder has store, key {
        id: 0x2::object::UID,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct ObligationOwnerCapHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
    }

    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
        available_balance: 0x2::coin::Coin<T0>,
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

    fun current_balance<T0, T1>(arg0: &Reserve<T1>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &AccountCapHolder, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: u64, arg7: &ObligationOwnerCapHolder<T0>) : u64 {
        0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::navi::navi_balance<T1>(&arg4.account_cap, arg1, arg3, arg2) + 0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::suilend::suilend_balance<T0, T1>(arg5, arg6, &arg7.obligation) + 0x2::coin::value<T1>(&arg0.available_balance)
    }

    public fun deposit<T0, T1>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T1>, arg2: &mut TreasuryCapHolder<LENDIT>, arg3: &mut Reserve<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &AccountCapHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg12: &ObligationOwnerCapHolder<T0>, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LENDIT> {
        let v0 = current_balance<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg11, arg13, arg12);
        0x2::coin::join<T1>(&mut arg3.available_balance, arg1);
        let v1 = mint(arg2, 0x2::coin::value<T1>(&arg1), v0, arg15);
        optimise<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
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

    public fun init_admin<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountCapHolder{
            id          : 0x2::object::new(arg1),
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
        };
        0x2::transfer::share_object<AccountCapHolder>(v0);
        let v1 = ObligationOwnerCapHolder<T0>{
            id         : 0x2::object::new(arg1),
            obligation : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg1),
        };
        0x2::transfer::share_object<ObligationOwnerCapHolder<T0>>(v1);
        let v2 = Reserve<T1>{
            id                : 0x2::object::new(arg1),
            available_balance : 0x2::coin::zero<T1>(arg1),
        };
        0x2::transfer::share_object<Reserve<T1>>(v2);
    }

    public fun optimise<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Reserve<T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: &AccountCapHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg10: &ObligationOwnerCapHolder<T0>, arg11: u64, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1.available_balance);
        let v1 = if (0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::navi::navi_apr(arg3, arg4) >= 0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::suilend::suilend_apr<T0, T1>(arg9)) {
            1
        } else {
            2
        };
        let v2 = if (v0 == 0) {
            if (0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::navi::navi_balance<T1>(&arg5.account_cap, arg2, arg4, arg3) == 0) {
                0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::suilend::suilend_balance<T0, T1>(arg9, arg11, &arg10.obligation) == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            return
        };
        let v3 = withdraw<T0, T1>(arg0, 0, arg2, arg4, arg3, arg5, arg6, arg7, arg11, arg10, arg9, arg12, arg8, arg13);
        0x2::coin::join<T1>(&mut v3, 0x2::coin::split<T1>(&mut arg1.available_balance, v0, arg13));
        if (v1 == 1) {
            0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::navi::navi_deposit<T1>(arg0, arg3, arg2, arg4, &arg5.account_cap, v3, arg6, arg7);
        } else {
            0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::suilend::suilend_deposit<T0, T1>(arg9, arg11, arg0, v3, &arg10.obligation, arg13);
        };
    }

    public fun redeem<T0, T1>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<LENDIT>, arg2: &mut TreasuryCapHolder<LENDIT>, arg3: &mut Reserve<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &AccountCapHolder, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg12: &ObligationOwnerCapHolder<T0>, arg13: u64, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::burn<LENDIT>(&mut arg2.treasury, arg1);
        let v0 = current_balance<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg11, arg13, arg12);
        let v1 = convert_to_assets(arg2, 0x2::coin::value<LENDIT>(&arg1), v0);
        if (v1 == 0) {
            abort 4098
        };
        let v2 = withdraw<T0, T1>(arg0, v1, arg4, arg6, arg5, arg7, arg8, arg9, arg13, arg12, arg11, arg14, arg10, arg15);
        optimise<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        v2
    }

    public fun withdraw<T0, T1>(arg0: &0x2::clock::Clock, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &AccountCapHolder, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: u64, arg9: &ObligationOwnerCapHolder<T0>, arg10: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg11: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::navi::navi_balance<T1>(&arg5.account_cap, arg2, arg3, arg4);
        if (v0 > 0) {
            let v1 = if (arg1 == 0) {
                v0
            } else {
                arg1
            };
            if (v1 > v0) {
                abort 4097
            };
            return 0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::navi::navi_withdraw<T1>(arg0, arg12, arg4, arg2, arg3, v1, arg6, arg7, &arg5.account_cap, arg13)
        };
        let v2 = 0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::suilend::suilend_balance<T0, T1>(arg10, arg8, &arg9.obligation);
        assert!(v2 > 0, 4097);
        let v3 = if (arg1 == 0) {
            v2
        } else {
            arg1
        };
        if (v3 > v2) {
            abort 4097
        };
        0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::suilend::suilend_withdraw<T0, T1>(arg10, arg8, arg0, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), 0xf095bad3357db10bc2b6a71ca5a305650e3f689b857507df98a784778204b52c::suilend::conv_to_ctoken<T0, T1>(arg10, v3), &arg9.obligation, arg11, arg13)
    }

    // decompiled from Move bytecode v6
}

