module 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::market {
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
    }

    struct MarketAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketTreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        pair: Pair,
        coin_or_clt: bool,
    }

    struct BalanceManager<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T0>,
    }

    struct MarketCreated has copy, drop, store {
        id: 0x2::object::ID,
        bid: 0x1::type_name::TypeName,
        ask: 0x1::type_name::TypeName,
        coin_or_clt: bool,
        tick_size: u64,
        min_size: u64,
        base_fee: u64,
        allow_self_match: bool,
        policy: address,
    }

    fun balance_vault<T0>(arg0: &mut Market) : &mut BalanceManager<T0> {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, BalanceManager<T0>>(&mut arg0.id, 0x1::type_name::get<BalanceManager<T0>>())
    }

    public fun buy_cross<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, true);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = pkiosk_mut(arg0);
        assert!(v0 >= 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::orderPrice(v1, arg2), 6005);
        let v2 = pkiosk_mut(arg0);
        let v3 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::orderIdFromNft(v2, arg2);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = orderbook(arg0);
        assert!(v4 < 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_expiretime(v5, v3), 6006);
        deposit_coin<T1>(arg0, arg1);
        let v6 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), v0, true, 0x1::option::some<0x2::object::ID>(arg2), 0, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ord_cross(), v3, v4 + 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ten_days_ms(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ice_berge());
        let v7 = orderbook(arg0);
        let (v8, v9, v10, v11) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::place_cross(v7, &mut v6, v4);
        deliver_cross<T0, T1>(v8, v9, v10, v11, arg0, arg4, arg5);
    }

    public fun buy_cross_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: 0x2::token::Token<T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(arg0, false);
        let v0 = 0x2::token::value<T1>(&arg2);
        let v1 = pkiosk_mut(arg0);
        assert!(v0 >= 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::orderPrice(v1, arg3), 6005);
        let v2 = pkiosk_mut(arg0);
        let v3 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::orderIdFromNft(v2, arg3);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = orderbook(arg0);
        assert!(v4 < 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_expiretime(v5, v3), 6006);
        deposit_token<T1>(arg0, arg2, arg1, arg6);
        let v6 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), v0, true, 0x1::option::some<0x2::object::ID>(arg3), 0, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ord_cross(), v3, v4 + 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ten_days_ms(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ice_berge());
        let v7 = orderbook(arg0);
        let (v8, v9, v10, v11) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::place_cross(v7, &mut v6, v4);
        deliver_cross_clt<T0, T1>(arg1, v8, v9, v10, v11, arg0, arg5, arg6);
    }

    public fun buy_flash<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg4: &mut 0x2::tx_context::TxContext) : u128 {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg3, 1);
        validateMarket<T0, T1>(arg0, true);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v1 > 0, 6003);
        deposit_coin<T1>(arg0, arg1);
        let v2 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg4), v1, true, 0x1::option::none<0x2::object::ID>(), 0, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ord_market(), 0, v0 + 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ten_days_ms(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ice_berge());
        let v3 = orderbook(arg0);
        let v4 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::place_order(v3, &mut v2, v0);
        deliver<T0, T1>(v4, arg0, arg3, arg4);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_id(&v4)
    }

    public fun buy_flash_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: 0x2::token::Token<T1>, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, false);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::token::value<T1>(&arg2);
        assert!(v1 > 0, 6003);
        deposit_token<T1>(arg0, arg2, arg1, arg5);
        let v2 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), v1, true, 0x1::option::none<0x2::object::ID>(), 0, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ord_market(), 0, v0 + 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ten_days_ms(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ice_berge());
        let v3 = orderbook(arg0);
        let v4 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::place_order(v3, &mut v2, v0);
        deliver_clt<T0, T1>(v4, arg0, arg1, arg4, arg5);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_id(&v4)
    }

    public fun buy_limit<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, true);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let v2 = config(arg0);
        let v3 = arg2 - arg2 % v2.tick_size;
        assert!(v3 > 0 && v1 >= v3, 6003);
        deposit_coin<T1>(arg0, arg1);
        let v4 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), v1, true, 0x1::option::none<0x2::object::ID>(), v3, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ord_limit(), 0, v0 + 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ten_days_ms(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ice_berge());
        let v5 = orderbook(arg0);
        let v6 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::place_order(v5, &mut v4, v0);
        deliver<T0, T1>(v6, arg0, arg4, arg5);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_id(&v6)
    }

    public fun buy_limit_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: 0x2::token::Token<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(arg0, false);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::token::value<T1>(&arg2);
        let v2 = config(arg0);
        let v3 = arg3 - arg3 % v2.tick_size;
        assert!(v3 > 0 && v1 >= v3, 6003);
        deposit_token<T1>(arg0, arg2, arg1, arg6);
        let v4 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), v1, true, 0x1::option::none<0x2::object::ID>(), v3, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ord_limit(), 0, v0 + 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ten_days_ms(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ice_berge());
        let v5 = orderbook(arg0);
        let v6 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::place_order(v5, &mut v4, v0);
        deliver_clt<T0, T1>(v6, arg0, arg1, arg5, arg6);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_id(&v6)
    }

    public fun cancel_buy<T0: store + key, T1>(arg0: &mut Market, arg1: vector<u128>, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg2, 1);
        validateMarket<T0, T1>(arg0, true);
        let v0 = 0x1::vector::length<u128>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<u128>(&arg1, v0);
            let v2 = orderbook(arg0);
            let (v3, v4, _, _) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_info(0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order(v2, v1));
            assert!(v4 == 0x2::tx_context::sender(arg3) && v3, 6003);
            let v7 = orderbook(arg0);
            let v8 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::cancel_order(v7, v1);
            let v9 = balance_vault<T1>(arg0);
            let v10 = 0x2::tx_context::sender(arg3);
            refund_coin<T1>(v9, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::remain_balance(&v8), v10, arg3);
        };
    }

    public fun cancel_buy_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: vector<u128>, arg3: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg3, 1);
        validateMarket<T0, T1>(arg0, false);
        let v0 = 0x1::vector::length<u128>(&arg2);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<u128>(&arg2, v0);
            let v2 = orderbook(arg0);
            let (v3, v4, _, _) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_info(0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order(v2, v1));
            assert!(v4 == 0x2::tx_context::sender(arg4) && v3, 6003);
            let v7 = orderbook(arg0);
            let v8 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::cancel_order(v7, v1);
            let v9 = balance_vault<T1>(arg0);
            let v10 = 0x2::tx_context::sender(arg4);
            refund_token<T1>(arg1, v9, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::remain_balance(&v8), v10, arg4);
        };
    }

    public fun cancel_sell<T0: store + key, T1>(arg0: &mut Market, arg1: vector<0x2::object::ID>, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg2, 1);
        validateMarket0<T0, T1>(arg0);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v0);
            let v2 = pkiosk_mut(arg0);
            assert!(0x2::tx_context::sender(arg3) == 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::orderOwner(v2, v1), 6007);
            let v3 = pkiosk_mut(arg0);
            0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::cancel_order(orderbook(arg0), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::delistAndTake<T0, T1>(v3, v1, arg2, arg3));
        };
    }

    public fun cancel_sell_ordid<T0: store + key, T1>(arg0: &mut Market, arg1: vector<u128>, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg2, 1);
        validateMarket0<T0, T1>(arg0);
        let v0 = 0x1::vector::length<u128>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = orderbook(arg0);
            let v2 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::cancel_order(v1, 0x1::vector::pop_back<u128>(&mut arg1));
            let (v3, v4, _, v6) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_info(&v2);
            let v7 = v6;
            assert!(v4 == 0x2::tx_context::sender(arg3), 6007);
            assert!(!v3 && 0x1::option::is_some<0x2::object::ID>(&v7), 6003);
            0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg0), 0x1::option::extract<0x2::object::ID>(&mut v7), arg2, arg3);
        };
    }

    fun config(arg0: &mut Market) : &mut Config {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Config>(&mut arg0.id, 0x1::type_name::get<Config>())
    }

    public fun createMarket<T0: store + key, T1>(arg0: &MarketAdminCap, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x2::transfer_policy::TransferPolicy<T0>, arg7: 0x2::transfer_policy::TransferPolicyCap<T0>, arg8: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg8, 1);
        let v0 = pair<T0, T1>();
        let v1 = Market{
            id          : 0x2::object::new(arg9),
            pair        : v0,
            coin_or_clt : arg1,
        };
        let v2 = BalanceManager<T1>{
            balance : 0x2::balance::zero<T1>(),
            fee     : 0x2::balance::zero<T1>(),
        };
        let v3 = Config{
            tick_size        : arg2,
            min_size         : arg3,
            base_fee         : arg4,
            allow_self_match : arg5,
        };
        let v4 = MarketCreated{
            id               : 0x2::object::id<Market>(&v1),
            bid              : v0.token,
            ask              : v0.nft,
            coin_or_clt      : arg1,
            tick_size        : arg2,
            min_size         : arg3,
            base_fee         : arg4,
            allow_self_match : arg5,
            policy           : 0x2::object::id_address<0x2::transfer_policy::TransferPolicy<T0>>(&arg6),
        };
        0x2::event::emit<MarketCreated>(v4);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Book>(&mut v1.id, 0x1::type_name::get<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Book>(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::empty(arg4, arg2, arg3, arg9));
        0x2::dynamic_field::add<0x1::type_name::TypeName, BalanceManager<T1>>(&mut v1.id, 0x1::type_name::get<BalanceManager<T1>>(), v2);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<T0>>(&mut v1.id, 0x1::type_name::get<0x2::transfer_policy::TransferPolicy<T0>>(), arg6);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicyCap<T0>>(&mut v1.id, 0x1::type_name::get<0x2::transfer_policy::TransferPolicyCap<T0>>(), arg7);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::PublicKiosk>(&mut v1.id, 0x1::type_name::get<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::PublicKiosk>(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::createPublicKiosk<T0, T1>(arg8, arg9));
        0x2::dynamic_field::add<0x1::type_name::TypeName, Config>(&mut v1.id, 0x1::type_name::get<Config>(), v3);
        0x2::transfer::public_share_object<Market>(v1);
    }

    fun deliver<T0: store + key, T1>(arg0: 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::TradeProof, arg1: &mut Market, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::bill_info(&arg0);
        let v2 = 0x1::vector::length<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Bill>(v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            let (v3, v4, v5, v6) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::fill_info(0x1::vector::borrow<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Bill>(v0, v2));
            let v7 = v6;
            let v8 = if (v3) {
                0x2::tx_context::sender(arg3)
            } else {
                v4
            };
            let v9 = balance_vault<T1>(arg1);
            let v10 = 0x2::balance::split<T1>(&mut v9.balance, v5);
            let v11 = &mut v10;
            deliverNft<T0, T1>(arg1, *0x1::option::borrow<0x2::object::ID>(&v7), v11, v8, arg2, arg3);
            deposit_balance<T1>(arg1, v10);
        };
        let v12 = 0x1::vector::length<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::ExpiredBill>(v1);
        while (v12 > 0) {
            v12 = v12 - 1;
            let (v13, v14, v15, v16) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::expired_info(0x1::vector::borrow<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::ExpiredBill>(v1, v12));
            let v17 = v16;
            if (v13) {
                let v18 = balance_vault<T1>(arg1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v18.balance, v15), arg3), v14);
                continue
            };
            let v19 = pkiosk_mut(arg1);
            0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::delistAndTake<T0, T1>(v19, *0x1::option::borrow<0x2::object::ID>(&v17), arg2, arg3);
        };
        let (v20, _, v22, v23, v24, v25) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::trade_info(&arg0);
        let v26 = v25;
        if (!v22) {
            if (v24) {
                if (v23 > 0) {
                    let v27 = balance_vault<T1>(arg1);
                    refund_coin<T1>(v27, v23, v20, arg3);
                };
            } else if (v23 > 0) {
                0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg1), *0x1::option::borrow<0x2::object::ID>(&v26), arg2, arg3);
            };
        };
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::confirm_proof(arg0);
    }

    fun deliverNft<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::object::ID, arg2: &mut 0x2::balance::Balance<T1>, arg3: address, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = config(arg0);
        let v1 = v0.base_fee;
        let v2 = pkiosk_mut(arg0);
        let (v3, v4, v5) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::purchase<T0, T1>(v2, arg1, arg4, arg5);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        assert!(0x2::object::id<T0>(&v8) == 0x2::transfer_policy::item<T0>(&v7), 6002);
        let v9 = transferPolicy<T0>(arg0);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(v9, v7);
        0x2::transfer::public_transfer<T0>(v8, arg3);
        0x2::balance::join<T1>(&mut balance_vault<T1>(arg0).fee, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::payment_policy::payByCoin<T0, T1>(&mut v7, &v6, arg2, v1, arg5));
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::orderId(&v6)
    }

    fun deliverNftClt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::balance::Balance<T1>, arg4: address, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = config(arg0);
        let v1 = v0.base_fee;
        let v2 = pkiosk_mut(arg0);
        let (v3, v4, v5) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::purchase<T0, T1>(v2, arg2, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        assert!(0x2::object::id<T0>(&v8) == 0x2::transfer_policy::item<T0>(&v7), 6002);
        let v9 = transferPolicy<T0>(arg0);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(v9, v7);
        0x2::transfer::public_transfer<T0>(v8, arg4);
        0x2::balance::join<T1>(&mut balance_vault<T1>(arg0).fee, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::payment_policy::payByToken<T0, T1>(arg1, &mut v7, &v6, arg3, v1, arg6));
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::orderId(&v6)
    }

    fun deliver_clt<T0: store + key, T1>(arg0: 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::TradeProof, arg1: &mut Market, arg2: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg3: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::bill_info(&arg0);
        let v2 = 0x1::vector::length<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Bill>(v0);
        while (v2 > 0) {
            let (v3, v4, v5, v6) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::fill_info(0x1::vector::borrow<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Bill>(v0, v2 - 1));
            let v7 = v6;
            let v8 = if (v3) {
                0x2::tx_context::sender(arg4)
            } else {
                v4
            };
            let v9 = balance_vault<T1>(arg1);
            let v10 = 0x2::balance::split<T1>(&mut v9.balance, v5);
            let v11 = &mut v10;
            deliverNftClt<T0, T1>(arg1, arg2, *0x1::option::borrow<0x2::object::ID>(&v7), v11, v8, arg3, arg4);
            deposit_balance<T1>(arg1, v10);
            v2 = v2 - 1;
        };
        let v12 = 0x1::vector::length<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::ExpiredBill>(v1);
        while (v12 > 0) {
            v12 = v12 - 1;
            let (v13, v14, v15, v16) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::expired_info(0x1::vector::borrow<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::ExpiredBill>(v1, v12));
            let v17 = v16;
            if (v13) {
                let v18 = balance_vault<T1>(arg1);
                refund_token<T1>(arg2, v18, v15, v14, arg4);
                continue
            };
            let v19 = pkiosk_mut(arg1);
            0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::delistAndTake<T0, T1>(v19, *0x1::option::borrow<0x2::object::ID>(&v17), arg3, arg4);
        };
        let (v20, _, v22, v23, v24, v25) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::trade_info(&arg0);
        let v26 = v25;
        if (!v22) {
            if (v24) {
                if (v23 > 0) {
                    let v27 = balance_vault<T1>(arg1);
                    refund_token<T1>(arg2, v27, v23, v20, arg4);
                };
            } else if (v23 > 0) {
                0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg1), *0x1::option::borrow<0x2::object::ID>(&v26), arg3, arg4);
            };
        };
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::confirm_proof(arg0);
    }

    fun deliver_cross<T0: store + key, T1>(arg0: 0x1::option::Option<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Bill>, arg1: 0x1::option::Option<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::ExpiredBill>, arg2: address, arg3: u64, arg4: &mut Market, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Bill>(&arg0)) {
            let v0 = 0x1::option::extract<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Bill>(&mut arg0);
            let (v1, v2, v3, v4) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::fill_info(&v0);
            let v5 = v4;
            let v6 = if (v1) {
                0x2::tx_context::sender(arg6)
            } else {
                v2
            };
            let v7 = balance_vault<T1>(arg4);
            let v8 = 0x2::balance::split<T1>(&mut v7.balance, v3);
            let v9 = &mut v8;
            deliverNft<T0, T1>(arg4, *0x1::option::borrow<0x2::object::ID>(&v5), v9, v6, arg5, arg6);
            deposit_balance<T1>(arg4, v8);
        };
        if (0x1::option::is_some<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::ExpiredBill>(&arg1)) {
            let v10 = 0x1::option::extract<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::ExpiredBill>(&mut arg1);
            let (v11, v12, v13, v14) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::expired_info(&v10);
            let v15 = v14;
            if (v11) {
                let v16 = balance_vault<T1>(arg4);
                refund_coin<T1>(v16, v13, v12, arg6);
            } else {
                let v17 = pkiosk_mut(arg4);
                0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::delistAndTake<T0, T1>(v17, *0x1::option::borrow<0x2::object::ID>(&v15), arg5, arg6);
            };
        };
        if (arg3 > 0) {
            let v18 = balance_vault<T1>(arg4);
            refund_coin<T1>(v18, arg3, arg2, arg6);
        };
    }

    fun deliver_cross_clt<T0: store + key, T1>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg1: 0x1::option::Option<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Bill>, arg2: 0x1::option::Option<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::ExpiredBill>, arg3: address, arg4: u64, arg5: &mut Market, arg6: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Bill>(&arg1)) {
            let v0 = 0x1::option::extract<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Bill>(&mut arg1);
            let (v1, v2, v3, v4) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::fill_info(&v0);
            let v5 = v4;
            let v6 = if (v1) {
                0x2::tx_context::sender(arg7)
            } else {
                v2
            };
            let v7 = balance_vault<T1>(arg5);
            let v8 = 0x2::balance::split<T1>(&mut v7.balance, v3);
            let v9 = &mut v8;
            deliverNftClt<T0, T1>(arg5, arg0, *0x1::option::borrow<0x2::object::ID>(&v5), v9, v6, arg6, arg7);
            deposit_balance<T1>(arg5, v8);
        };
        if (0x1::option::is_some<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::ExpiredBill>(&arg2)) {
            let v10 = 0x1::option::extract<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::ExpiredBill>(&mut arg2);
            let (v11, v12, v13, v14) = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::expired_info(&v10);
            let v15 = v14;
            if (v11) {
                let v16 = balance_vault<T1>(arg5);
                refund_token<T1>(arg0, v16, v13, v12, arg7);
            } else {
                let v17 = pkiosk_mut(arg5);
                0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::delistAndTake<T0, T1>(v17, *0x1::option::borrow<0x2::object::ID>(&v15), arg6, arg7);
            };
        };
        if (arg4 > 0) {
            let v18 = balance_vault<T1>(arg5);
            refund_token<T1>(arg0, v18, arg4, arg3, arg7);
        };
    }

    fun deposit_balance<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut balance_vault<T0>(arg0).balance, arg1);
    }

    fun deposit_coin<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut balance_vault<T0>(arg0).balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun deposit_token<T0>(arg0: &mut Market, arg1: 0x2::token::Token<T0>, arg2: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::to_coin<T0>(arg1, arg3);
        0x2::balance::join<T0>(&mut balance_vault<T0>(arg0).balance, 0x2::coin::into_balance<T0>(v0));
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::borrowMutTreasure<T0>(arg2), v1, arg3);
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MarketAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MarketTreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MarketTreasureCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun orderbook(arg0: &mut Market) : &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Book {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Book>(&mut arg0.id, 0x1::type_name::get<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::Book>())
    }

    fun pair<T0: store + key, T1>() : Pair {
        Pair{
            nft   : 0x1::type_name::get<T0>(),
            token : 0x1::type_name::get<T1>(),
        }
    }

    fun pkiosk_mut(arg0: &mut Market) : &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::PublicKiosk {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::PublicKiosk>(&mut arg0.id, 0x1::type_name::get<0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::PublicKiosk>())
    }

    fun refund_coin<T0>(arg0: &mut BalanceManager<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
    }

    fun refund_token<T0>(arg0: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T0>, arg1: &mut BalanceManager<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg4);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::borrowMutTreasure<T0>(arg0), v1, arg4);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::borrowMutTreasure<T0>(arg0), 0x2::token::transfer<T0>(v0, arg3, arg4), arg4);
    }

    public fun sell_flash<T0: store + key, T1>(arg0: &mut Market, arg1: T0, arg2: &0x2::clock::Clock, arg3: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg4: &mut 0x2::tx_context::TxContext) : u128 {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg3, 1);
        validateMarket<T0, T1>(arg0, true);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = pkiosk_mut(arg0);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::placeAndList<T0, T1>(v2, arg1, 0, arg3, arg4);
        let v3 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg4), 1, false, 0x1::option::some<0x2::object::ID>(v0), 0, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ord_market(), 0, v1 + 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ten_days_ms(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::atomic());
        let v4 = orderbook(arg0);
        let v5 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::place_order(v4, &mut v3, v1);
        let v6 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_id(&v5);
        let v7 = pkiosk_mut(arg0);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::bindOrderId(v7, v0, v6);
        deliver<T0, T1>(v5, arg0, arg3, arg4);
        v6
    }

    public fun sell_flash_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, false);
        let v0 = 0x2::object::id<T0>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = pkiosk_mut(arg0);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::placeAndList<T0, T1>(v2, arg2, 0, arg4, arg5);
        let v3 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), 1, false, 0x1::option::some<0x2::object::ID>(v0), 0, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ord_market(), 0, v1 + 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ten_days_ms(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::atomic());
        let v4 = orderbook(arg0);
        let v5 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::place_order(v4, &mut v3, v1);
        let v6 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_id(&v5);
        let v7 = pkiosk_mut(arg0);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::bindOrderId(v7, v0, v6);
        deliver_clt<T0, T1>(v5, arg0, arg1, arg4, arg5);
        v6
    }

    public fun sell_limit<T0: store + key, T1>(arg0: &mut Market, arg1: T0, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, true);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = config(arg0);
        let v3 = arg2 - arg2 % v2.tick_size;
        let v4 = pkiosk_mut(arg0);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::placeAndList<T0, T1>(v4, arg1, v3, arg4, arg5);
        let v5 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), 1, false, 0x1::option::some<0x2::object::ID>(v0), v3, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ord_limit(), 0, v1 + 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ten_days_ms(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::atomic());
        let v6 = orderbook(arg0);
        let v7 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::place_order(v6, &mut v5, v1);
        let v8 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_id(&v7);
        let v9 = pkiosk_mut(arg0);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::bindOrderId(v9, v0, v8);
        deliver<T0, T1>(v7, arg0, arg4, arg5);
        v8
    }

    public fun sell_limit_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(arg0, false);
        let v0 = 0x2::object::id<T0>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = config(arg0);
        let v3 = arg3 - arg3 % v2.tick_size;
        let v4 = pkiosk_mut(arg0);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::placeAndList<T0, T1>(v4, arg2, v3, arg5, arg6);
        let v5 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), 1, false, 0x1::option::some<0x2::object::ID>(v0), v3, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ord_limit(), 0, v1 + 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::ten_days_ms(), 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::constants::atomic());
        let v6 = orderbook(arg0);
        let v7 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::place_order(v6, &mut v5, v1);
        let v8 = 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::book::order_id(&v7);
        let v9 = pkiosk_mut(arg0);
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::bindOrderId(v9, v0, v8);
        deliver_clt<T0, T1>(v7, arg0, arg1, arg5, arg6);
        v8
    }

    public fun sweep<T0: store + key, T1>(arg0: &mut Market, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, true);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v0);
            let v2 = pkiosk_mut(arg0);
            let v3 = 0x2::coin::split<T1>(arg2, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::orderPrice(v2, v1), arg5);
            buy_cross<T0, T1>(arg0, v3, v1, arg3, arg4, arg5);
        };
    }

    public fun sweep_clt<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::xbird::PegVault<T1>, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::token::Token<T1>, arg4: &0x2::clock::Clock, arg5: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(arg0, false);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg2);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            let v2 = pkiosk_mut(arg0);
            let v3 = 0x2::token::split<T1>(arg3, 0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::public_kiosk::orderPrice(v2, v1), arg6);
            buy_cross_clt<T0, T1>(arg0, arg1, v3, v1, arg4, arg5, arg6);
        };
    }

    fun transferPolicy<T0>(arg0: &mut Market) : &mut 0x2::transfer_policy::TransferPolicy<T0> {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<T0>>(&mut arg0.id, 0x1::type_name::get<0x2::transfer_policy::TransferPolicy<T0>>())
    }

    fun validateMarket<T0: store + key, T1>(arg0: &Market, arg1: bool) {
        assert!(arg0.pair == pair<T0, T1>(), 6001);
        assert!(arg0.coin_or_clt == arg1, 6004);
    }

    fun validateMarket0<T0: store + key, T1>(arg0: &Market) {
        assert!(arg0.pair == pair<T0, T1>(), 6001);
    }

    public fun withdraw_fee<T0: store + key, T1>(arg0: &MarketTreasureCap, arg1: &mut Market, arg2: &0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::Version) : 0x2::balance::Balance<T1> {
        0x27a4934ecf9206b541318848a616440e0c31c9f297bc130f80d24db22eaf838b::version::checkVersion(arg2, 1);
        assert!(pair<T0, T1>() == arg1.pair, 6001);
        let v0 = &mut balance_vault<T1>(arg1).fee;
        0x2::balance::split<T1>(v0, 0x2::balance::value<T1>(v0))
    }

    // decompiled from Move bytecode v6
}

