module 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct Pair has copy, drop, store {
        nft: 0x1::type_name::TypeName,
        token: 0x1::type_name::TypeName,
    }

    struct Config has store {
        tick_size: u64,
        min_size: u64,
        base_fee: u64,
        allow_self_match: bool,
        max_order: u64,
    }

    struct Analysis has store {
        floor: u64,
        ceil: u64,
        vol: u128,
        bids_len: u64,
        asks_len: u64,
    }

    struct MarketAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketTreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        policy: 0x2::object::ID,
        pair: Pair,
        coin_or_clt: bool,
    }

    struct BalanceManager<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T0>,
    }

    struct MarketCreated has copy, drop, store {
        id: 0x2::object::ID,
        bid: 0x1::ascii::String,
        ask: 0x1::ascii::String,
        coin_or_clt: bool,
        tick_size: u64,
        min_size: u64,
        base_fee: u64,
        allow_self_match: bool,
        policy: address,
    }

    struct MarketAnalysis has copy, drop, store {
        id: 0x2::object::ID,
        vol: u128,
        floor: u64,
        ceil: u64,
        timestamp: u64,
    }

    fun analysis(arg0: &Market) : &Analysis {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, Analysis>(&arg0.id, 0x1::type_name::get<Analysis>())
    }

    fun analysis_mut(arg0: &mut Market) : &mut Analysis {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Analysis>(&mut arg0.id, 0x1::type_name::get<Analysis>())
    }

    fun balance_vault<T0>(arg0: &mut Market) : &mut BalanceManager<T0> {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, BalanceManager<T0>>(&mut arg0.id, 0x1::type_name::get<BalanceManager<T0>>())
    }

    public fun buy_cross<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(true, arg0, arg1, true, 0x2::clock::timestamp_ms(arg4));
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = pkiosk_mut(arg0);
        assert!(v0 >= 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::orderPrice(v1, arg3), 6005);
        let v2 = pkiosk_mut(arg0);
        let v3 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::orderIdFromNft(v2, arg3);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = orderbook_mut(arg0);
        assert!(v4 < 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_expiretime(v5, v3), 6006);
        deposit_coin<T1>(arg0, arg2);
        let v6 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), v0, true, 0x1::option::some<0x2::object::ID>(arg3), 0, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ord_cross(), v3, v4 + 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ten_days_ms(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ice_berge());
        let v7 = orderbook_mut(arg0);
        let (v8, v9, v10, v11) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::place_cross(v7, &mut v6, v4);
        deliver_cross<T0, T1>(arg1, v8, v9, v10, v11, arg0, arg5, v4, arg6);
    }

    public fun buy_cross_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::DepositProof, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::verifyDepositProof<T1>(&arg3, arg4);
        buy_cross_clt_int<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
    }

    fun buy_cross_clt_int<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg6, 1);
        validateMarket<T0, T1>(true, arg0, arg1, true, 0x2::clock::timestamp_ms(arg5));
        let v0 = 0x2::balance::value<T1>(&arg3);
        let v1 = pkiosk_mut(arg0);
        assert!(v0 >= 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::orderPrice(v1, arg4), 6005);
        let v2 = pkiosk_mut(arg0);
        let v3 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::orderIdFromNft(v2, arg4);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = orderbook_mut(arg0);
        assert!(v4 < 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_expiretime(v5, v3), 6006);
        deposit_balance<T1>(arg0, arg3);
        let v6 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg7), v0, true, 0x1::option::some<0x2::object::ID>(arg4), 0, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ord_cross(), v3, v4 + 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ten_days_ms(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ice_berge());
        let v7 = orderbook_mut(arg0);
        let (v8, v9, v10, v11) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::place_cross(v7, &mut v6, v4);
        deliver_cross_clt<T0, T1>(arg2, arg1, v8, v9, v10, v11, arg0, arg6, v4, arg7);
    }

    public fun buy_flash<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(true, arg0, arg1, true, 0x2::clock::timestamp_ms(arg3));
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 6003);
        deposit_coin<T1>(arg0, arg2);
        let v2 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), v1, true, 0x1::option::none<0x2::object::ID>(), 0, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ord_market(), 0, v0 + 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ten_days_ms(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ice_berge());
        let v3 = orderbook_mut(arg0);
        let v4 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::place_order(v3, &mut v2, v0);
        deliver<T0, T1>(v4, arg0, arg1, arg4, v0, arg5);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_id(&v4)
    }

    public fun buy_flash_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::DepositProof, arg5: &0x2::clock::Clock, arg6: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg6, 1);
        validateMarket<T0, T1>(true, arg0, arg1, true, 0x2::clock::timestamp_ms(arg5));
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::verifyDepositProof<T1>(&arg3, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::balance::value<T1>(&arg3);
        assert!(v1 > 0, 6003);
        deposit_balance<T1>(arg0, arg3);
        let v2 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg7), v1, true, 0x1::option::none<0x2::object::ID>(), 0, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ord_market(), 0, v0 + 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ten_days_ms(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ice_berge());
        let v3 = orderbook_mut(arg0);
        deliver_clt<T0, T1>(0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::place_order(v3, &mut v2, v0), arg0, arg1, arg2, arg6, v0, arg7);
    }

    public fun buy_limit<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(false, arg0, arg1, true, 0x2::clock::timestamp_ms(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = config_mut(arg0);
        let v3 = arg3 - arg3 % v2.tick_size;
        assert!(v3 > 0 && v1 >= v3, 6003);
        deposit_coin<T1>(arg0, arg2);
        let v4 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), v1, true, 0x1::option::none<0x2::object::ID>(), v3, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ord_limit(), 0, v0 + 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ten_days_ms(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ice_berge());
        let v5 = orderbook_mut(arg0);
        let v6 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::place_order(v5, &mut v4, v0);
        deliver<T0, T1>(v6, arg0, arg1, arg5, v0, arg6);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_id(&v6)
    }

    public fun buy_limit_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::DepositProof, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg7, 1);
        validateMarket<T0, T1>(true, arg0, arg1, true, 0x2::clock::timestamp_ms(arg6));
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::verifyDepositProof<T1>(&arg3, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::balance::value<T1>(&arg3);
        let v2 = config_mut(arg0);
        let v3 = arg5 - arg5 % v2.tick_size;
        assert!(v3 > 0 && v1 >= v3, 6003);
        deposit_balance<T1>(arg0, arg3);
        let v4 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg8), v1, true, 0x1::option::none<0x2::object::ID>(), v3, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ord_limit(), 0, v0 + 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ten_days_ms(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ice_berge());
        let v5 = orderbook_mut(arg0);
        deliver_clt<T0, T1>(0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::place_order(v5, &mut v4, v0), arg0, arg1, arg2, arg7, v0, arg8);
    }

    public fun cancel_buy<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg3, 1);
        validateMarket2<T0, T1>(arg0, arg1, true);
        let v0 = 0x1::vector::length<u128>(&arg2);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<u128>(&arg2, v0);
            let v2 = orderbook_mut(arg0);
            let (v3, v4, _, _) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_info(0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order(v2, v1));
            assert!(v4 == 0x2::tx_context::sender(arg4) && v3, 6003);
            let v7 = orderbook_mut(arg0);
            let v8 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::cancel_order(v7, v1);
            let v9 = balance_vault<T1>(arg0);
            let v10 = 0x2::tx_context::sender(arg4);
            refund_coin<T1>(v9, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::remain_balance(&v8), v10, arg4);
        };
    }

    public fun cancel_buy_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg3: vector<u128>, arg4: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg4, 1);
        validateMarket2<T0, T1>(arg0, arg1, false);
        let v0 = 0x1::vector::length<u128>(&arg3);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<u128>(&arg3, v0);
            let v2 = orderbook_mut(arg0);
            let (v3, v4, _, _) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_info(0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order(v2, v1));
            assert!(v4 == 0x2::tx_context::sender(arg5) && v3, 6003);
            let v7 = orderbook_mut(arg0);
            let v8 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::cancel_order(v7, v1);
            let v9 = 0x2::tx_context::sender(arg5);
            refund_balance<T1>(arg2, arg0, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::remain_balance(&v8), v9, arg5);
        };
    }

    public fun cancel_sell<T0: store + key, T1>(arg0: &mut Market, arg1: vector<0x2::object::ID>, arg2: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg2, 1);
        validateMarket0<T0, T1>(arg0);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v0);
            let v2 = pkiosk_mut(arg0);
            assert!(0x2::tx_context::sender(arg3) == 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::orderOwner(v2, v1), 6007);
            let v3 = pkiosk_mut(arg0);
            0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::cancel_order(orderbook_mut(arg0), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::delistAndTake<T0, T1>(v3, v1, arg2, arg3));
        };
    }

    public fun cancel_sell_ordid<T0: store + key, T1>(arg0: &mut Market, arg1: vector<u128>, arg2: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg2, 1);
        validateMarket0<T0, T1>(arg0);
        let v0 = 0x1::vector::length<u128>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = orderbook_mut(arg0);
            let v2 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::cancel_order(v1, 0x1::vector::pop_back<u128>(&mut arg1));
            let (v3, v4, _, v6) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_info(&v2);
            let v7 = v6;
            assert!(v4 == 0x2::tx_context::sender(arg3), 6007);
            assert!(!v3 && 0x1::option::is_some<0x2::object::ID>(&v7), 6003);
            0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg0), 0x1::option::extract<0x2::object::ID>(&mut v7), arg2, arg3);
        };
    }

    fun config(arg0: &Market) : &Config {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, Config>(&arg0.id, 0x1::type_name::get<Config>())
    }

    fun config_mut(arg0: &mut Market) : &mut Config {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Config>(&mut arg0.id, 0x1::type_name::get<Config>())
    }

    public fun createMarket<T0: store + key, T1>(arg0: &MarketAdminCap, arg1: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg8, 1);
        let v0 = pair<T0, T1>();
        let v1 = Market{
            id          : 0x2::object::new(arg9),
            policy      : 0x2::object::id<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>>(arg1),
            pair        : v0,
            coin_or_clt : arg2,
        };
        let v2 = BalanceManager<T1>{
            balance : 0x2::balance::zero<T1>(),
            fee     : 0x2::balance::zero<T1>(),
        };
        let v3 = Config{
            tick_size        : arg3,
            min_size         : arg4,
            base_fee         : arg5,
            allow_self_match : arg7,
            max_order        : arg6,
        };
        let v4 = MarketCreated{
            id               : 0x2::object::id<Market>(&v1),
            bid              : 0x1::type_name::into_string(v0.token),
            ask              : 0x1::type_name::into_string(v0.nft),
            coin_or_clt      : arg2,
            tick_size        : arg3,
            min_size         : arg4,
            base_fee         : arg5,
            allow_self_match : arg7,
            policy           : 0x2::object::id_address<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>>(arg1),
        };
        0x2::event::emit<MarketCreated>(v4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Book>(&mut v1.id, 0x1::type_name::get<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Book>(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::empty(arg5, arg3, arg4, arg9));
        0x2::dynamic_field::add<0x1::type_name::TypeName, BalanceManager<T1>>(&mut v1.id, 0x1::type_name::get<BalanceManager<T1>>(), v2);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::PublicKiosk>(&mut v1.id, 0x1::type_name::get<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::PublicKiosk>(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::createPublicKiosk<T0, T1>(arg8, arg9));
        0x2::dynamic_field::add<0x1::type_name::TypeName, Config>(&mut v1.id, 0x1::type_name::get<Config>(), v3);
        let v5 = Analysis{
            floor    : 0,
            ceil     : 0,
            vol      : 0,
            bids_len : 0,
            asks_len : 0,
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, Analysis>(&mut v1.id, 0x1::type_name::get<Analysis>(), v5);
        0x2::transfer::public_share_object<Market>(v1);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::cap_vault::createVault<MarketAdminCap>(arg9);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::cap_vault::createVault<MarketTreasureCap>(arg9);
    }

    fun deliver<T0: store + key, T1>(arg0: 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::TradeProof, arg1: &mut Market, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg3: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::bill_info(&arg0);
        let v2 = 0x1::vector::length<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Bill>(v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            let (v3, v4, v5, v6, v7) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::fill_info(0x1::vector::borrow<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Bill>(v0, v2));
            let v8 = if (v3) {
                0x2::tx_context::sender(arg5)
            } else {
                v4
            };
            let v9 = balance_vault<T1>(arg1);
            let v10 = 0x2::balance::split<T1>(&mut v9.balance, v5);
            let v11 = &mut v10;
            deliverNft<T0, T1>(arg1, arg2, v7, v11, v8, arg3, arg5);
            deposit_balance<T1>(arg1, v10);
            update_analysis(arg1, v5, v6, arg4);
        };
        let v12 = 0x1::vector::length<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::ExpiredBill>(v1);
        while (v12 > 0) {
            v12 = v12 - 1;
            let (v13, v14, v15, v16) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::expired_info(0x1::vector::borrow<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::ExpiredBill>(v1, v12));
            let v17 = v16;
            if (v13) {
                let v18 = balance_vault<T1>(arg1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v18.balance, v15), arg5), v14);
                continue
            };
            let v19 = pkiosk_mut(arg1);
            0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::delistAndTake<T0, T1>(v19, *0x1::option::borrow<0x2::object::ID>(&v17), arg3, arg5);
        };
        let (v20, _, v22, v23, v24, v25) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::trade_info(&arg0);
        let v26 = v25;
        if (!v22) {
            if (v24) {
                if (v23 > 0) {
                    let v27 = balance_vault<T1>(arg1);
                    refund_coin<T1>(v27, v23, v20, arg5);
                };
            } else if (v23 > 0) {
                0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg1), *0x1::option::borrow<0x2::object::ID>(&v26), arg3, arg5);
            };
        };
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::confirm_proof(arg0);
    }

    fun deliverNft<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::balance::Balance<T1>, arg4: address, arg5: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = config_mut(arg0);
        let v1 = v0.base_fee;
        let v2 = pkiosk_mut(arg0);
        let (v3, v4, v5) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::purchase<T0, T1>(v2, arg2, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        assert!(0x2::object::id<T0>(&v8) == 0x2::transfer_policy::item<T0>(&v7), 6002);
        0x2::transfer::public_transfer<T0>(v8, arg4);
        0x2::balance::join<T1>(&mut balance_vault<T1>(arg0).fee, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::payByCoin<T0, T1>(arg1, v7, &v6, arg3, v1, arg6));
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::orderId(&v6)
    }

    fun deliverNftClt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::balance::Balance<T1>, arg5: address, arg6: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg7: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = config_mut(arg0);
        let v1 = v0.base_fee;
        let v2 = pkiosk_mut(arg0);
        let (v3, v4, v5) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::purchase<T0, T1>(v2, arg3, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        assert!(0x2::object::id<T0>(&v8) == 0x2::transfer_policy::item<T0>(&v7), 6002);
        0x2::transfer::public_transfer<T0>(v8, arg5);
        0x2::balance::join<T1>(&mut balance_vault<T1>(arg0).fee, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::payByClt<T0, T1>(arg2, arg1, v7, &v6, arg4, v1, arg7));
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::orderId(&v6)
    }

    fun deliver_clt<T0: store + key, T1>(arg0: 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::TradeProof, arg1: &mut Market, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg3: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg4: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::bill_info(&arg0);
        let v2 = 0x1::vector::length<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Bill>(v0);
        while (v2 > 0) {
            let (v3, v4, v5, v6, v7) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::fill_info(0x1::vector::borrow<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Bill>(v0, v2 - 1));
            let v8 = if (v3) {
                0x2::tx_context::sender(arg6)
            } else {
                v4
            };
            let v9 = balance_vault<T1>(arg1);
            let v10 = 0x2::balance::split<T1>(&mut v9.balance, v5);
            let v11 = &mut v10;
            deliverNftClt<T0, T1>(arg1, arg2, arg3, v7, v11, v8, arg4, arg6);
            deposit_balance<T1>(arg1, v10);
            update_analysis(arg1, v5, v6, arg5);
            v2 = v2 - 1;
        };
        let v12 = 0x1::vector::length<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::ExpiredBill>(v1);
        while (v12 > 0) {
            v12 = v12 - 1;
            let (v13, v14, v15, v16) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::expired_info(0x1::vector::borrow<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::ExpiredBill>(v1, v12));
            let v17 = v16;
            if (v13) {
                refund_balance<T1>(arg3, arg1, v15, v14, arg6);
                continue
            };
            let v18 = pkiosk_mut(arg1);
            0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::delistAndTake<T0, T1>(v18, *0x1::option::borrow<0x2::object::ID>(&v17), arg4, arg6);
        };
        let (v19, _, v21, v22, v23, v24) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::trade_info(&arg0);
        let v25 = v24;
        if (!v21) {
            if (v23) {
                if (v22 > 0) {
                    refund_balance<T1>(arg3, arg1, v22, v19, arg6);
                };
            } else if (v22 > 0) {
                0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg1), *0x1::option::borrow<0x2::object::ID>(&v25), arg4, arg6);
            };
        };
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::confirm_proof(arg0);
    }

    fun deliver_cross<T0: store + key, T1>(arg0: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg1: 0x1::option::Option<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Bill>, arg2: 0x1::option::Option<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::ExpiredBill>, arg3: address, arg4: u64, arg5: &mut Market, arg6: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Bill>(&arg1)) {
            let v0 = 0x1::option::extract<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Bill>(&mut arg1);
            let (v1, v2, v3, v4, v5) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::fill_info(&v0);
            let v6 = if (v1) {
                0x2::tx_context::sender(arg8)
            } else {
                v2
            };
            let v7 = balance_vault<T1>(arg5);
            let v8 = 0x2::balance::split<T1>(&mut v7.balance, v3);
            let v9 = &mut v8;
            deliverNft<T0, T1>(arg5, arg0, v5, v9, v6, arg6, arg8);
            deposit_balance<T1>(arg5, v8);
            update_analysis(arg5, v3, v4, arg7);
        };
        if (0x1::option::is_some<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::ExpiredBill>(&arg2)) {
            let v10 = 0x1::option::extract<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::ExpiredBill>(&mut arg2);
            let (v11, v12, v13, v14) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::expired_info(&v10);
            let v15 = v14;
            if (v11) {
                let v16 = balance_vault<T1>(arg5);
                refund_coin<T1>(v16, v13, v12, arg8);
            } else {
                let v17 = pkiosk_mut(arg5);
                0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::delistAndTake<T0, T1>(v17, *0x1::option::borrow<0x2::object::ID>(&v15), arg6, arg8);
            };
        };
        if (arg4 > 0) {
            let v18 = balance_vault<T1>(arg5);
            refund_coin<T1>(v18, arg4, arg3, arg8);
        };
    }

    fun deliver_cross_clt<T0: store + key, T1>(arg0: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: 0x1::option::Option<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Bill>, arg3: 0x1::option::Option<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::ExpiredBill>, arg4: address, arg5: u64, arg6: &mut Market, arg7: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Bill>(&arg2)) {
            let v0 = 0x1::option::extract<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Bill>(&mut arg2);
            let (v1, v2, v3, v4, v5) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::fill_info(&v0);
            let v6 = if (v1) {
                0x2::tx_context::sender(arg9)
            } else {
                v2
            };
            let v7 = balance_vault<T1>(arg6);
            let v8 = 0x2::balance::split<T1>(&mut v7.balance, v3);
            let v9 = &mut v8;
            deliverNftClt<T0, T1>(arg6, arg1, arg0, v5, v9, v6, arg7, arg9);
            deposit_balance<T1>(arg6, v8);
            update_analysis(arg6, v3, v4, arg8);
        };
        if (0x1::option::is_some<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::ExpiredBill>(&arg3)) {
            let v10 = 0x1::option::extract<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::ExpiredBill>(&mut arg3);
            let (v11, v12, v13, v14) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::expired_info(&v10);
            let v15 = v14;
            if (v11) {
                refund_balance<T1>(arg0, arg6, v13, v12, arg9);
            } else {
                let v16 = pkiosk_mut(arg6);
                0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::delistAndTake<T0, T1>(v16, *0x1::option::borrow<0x2::object::ID>(&v15), arg7, arg9);
            };
        };
        if (arg5 > 0) {
            refund_balance<T1>(arg0, arg6, arg5, arg4, arg9);
        };
    }

    fun deposit_balance<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut balance_vault<T0>(arg0).balance, arg1);
    }

    fun deposit_coin<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut balance_vault<T0>(arg0).balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MarketAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MarketTreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MarketTreasureCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun orderbook(arg0: &Market) : &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Book {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Book>(&arg0.id, 0x1::type_name::get<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Book>())
    }

    fun orderbook_mut(arg0: &mut Market) : &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Book {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Book>(&mut arg0.id, 0x1::type_name::get<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::Book>())
    }

    fun pair<T0: store + key, T1>() : Pair {
        Pair{
            nft   : 0x1::type_name::get<T0>(),
            token : 0x1::type_name::get<T1>(),
        }
    }

    fun pkiosk_mut(arg0: &mut Market) : &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::PublicKiosk {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::PublicKiosk>(&mut arg0.id, 0x1::type_name::get<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::PublicKiosk>())
    }

    fun refund_balance<T0>(arg0: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T0>, arg1: &mut Market, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::withdrawTo<T0>(0x2::balance::split<T0>(&mut balance_vault<T0>(arg1).balance, arg2), arg3, arg0, arg4);
    }

    fun refund_coin<T0>(arg0: &mut BalanceManager<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
    }

    public fun sell_flash<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(false, arg0, arg1, true, 0x2::clock::timestamp_ms(arg3));
        let v0 = 0x2::object::id<T0>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = pkiosk_mut(arg0);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::placeAndList<T0, T1>(v2, arg2, 0, arg4, arg5);
        let v3 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), 1, false, 0x1::option::some<0x2::object::ID>(v0), 0, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ord_market(), 0, v1 + 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ten_days_ms(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::atomic());
        let v4 = orderbook_mut(arg0);
        let v5 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::place_order(v4, &mut v3, v1);
        let v6 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_id(&v5);
        let v7 = pkiosk_mut(arg0);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::bindOrderId(v7, v0, v6);
        deliver<T0, T1>(v5, arg0, arg1, arg4, v1, arg5);
        v6
    }

    public fun sell_flash_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(false, arg0, arg1, true, 0x2::clock::timestamp_ms(arg4));
        let v0 = 0x2::object::id<T0>(&arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = pkiosk_mut(arg0);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::placeAndList<T0, T1>(v2, arg3, 0, arg5, arg6);
        let v3 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), 1, false, 0x1::option::some<0x2::object::ID>(v0), 0, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ord_market(), 0, v1 + 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ten_days_ms(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::atomic());
        let v4 = orderbook_mut(arg0);
        let v5 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::place_order(v4, &mut v3, v1);
        let v6 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_id(&v5);
        let v7 = pkiosk_mut(arg0);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::bindOrderId(v7, v0, v6);
        deliver_clt<T0, T1>(v5, arg0, arg1, arg2, arg5, v1, arg6);
        v6
    }

    public fun sell_limit<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg5, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        validateMarket<T0, T1>(false, arg0, arg1, true, v0);
        let v1 = 0x2::object::id<T0>(&arg2);
        let v2 = config_mut(arg0);
        let v3 = arg3 - arg3 % v2.tick_size;
        let v4 = pkiosk_mut(arg0);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::placeAndList<T0, T1>(v4, arg2, v3, arg5, arg6);
        let v5 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), 1, false, 0x1::option::some<0x2::object::ID>(v1), v3, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ord_limit(), 0, v0 + 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ten_days_ms(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::atomic());
        let v6 = orderbook_mut(arg0);
        let v7 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::place_order(v6, &mut v5, v0);
        let v8 = pkiosk_mut(arg0);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::bindOrderId(v8, v1, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_id(&v7));
        deliver<T0, T1>(v7, arg0, arg1, arg5, v0, arg6);
    }

    public fun sell_limit_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg6, 1);
        validateMarket<T0, T1>(false, arg0, arg1, true, 0x2::clock::timestamp_ms(arg5));
        let v0 = 0x2::object::id<T0>(&arg3);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = config_mut(arg0);
        let v3 = arg4 - arg4 % v2.tick_size;
        let v4 = pkiosk_mut(arg0);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::placeAndList<T0, T1>(v4, arg3, v3, arg6, arg7);
        let v5 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg7), 1, false, 0x1::option::some<0x2::object::ID>(v0), v3, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ord_limit(), 0, v1 + 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::ten_days_ms(), 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::constants::atomic());
        let v6 = orderbook_mut(arg0);
        let v7 = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::place_order(v6, &mut v5, v1);
        let v8 = pkiosk_mut(arg0);
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::bindOrderId(v8, v0, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::order_id(&v7));
        deliver_clt<T0, T1>(v7, arg0, arg1, arg2, arg6, v1, arg7);
    }

    public fun sweep<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(true, arg0, arg1, true, 0x2::clock::timestamp_ms(arg4));
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg2);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            let v2 = pkiosk_mut(arg0);
            let v3 = 0x2::coin::split<T1>(arg3, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::orderPrice(v2, v1), arg6);
            buy_cross<T0, T1>(arg0, arg1, v3, v1, arg4, arg5, arg6);
        };
    }

    public fun sweep_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: &mut 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::PegVault<T1>, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::balance::Balance<T1>, arg5: 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::DepositProof, arg6: &0x2::clock::Clock, arg7: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg7, 1);
        validateMarket<T0, T1>(true, arg0, arg1, true, 0x2::clock::timestamp_ms(arg6));
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::xbird::verifyDepositProof<T1>(arg4, arg5);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg3);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v0);
            let v2 = pkiosk_mut(arg0);
            buy_cross_clt_int<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(arg4, 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::public_kiosk::orderPrice(v2, v1)), v1, arg6, arg7, arg8);
        };
    }

    fun update_analysis(arg0: &mut Market, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x2::object::id<Market>(arg0);
        let v1 = analysis_mut(arg0);
        v1.vol = v1.vol + (arg1 as u128);
        v1.floor = 0x1::u64::min(v1.floor, arg2);
        v1.ceil = 0x1::u64::max(v1.ceil, arg2);
        let v2 = MarketAnalysis{
            id        : v0,
            vol       : v1.vol,
            floor     : v1.floor,
            ceil      : v1.ceil,
            timestamp : arg3,
        };
        0x2::event::emit<MarketAnalysis>(v2);
    }

    fun update_analysis2(arg0: &mut Market, arg1: u64) : (u64, u64) {
        let (v0, v1) = 0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::book::book_size(orderbook(arg0));
        let v2 = 0x2::object::id<Market>(arg0);
        let v3 = analysis_mut(arg0);
        let v4 = false;
        if (v3.bids_len != v0) {
            v3.bids_len = v0;
            v4 = true;
        };
        if (v3.asks_len != v1) {
            v3.asks_len = v1;
            v4 = true;
        };
        if (v4) {
            let v5 = MarketAnalysis{
                id        : v2,
                vol       : v3.vol,
                floor     : v3.floor,
                ceil      : v3.ceil,
                timestamp : arg1,
            };
            0x2::event::emit<MarketAnalysis>(v5);
        };
        (v0, v1)
    }

    fun validateMarket<T0: store + key, T1>(arg0: bool, arg1: &mut Market, arg2: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg3: bool, arg4: u64) {
        assert!(arg1.pair == pair<T0, T1>() && arg1.policy == 0x2::object::id<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>>(arg2), 6001);
        assert!(arg1.coin_or_clt == arg3, 6004);
        let v0 = config(arg1).max_order;
        let (v1, v2) = update_analysis2(arg1, arg4);
        assert!(arg0 && v1 <= v0 || !arg0 && v2 <= v0, 6007);
    }

    fun validateMarket0<T0: store + key, T1>(arg0: &Market) {
        assert!(arg0.pair == pair<T0, T1>(), 6001);
    }

    fun validateMarket2<T0: store + key, T1>(arg0: &mut Market, arg1: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>, arg2: bool) {
        assert!(arg0.pair == pair<T0, T1>() && arg0.policy == 0x2::object::id<0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::payment_policy::PolicyVault<T0>>(arg1), 6001);
        assert!(arg0.coin_or_clt == arg2, 6004);
    }

    public fun withdraw_fee<T0: store + key, T1>(arg0: &MarketTreasureCap, arg1: &mut Market, arg2: &0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::Version) : 0x2::balance::Balance<T1> {
        0xcfb661925ed4f0ca6c75b63d7cba2c8d2fa2e3985c8de54755439af3a99da63d::version::checkVersion(arg2, 1);
        assert!(pair<T0, T1>() == arg1.pair, 6001);
        let v0 = &mut balance_vault<T1>(arg1).fee;
        0x2::balance::split<T1>(v0, 0x2::balance::value<T1>(v0))
    }

    // decompiled from Move bytecode v6
}

