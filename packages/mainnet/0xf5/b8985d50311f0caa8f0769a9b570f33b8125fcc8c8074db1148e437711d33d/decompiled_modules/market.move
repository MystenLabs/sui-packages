module 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::market {
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
        min_offer_per: u64,
    }

    struct Analysis has store {
        floor: u64,
        ceil: u64,
        vol: u128,
        bids_size: u64,
        asks_size: u64,
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
        max_order: u64,
        allow_self_match: bool,
        policy: address,
    }

    struct MarketAnalysis has copy, drop, store {
        id: 0x2::object::ID,
        vol: u128,
        floor: u64,
        ceil: u64,
        bids_size: u64,
        asks_size: u64,
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

    public fun buy_cross<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg5, 2);
        validateMarket<T0, T1>(true, arg0, arg1, true);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = pkiosk_mut(arg0);
        assert!(v0 >= 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::orderPrice(v1, arg3), 6005);
        let v2 = pkiosk_mut(arg0);
        let v3 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::orderIdFromNft(v2, arg3);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = orderbook_mut(arg0);
        assert!(!0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_expired(v5, v3, v4), 6006);
        deposit_coin<T1>(arg0, arg2);
        let v6 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), v0, true, 0x1::option::some<0x2::object::ID>(arg3), 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_cross(), v3, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ice_berge());
        let v7 = config(arg0).allow_self_match;
        let v8 = orderbook_mut(arg0);
        let (v9, v10, v11, v12) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_cross(v8, &v6, v7, v4);
        deliver_cross<T0, T1>(arg1, v9, v10, v11, v12, arg0, arg5, v4, arg6);
        update_analysis_bsize(arg0, v4);
    }

    public fun buy_cross_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::DepositProof, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::verifyDepositProof<T1>(&arg3, arg4);
        buy_cross_clt_int<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
    }

    fun buy_cross_clt_int<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg6, 2);
        validateMarket<T0, T1>(true, arg0, arg1, false);
        let v0 = 0x2::balance::value<T1>(&arg3);
        let v1 = pkiosk_mut(arg0);
        assert!(v0 >= 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::orderPrice(v1, arg4), 6005);
        let v2 = pkiosk_mut(arg0);
        let v3 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::orderIdFromNft(v2, arg4);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = orderbook_mut(arg0);
        assert!(!0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_expired(v5, v3, v4), 6006);
        deposit_balance<T1>(arg0, arg3);
        let v6 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg7), v0, true, 0x1::option::some<0x2::object::ID>(arg4), 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_cross(), v3, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ice_berge());
        let v7 = config(arg0).allow_self_match;
        let v8 = orderbook_mut(arg0);
        let (v9, v10, v11, v12) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_cross(v8, &v6, v7, v4);
        deliver_cross_clt<T0, T1>(arg2, arg1, v9, v10, v11, v12, arg0, arg6, v4, arg7);
        update_analysis_bsize(arg0, v4);
    }

    public fun buy_cross_clt_orderid<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::DepositProof, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::verifyDepositProof<T1>(&arg3, arg4);
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg7, 2);
        validateMarket<T0, T1>(true, arg0, arg1, false);
        let v0 = orderbook_mut(arg0);
        let (v1, _, v3, v4, v5) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_info(0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order(v0, arg5));
        assert!(v3 > 0 && !v1, 6011);
        let v6 = 0x2::balance::value<T1>(&arg3);
        assert!(v6 >= v5, 6005);
        let v7 = 0x2::clock::timestamp_ms(arg6);
        let v8 = orderbook_mut(arg0);
        assert!(!0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_expired(v8, arg5, v7), 6006);
        deposit_balance<T1>(arg0, arg3);
        let v9 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg8), v6, true, v4, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_cross(), arg5, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ice_berge());
        let v10 = config(arg0).allow_self_match;
        let v11 = orderbook_mut(arg0);
        let (v12, v13, v14, v15) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_cross(v11, &v9, v10, v7);
        deliver_cross_clt<T0, T1>(arg2, arg1, v12, v13, v14, v15, arg0, arg7, v7, arg8);
        update_analysis_bsize(arg0, v7);
        assert!(2 <= 1, 6012);
    }

    public fun buy_cross_clt_orderidV2<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::balance::Balance<T1>, arg5: 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::DepositProof, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::verifyDepositProof<T1>(&arg4, arg5);
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg8, 2);
        validateMarket<T0, T1>(true, arg0, arg1, false);
        let v0 = orderbook_mut(arg0);
        let (v1, _, v3, v4, v5) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_info(0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order(v0, arg6));
        assert!(v3 > 0 && !v1, 6011);
        let v6 = 0x2::balance::value<T1>(&arg4);
        assert!(v6 >= v5, 6005);
        let v7 = 0x2::clock::timestamp_ms(arg7);
        let v8 = orderbook_mut(arg0);
        assert!(!0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_expired(v8, arg6, v7), 6006);
        deposit_balance<T1>(arg0, arg4);
        let v9 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg9), v6, true, v4, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_cross(), arg6, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ice_berge());
        let v10 = config(arg0).allow_self_match;
        let v11 = orderbook_mut(arg0);
        let (v12, v13, v14, v15) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_cross(v11, &v9, v10, v7);
        let v16 = v12;
        if (0x1::option::is_some<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>(&v16)) {
            let v17 = 0x1::option::extract<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>(&mut v16);
            let (_, v19, _, _, _) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::fill_info(&v17);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v14);
        };
        deliver_cross_clt<T0, T1>(arg2, arg1, v16, v13, v14, v15, arg0, arg8, v7, arg9);
        update_analysis_bsize(arg0, v7);
    }

    public fun buy_cross_orderid<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg5, 2);
        validateMarket<T0, T1>(true, arg0, arg1, true);
        let v0 = orderbook_mut(arg0);
        let (v1, _, v3, v4, v5) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_info(0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order(v0, arg3));
        assert!(v3 > 0 && !v1, 6011);
        let v6 = 0x2::coin::value<T1>(&arg2);
        assert!(v6 >= v5, 6005);
        let v7 = 0x2::clock::timestamp_ms(arg4);
        let v8 = orderbook_mut(arg0);
        assert!(!0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_expired(v8, arg3, v7), 6006);
        deposit_coin<T1>(arg0, arg2);
        let v9 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), v6, true, v4, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_cross(), arg3, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ice_berge());
        let v10 = config(arg0).allow_self_match;
        let v11 = orderbook_mut(arg0);
        let (v12, v13, v14, v15) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_cross(v11, &v9, v10, v7);
        deliver_cross<T0, T1>(arg1, v12, v13, v14, v15, arg0, arg5, v7, arg6);
        update_analysis_bsize(arg0, v7);
    }

    public fun buy_flash<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg4, 2);
        validateMarket<T0, T1>(true, arg0, arg1, true);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 6003);
        deposit_coin<T1>(arg0, arg2);
        let v2 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), v1, true, 0x1::option::none<0x2::object::ID>(), 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_market(), 0, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ice_berge());
        let v3 = config(arg0).allow_self_match;
        let v4 = orderbook_mut(arg0);
        let v5 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_order(v4, &v2, v3, v0);
        deliver<T0, T1>(v5, arg0, arg1, arg4, v0, arg5);
        update_analysis_bsize(arg0, v0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_id(&v5)
    }

    public fun buy_flash_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::DepositProof, arg5: &0x2::clock::Clock, arg6: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg7: &mut 0x2::tx_context::TxContext) : u128 {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg6, 2);
        validateMarket<T0, T1>(true, arg0, arg1, false);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::verifyDepositProof<T1>(&arg3, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::balance::value<T1>(&arg3);
        assert!(v1 > 0, 6003);
        deposit_balance<T1>(arg0, arg3);
        let v2 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg7), v1, true, 0x1::option::none<0x2::object::ID>(), 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_market(), 0, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ice_berge());
        let v3 = config(arg0).allow_self_match;
        let v4 = orderbook_mut(arg0);
        let v5 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_order(v4, &v2, v3, v0);
        deliver_clt<T0, T1>(v5, arg0, arg1, arg2, arg6, v0, arg7);
        update_analysis_bsize(arg0, v0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_id(&v5)
    }

    public fun buy_limit<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg7: &mut 0x2::tx_context::TxContext) : u128 {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg6, 2);
        validateMarket<T0, T1>(false, arg0, arg1, true);
        validateOfferPrice(arg0, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = config_mut(arg0);
        let v3 = arg3 - arg3 % v2.tick_size;
        let v4 = if (arg4 > 0) {
            v0 + 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::one_hour_ms() * arg4
        } else {
            0
        };
        assert!(v3 > 0 && v1 >= v3, 6003);
        deposit_coin<T1>(arg0, arg2);
        let v5 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg7), v1, true, 0x1::option::none<0x2::object::ID>(), v3, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_limit(), 0, v4, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ice_berge());
        let v6 = config(arg0).allow_self_match;
        let v7 = orderbook_mut(arg0);
        let v8 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_order(v7, &v5, v6, v0);
        deliver<T0, T1>(v8, arg0, arg1, arg6, v0, arg7);
        update_analysis_bsize(arg0, v0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_id(&v8)
    }

    public fun buy_limit_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::DepositProof, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg9: &mut 0x2::tx_context::TxContext) : u128 {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg8, 2);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::verifyDepositProof<T1>(&arg3, arg4);
        validateMarket<T0, T1>(true, arg0, arg1, false);
        validateOfferPrice(arg0, arg5);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::balance::value<T1>(&arg3);
        let v2 = config_mut(arg0);
        let v3 = arg5 - arg5 % v2.tick_size;
        let v4 = if (arg6 > 0) {
            v0 + 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ten_days_ms()
        } else {
            0
        };
        assert!(v3 > 0 && v1 >= v3, 6003);
        deposit_balance<T1>(arg0, arg3);
        let v5 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg9), v1, true, 0x1::option::none<0x2::object::ID>(), v3, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_limit(), 0, v4, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ice_berge());
        let v6 = config(arg0).allow_self_match;
        let v7 = orderbook_mut(arg0);
        let v8 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_order(v7, &v5, v6, v0);
        deliver_clt<T0, T1>(v8, arg0, arg1, arg2, arg8, v0, arg9);
        update_analysis_bsize(arg0, v0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_id(&v8)
    }

    public fun cancel_buy<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: vector<u128>, arg3: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg3, 2);
        validateMarket2<T0, T1>(arg0, arg1, true);
        let v0 = 0x1::vector::length<u128>(&arg2);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<u128>(&arg2, v0);
            let v2 = orderbook_mut(arg0);
            let (v3, v4, _, _, _) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_info(0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order(v2, v1));
            assert!(v4 == 0x2::tx_context::sender(arg4) && v3, 6003);
            let v8 = orderbook_mut(arg0);
            let v9 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::cancel_order(v8, v1);
            let v10 = balance_vault<T1>(arg0);
            let v11 = 0x2::tx_context::sender(arg4);
            refund_coin<T1>(v10, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::remain_balance(&v9), v11, arg4);
        };
    }

    public fun cancel_buy_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: vector<u128>, arg4: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg4, 2);
        validateMarket2<T0, T1>(arg0, arg1, false);
        let v0 = 0x1::vector::length<u128>(&arg3);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<u128>(&arg3, v0);
            let v2 = orderbook_mut(arg0);
            let (v3, v4, _, _, _) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_info(0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order(v2, v1));
            assert!(v4 == 0x2::tx_context::sender(arg5) && v3, 6003);
            let v8 = orderbook_mut(arg0);
            let v9 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::cancel_order(v8, v1);
            let v10 = 0x2::tx_context::sender(arg5);
            refund_balance<T1>(arg2, arg0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::remain_balance(&v9), v10, arg5);
        };
    }

    public fun cancel_sell<T0: store + key, T1>(arg0: &mut Market, arg1: vector<0x2::object::ID>, arg2: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg2, 2);
        validateMarket0<T0, T1>(arg0);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v0);
            let v2 = pkiosk_mut(arg0);
            assert!(0x2::tx_context::sender(arg3) == 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::orderOwner(v2, v1), 6007);
            let v3 = pkiosk_mut(arg0);
            0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::cancel_order(orderbook_mut(arg0), 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::delistAndTake<T0, T1>(v3, v1, arg2, arg3));
        };
    }

    public fun cancel_sell_ordid<T0: store + key, T1>(arg0: &mut Market, arg1: vector<u128>, arg2: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg2, 2);
        validateMarket0<T0, T1>(arg0);
        let v0 = 0x1::vector::length<u128>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = orderbook_mut(arg0);
            let v2 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::cancel_order(v1, 0x1::vector::pop_back<u128>(&mut arg1));
            let (v3, v4, _, v6, _) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_info(&v2);
            let v8 = v6;
            assert!(v4 == 0x2::tx_context::sender(arg3), 6007);
            assert!(!v3 && 0x1::option::is_some<0x2::object::ID>(&v8), 6003);
            0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg0), 0x1::option::extract<0x2::object::ID>(&mut v8), arg2, arg3);
        };
    }

    fun config(arg0: &Market) : &Config {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, Config>(&arg0.id, 0x1::type_name::get<Config>())
    }

    fun config_mut(arg0: &mut Market) : &mut Config {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Config>(&mut arg0.id, 0x1::type_name::get<Config>())
    }

    public fun createMarket<T0: store + key, T1>(arg0: &MarketAdminCap, arg1: &0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg9, 2);
        assert!(arg3 > 0 && arg4 > 0 && arg5 <= 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::max_fee() && arg6 > 0 && arg7 <= 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::max_fee(), 6009);
        let v0 = pair<T0, T1>();
        let v1 = Market{
            id          : 0x2::object::new(arg10),
            policy      : 0x2::object::id<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>>(arg1),
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
            allow_self_match : arg8,
            max_order        : arg6,
            min_offer_per    : arg7,
        };
        let v4 = MarketCreated{
            id               : 0x2::object::id<Market>(&v1),
            bid              : 0x1::type_name::into_string(v0.token),
            ask              : 0x1::type_name::into_string(v0.nft),
            coin_or_clt      : arg2,
            tick_size        : arg3,
            min_size         : arg4,
            base_fee         : arg5,
            max_order        : arg6,
            allow_self_match : arg8,
            policy           : 0x2::object::id_address<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>>(arg1),
        };
        0x2::event::emit<MarketCreated>(v4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Book>(&mut v1.id, 0x1::type_name::get<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Book>(), 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::empty(arg5, arg3, arg4, arg10));
        0x2::dynamic_field::add<0x1::type_name::TypeName, BalanceManager<T1>>(&mut v1.id, 0x1::type_name::get<BalanceManager<T1>>(), v2);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::PublicKiosk>(&mut v1.id, 0x1::type_name::get<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::PublicKiosk>(), 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::createPublicKiosk<T0, T1>(arg9, arg10));
        0x2::dynamic_field::add<0x1::type_name::TypeName, Config>(&mut v1.id, 0x1::type_name::get<Config>(), v3);
        let v5 = Analysis{
            floor     : 0,
            ceil      : 0,
            vol       : 0,
            bids_size : 0,
            asks_size : 0,
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, Analysis>(&mut v1.id, 0x1::type_name::get<Analysis>(), v5);
        0x2::transfer::public_share_object<Market>(v1);
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::cap_vault::createVault<MarketAdminCap>(arg10);
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::cap_vault::createVault<MarketTreasureCap>(arg10);
    }

    fun deliver<T0: store + key, T1>(arg0: 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::TradeProof, arg1: &mut Market, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg3: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::bill_info(&arg0);
        let v2 = 0x1::vector::length<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>(v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            let v3 = 0x1::vector::borrow<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>(v0, v2);
            let (v4, v5, v6, v7, v8) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::fill_info(v3);
            let v9 = if (v4) {
                0x2::tx_context::sender(arg5)
            } else {
                v5
            };
            let v10 = balance_vault<T1>(arg1);
            let v11 = 0x2::balance::split<T1>(&mut v10.balance, v6);
            let v12 = &mut v11;
            let (_, v14, v15) = deliverNft<T0, T1>(arg1, arg2, v8, v12, v9, arg3, arg5);
            0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_and_fire_event_filled(0x2::object::id<Market>(arg1), v3, v14, v15);
            deposit_balance<T1>(arg1, v11);
            update_analysis_exec(arg1, v6, v7, arg4);
        };
        let v16 = 0x1::vector::length<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::ExpiredBill>(v1);
        while (v16 > 0) {
            v16 = v16 - 1;
            let (v17, v18, v19, v20) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::expired_info(0x1::vector::borrow<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::ExpiredBill>(v1, v16));
            let v21 = v20;
            if (v17) {
                let v22 = balance_vault<T1>(arg1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v22.balance, v19), arg5), v18);
                continue
            };
            let v23 = pkiosk_mut(arg1);
            0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::delistAndTake<T0, T1>(v23, *0x1::option::borrow<0x2::object::ID>(&v21), arg3, arg5);
        };
        let (v24, _, v26, v27, v28, v29) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::trade_info(&arg0);
        let v30 = v29;
        if (!v26) {
            if (v28) {
                if (v27 > 0) {
                    let v31 = balance_vault<T1>(arg1);
                    refund_coin<T1>(v31, v27, v24, arg5);
                };
            } else if (v27 > 0) {
                0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg1), *0x1::option::borrow<0x2::object::ID>(&v30), arg3, arg5);
            };
        };
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::confirm_proof(arg0);
    }

    fun deliverNft<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::balance::Balance<T1>, arg4: address, arg5: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (u128, u64, u64) {
        let v0 = config_mut(arg0);
        let v1 = v0.base_fee;
        let v2 = pkiosk_mut(arg0);
        let (v3, v4, v5) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::purchase<T0, T1>(v2, arg2, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        assert!(0x2::object::id<T0>(&v8) == 0x2::transfer_policy::item<T0>(&v7), 6002);
        let (v9, v10, v11) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::payByCoin<T0, T1>(arg1, v7, &v6, arg3, v1, arg6);
        0x2::transfer::public_transfer<T0>(v8, arg4);
        0x2::balance::join<T1>(&mut balance_vault<T1>(arg0).fee, v9);
        (0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::orderId(&v6), v10, v11)
    }

    fun deliverNftClt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::balance::Balance<T1>, arg5: address, arg6: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (u128, u64, u64) {
        let v0 = config_mut(arg0);
        let v1 = v0.base_fee;
        let v2 = pkiosk_mut(arg0);
        let (v3, v4, v5) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::purchase<T0, T1>(v2, arg3, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        assert!(0x2::object::id<T0>(&v8) == 0x2::transfer_policy::item<T0>(&v7), 6002);
        let (v9, v10, v11) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::payByClt<T0, T1>(arg2, arg1, v7, &v6, arg4, v1, arg7);
        0x2::transfer::public_transfer<T0>(v8, arg5);
        0x2::balance::join<T1>(&mut balance_vault<T1>(arg0).fee, v9);
        (0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::orderId(&v6), v10, v11)
    }

    fun deliver_clt<T0: store + key, T1>(arg0: 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::TradeProof, arg1: &mut Market, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg3: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg4: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::bill_info(&arg0);
        let v2 = 0x1::vector::length<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>(v0);
        while (v2 > 0) {
            let v3 = 0x1::vector::borrow<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>(v0, v2 - 1);
            let (v4, v5, v6, v7, v8) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::fill_info(v3);
            let v9 = if (v4) {
                0x2::tx_context::sender(arg6)
            } else {
                v5
            };
            let v10 = balance_vault<T1>(arg1);
            let v11 = 0x2::balance::split<T1>(&mut v10.balance, v6);
            let v12 = &mut v11;
            let (_, v14, v15) = deliverNftClt<T0, T1>(arg1, arg2, arg3, v8, v12, v9, arg4, arg6);
            0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_and_fire_event_filled(0x2::object::id<Market>(arg1), v3, v14, v15);
            deposit_balance<T1>(arg1, v11);
            update_analysis_exec(arg1, v6, v7, arg5);
            v2 = v2 - 1;
        };
        let v16 = 0x1::vector::length<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::ExpiredBill>(v1);
        while (v16 > 0) {
            v16 = v16 - 1;
            let (v17, v18, v19, v20) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::expired_info(0x1::vector::borrow<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::ExpiredBill>(v1, v16));
            let v21 = v20;
            if (v17) {
                refund_balance<T1>(arg3, arg1, v19, v18, arg6);
                continue
            };
            let v22 = pkiosk_mut(arg1);
            0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::delistAndTake<T0, T1>(v22, *0x1::option::borrow<0x2::object::ID>(&v21), arg4, arg6);
        };
        let (v23, _, v25, v26, v27, v28) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::trade_info(&arg0);
        let v29 = v28;
        if (!v25) {
            if (v27) {
                if (v26 > 0) {
                    refund_balance<T1>(arg3, arg1, v26, v23, arg6);
                };
            } else if (v26 > 0) {
                0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg1), *0x1::option::borrow<0x2::object::ID>(&v29), arg4, arg6);
            };
        };
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::confirm_proof(arg0);
    }

    fun deliver_cross<T0: store + key, T1>(arg0: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg1: 0x1::option::Option<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>, arg2: 0x1::option::Option<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::ExpiredBill>, arg3: address, arg4: u64, arg5: &mut Market, arg6: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>(&arg1)) {
            let v0 = 0x1::option::extract<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>(&mut arg1);
            let v1 = &v0;
            let (v2, v3, v4, v5, v6) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::fill_info(v1);
            let v7 = if (v2) {
                0x2::tx_context::sender(arg8)
            } else {
                v3
            };
            let v8 = balance_vault<T1>(arg5);
            let v9 = 0x2::balance::split<T1>(&mut v8.balance, v4);
            let v10 = &mut v9;
            let (_, v12, v13) = deliverNft<T0, T1>(arg5, arg0, v6, v10, v7, arg6, arg8);
            0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_and_fire_event_filled(0x2::object::id<Market>(arg5), v1, v12, v13);
            deposit_balance<T1>(arg5, v9);
            update_analysis_exec(arg5, v4, v5, arg7);
        };
        if (0x1::option::is_some<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::ExpiredBill>(&arg2)) {
            let v14 = 0x1::option::extract<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::ExpiredBill>(&mut arg2);
            let (v15, v16, v17, v18) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::expired_info(&v14);
            let v19 = v18;
            if (v15) {
                let v20 = balance_vault<T1>(arg5);
                refund_coin<T1>(v20, v17, v16, arg8);
            } else {
                let v21 = pkiosk_mut(arg5);
                0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::delistAndTake<T0, T1>(v21, *0x1::option::borrow<0x2::object::ID>(&v19), arg6, arg8);
            };
        };
        if (arg4 > 0) {
            let v22 = balance_vault<T1>(arg5);
            refund_coin<T1>(v22, arg4, arg3, arg8);
        };
    }

    fun deliver_cross_clt<T0: store + key, T1>(arg0: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: 0x1::option::Option<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>, arg3: 0x1::option::Option<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::ExpiredBill>, arg4: address, arg5: u64, arg6: &mut Market, arg7: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>(&arg2)) {
            let v0 = 0x1::option::extract<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Bill>(&mut arg2);
            let v1 = &v0;
            let (v2, v3, v4, v5, v6) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::fill_info(v1);
            let v7 = if (v2) {
                0x2::tx_context::sender(arg9)
            } else {
                v3
            };
            let v8 = balance_vault<T1>(arg6);
            let v9 = 0x2::balance::split<T1>(&mut v8.balance, v4);
            let v10 = &mut v9;
            let (_, v12, v13) = deliverNftClt<T0, T1>(arg6, arg1, arg0, v6, v10, v7, arg7, arg9);
            0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_and_fire_event_filled(0x2::object::id<Market>(arg6), v1, v12, v13);
            deposit_balance<T1>(arg6, v9);
            update_analysis_exec(arg6, v4, v5, arg8);
        };
        if (0x1::option::is_some<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::ExpiredBill>(&arg3)) {
            let v14 = 0x1::option::extract<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::ExpiredBill>(&mut arg3);
            let (v15, v16, v17, v18) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::expired_info(&v14);
            let v19 = v18;
            if (v15) {
                refund_balance<T1>(arg0, arg6, v17, v16, arg9);
            } else {
                let v20 = pkiosk_mut(arg6);
                0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::delistAndTake<T0, T1>(v20, *0x1::option::borrow<0x2::object::ID>(&v19), arg7, arg9);
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

    fun emitMarketAnal(arg0: &Analysis, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = MarketAnalysis{
            id        : arg1,
            vol       : arg0.vol,
            floor     : arg0.floor,
            ceil      : arg0.ceil,
            bids_size : arg0.bids_size,
            asks_size : arg0.asks_size,
            timestamp : arg2,
        };
        0x2::event::emit<MarketAnalysis>(v0);
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MarketAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MarketTreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MarketTreasureCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun orderbook(arg0: &Market) : &0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Book {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Book>(&arg0.id, 0x1::type_name::get<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Book>())
    }

    fun orderbook_mut(arg0: &mut Market) : &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Book {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Book>(&mut arg0.id, 0x1::type_name::get<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::Book>())
    }

    fun pair<T0: store + key, T1>() : Pair {
        Pair{
            nft   : 0x1::type_name::get<T0>(),
            token : 0x1::type_name::get<T1>(),
        }
    }

    fun pkiosk_mut(arg0: &mut Market) : &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::PublicKiosk {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::PublicKiosk>(&mut arg0.id, 0x1::type_name::get<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::PublicKiosk>())
    }

    fun refund_balance<T0>(arg0: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T0>, arg1: &mut Market, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::withdrawTo<T0>(0x2::balance::split<T0>(&mut balance_vault<T0>(arg1).balance, arg2), arg3, arg0, arg4);
    }

    fun refund_coin<T0>(arg0: &mut BalanceManager<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
    }

    public fun sell_flash<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg4, 2);
        validateMarket<T0, T1>(false, arg0, arg1, true);
        let v0 = 0x2::object::id<T0>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = pkiosk_mut(arg0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::placeAndList<T0, T1>(v2, arg2, 0, arg4, arg5);
        let v3 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), 1, false, 0x1::option::some<0x2::object::ID>(v0), 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_market(), 0, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::atomic());
        let v4 = config(arg0).allow_self_match;
        let v5 = orderbook_mut(arg0);
        let v6 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_order(v5, &v3, v4, v1);
        let v7 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_id(&v6);
        let v8 = pkiosk_mut(arg0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::bindOrderId(v8, v0, v7);
        deliver<T0, T1>(v6, arg0, arg1, arg4, v1, arg5);
        update_analysis_bsize(arg0, v1);
        v7
    }

    public fun sell_flash_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: T0, arg4: &0x2::clock::Clock, arg5: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg5, 2);
        validateMarket<T0, T1>(false, arg0, arg1, false);
        let v0 = 0x2::object::id<T0>(&arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = pkiosk_mut(arg0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::placeAndList<T0, T1>(v2, arg3, 0, arg5, arg6);
        let v3 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), 1, false, 0x1::option::some<0x2::object::ID>(v0), 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_market(), 0, 0, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::atomic());
        let v4 = config(arg0).allow_self_match;
        let v5 = orderbook_mut(arg0);
        let v6 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_order(v5, &v3, v4, v1);
        let v7 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_id(&v6);
        let v8 = pkiosk_mut(arg0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::bindOrderId(v8, v0, v7);
        deliver_clt<T0, T1>(v6, arg0, arg1, arg2, arg5, v1, arg6);
        update_analysis_bsize(arg0, v1);
        v7
    }

    public fun sell_limit<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: T0, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg7: &mut 0x2::tx_context::TxContext) : u128 {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg6, 2);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        validateMarket<T0, T1>(false, arg0, arg1, true);
        let v1 = 0x2::object::id<T0>(&arg2);
        let v2 = config_mut(arg0);
        let v3 = arg3 - arg3 % v2.tick_size;
        let v4 = if (arg4 > 0) {
            v0 + 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::one_hour_ms() * arg4
        } else {
            0
        };
        let v5 = pkiosk_mut(arg0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::placeAndList<T0, T1>(v5, arg2, v3, arg6, arg7);
        let v6 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg7), 1, false, 0x1::option::some<0x2::object::ID>(v1), v3, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_limit(), 0, v4, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::atomic());
        let v7 = config(arg0).allow_self_match;
        let v8 = orderbook_mut(arg0);
        let v9 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_order(v8, &v6, v7, v0);
        let v10 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_id(&v9);
        let v11 = pkiosk_mut(arg0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::bindOrderId(v11, v1, v10);
        deliver<T0, T1>(v9, arg0, arg1, arg6, v0, arg7);
        update_analysis_bsize(arg0, v0);
        v10
    }

    public fun sell_limit_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: T0, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg8: &mut 0x2::tx_context::TxContext) : u128 {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg7, 2);
        validateMarket<T0, T1>(false, arg0, arg1, false);
        let v0 = 0x2::object::id<T0>(&arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = config_mut(arg0);
        let v3 = arg4 - arg4 % v2.tick_size;
        let v4 = if (arg5 > 0) {
            v1 + 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::one_hour_ms() * arg5
        } else {
            0
        };
        let v5 = pkiosk_mut(arg0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::placeAndList<T0, T1>(v5, arg3, v3, arg7, arg8);
        let v6 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg8), 1, false, 0x1::option::some<0x2::object::ID>(v0), v3, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::ord_limit(), 0, v4, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::atomic());
        let v7 = config(arg0).allow_self_match;
        let v8 = orderbook_mut(arg0);
        let v9 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::place_order(v8, &v6, v7, v1);
        let v10 = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::order_id(&v9);
        let v11 = pkiosk_mut(arg0);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::bindOrderId(v11, v0, v10);
        deliver_clt<T0, T1>(v9, arg0, arg1, arg2, arg7, v1, arg8);
        update_analysis_bsize(arg0, v1);
        v10
    }

    public fun sweep<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg5, 2);
        validateMarket<T0, T1>(true, arg0, arg1, true);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg2);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            let v2 = pkiosk_mut(arg0);
            let v3 = 0x2::coin::split<T1>(arg3, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::orderPrice(v2, v1), arg6);
            buy_cross<T0, T1>(arg0, arg1, v3, v1, arg4, arg5, arg6);
        };
    }

    public fun sweep_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: &mut 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::CltVault<T1>, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::balance::Balance<T1>, arg5: 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::DepositProof, arg6: &0x2::clock::Clock, arg7: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg7, 2);
        validateMarket<T0, T1>(true, arg0, arg1, false);
        0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::clt::verifyDepositProof<T1>(arg4, arg5);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg3);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v0);
            let v2 = pkiosk_mut(arg0);
            buy_cross_clt_int<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(arg4, 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::public_kiosk::orderPrice(v2, v1)), v1, arg6, arg7, arg8);
        };
    }

    fun update_analysis_bsize(arg0: &mut Market, arg1: u64) {
        let (v0, v1) = 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::book::book_size(orderbook(arg0));
        let v2 = 0x2::object::id<Market>(arg0);
        let v3 = analysis_mut(arg0);
        v3.bids_size = v0;
        v3.asks_size = v1;
        emitMarketAnal(v3, v2, arg1);
    }

    fun update_analysis_exec(arg0: &mut Market, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x2::object::id<Market>(arg0);
        let v1 = analysis_mut(arg0);
        v1.vol = v1.vol + (arg1 as u128);
        v1.floor = 0x1::u64::min(v1.floor, arg2);
        v1.ceil = 0x1::u64::max(v1.ceil, arg2);
        emitMarketAnal(v1, v0, arg3);
    }

    fun validateMarket<T0: store + key, T1>(arg0: bool, arg1: &mut Market, arg2: &0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg3: bool) {
        assert!(arg1.pair == pair<T0, T1>() && arg1.policy == 0x2::object::id<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>>(arg2), 6001);
        assert!(arg1.coin_or_clt == arg3, 6004);
        let v0 = config(arg1).max_order;
        let v1 = analysis_mut(arg1);
        assert!(arg0 && v1.bids_size <= v0 || !arg0 && v1.asks_size <= v0, 6008);
    }

    fun validateMarket0<T0: store + key, T1>(arg0: &Market) {
        assert!(arg0.pair == pair<T0, T1>(), 6001);
    }

    fun validateMarket2<T0: store + key, T1>(arg0: &Market, arg1: &0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>, arg2: bool) {
        assert!(arg0.pair == pair<T0, T1>() && arg0.policy == 0x2::object::id<0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::payment_policy::PolicyVault<T0>>(arg1), 6001);
        assert!(arg0.coin_or_clt == arg2, 6004);
    }

    fun validateOfferPrice(arg0: &Market, arg1: u64) {
        let v0 = analysis(arg0).floor;
        assert!(v0 >= 0 && arg1 >= 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::math::div(0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::math::mul(v0, config(arg0).min_offer_per), 0x72f2e0d7d1355ddac47f37175d3e7f0267cc0b2e287511f5c830bda8f88d74f4::constants::max_fee()), 6010);
    }

    public fun withdraw_fee<T0: store + key, T1>(arg0: &MarketTreasureCap, arg1: &mut Market, arg2: &0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::Version) : 0x2::balance::Balance<T1> {
        0xb183d6f389f0208902e953c842e54620e903090f40bc441dfb54a77c0943c92b::version::checkVersion(arg2, 2);
        assert!(pair<T0, T1>() == arg1.pair, 6001);
        let v0 = &mut balance_vault<T1>(arg1).fee;
        0x2::balance::split<T1>(v0, 0x2::balance::value<T1>(v0))
    }

    // decompiled from Move bytecode v6
}

