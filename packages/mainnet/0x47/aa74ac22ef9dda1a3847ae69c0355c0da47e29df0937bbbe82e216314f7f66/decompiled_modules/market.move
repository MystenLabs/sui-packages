module 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct Pair has copy, drop, store {
        nft: 0x1::type_name::TypeName,
        token: 0x1::type_name::TypeName,
    }

    struct Config has store {
        tick_size: u64,
        base_fee: u64,
        royal_fee: u64,
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
    }

    struct BalanceManager<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T0>,
        royal_fee: 0x2::balance::Balance<T0>,
    }

    struct MarketCreated has copy, drop, store {
        id: 0x2::object::ID,
        bid: 0x1::ascii::String,
        ask: 0x1::ascii::String,
        tick_size: u64,
        min_size: u64,
        base_fee: u64,
        max_order: u64,
        allow_self_match: bool,
        filter_type: 0x1::option::Option<u16>,
        filter_sub_type: 0x1::option::Option<u16>,
    }

    fun balance_vault<T0>(arg0: &mut Market) : &mut BalanceManager<T0> {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, BalanceManager<T0>>(&mut arg0.id, 0x1::type_name::get<BalanceManager<T0>>())
    }

    public(friend) fun buy_cross<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(true, arg0);
        let v0 = orderbook_mut(arg0);
        let (v1, _, v3, v4, v5) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::order_info(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::order(v0, arg2));
        assert!(v3 > 0 && !v1, 6011);
        let v6 = 0x2::coin::value<T1>(&arg1);
        assert!(v6 >= v5, 6005);
        let v7 = 0x2::clock::timestamp_ms(arg3);
        let v8 = orderbook_mut(arg0);
        assert!(!0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::order_expired(v8, arg2, v7), 6006);
        deposit_coin<T1>(arg0, arg1);
        let v9 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), v6, true, v4, 0, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::ord_cross(), arg2, 0, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::ice_berge());
        let v10 = orderbook_mut(arg0);
        let (v11, v12, v13, v14) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::place_cross(v10, &v9, v7);
        deliver_cross<T0, T1>(v11, v12, v13, v14, arg0, arg4, arg5);
    }

    public(friend) fun buy_flash<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg4: &mut 0x2::tx_context::TxContext) : u128 {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg3, 1);
        validateMarket<T0, T1>(true, arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 6003);
        deposit_coin<T1>(arg0, arg1);
        let v1 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg4), v0, true, 0x1::option::none<0x2::object::ID>(), 0, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::ord_market(), 0, 0, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::ice_berge());
        let v2 = orderbook_mut(arg0);
        deliver<T0, T1>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::place_order(v2, &v1, 0x2::clock::timestamp_ms(arg2)), arg0, arg3, arg4)
    }

    public(friend) fun buy_limit<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(false, arg0);
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::validate_offer_price(orderbook(arg0), arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let v2 = config_mut(arg0);
        let v3 = arg2 - arg2 % v2.tick_size;
        let v4 = if (arg3 > 0) {
            v0 + 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::one_hour_ms() * arg3
        } else {
            0
        };
        assert!(v3 > 0 && v1 >= v3, 6003);
        deposit_coin<T1>(arg0, arg1);
        let v5 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), v1, true, 0x1::option::none<0x2::object::ID>(), v3, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::ord_limit(), 0, v4, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::ice_berge());
        let v6 = orderbook_mut(arg0);
        deliver<T0, T1>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::place_order(v6, &v5, v0), arg0, arg5, arg6)
    }

    public(friend) fun cancel_buy<T0: store + key, T1>(arg0: &mut Market, arg1: vector<u128>, arg2: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg2, 1);
        validateMarket0<T0, T1>(arg0);
        let v0 = 0x1::vector::length<u128>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<u128>(&arg1, v0);
            let v2 = orderbook_mut(arg0);
            let (v3, v4, _, _, _) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::order_info(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::order(v2, v1));
            assert!(v4 == 0x2::tx_context::sender(arg3) && v3, 6003);
            let v8 = orderbook_mut(arg0);
            let v9 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::cancel_order(v8, v1);
            let v10 = balance_vault<T1>(arg0);
            let v11 = 0x2::tx_context::sender(arg3);
            refund_coin<T1>(v10, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::remain_balance(&v9), v11, arg3);
        };
    }

    public(friend) fun cancel_sell<T0: store + key, T1>(arg0: &mut Market, arg1: vector<u128>, arg2: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg3: &0x2::tx_context::TxContext) {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg2, 1);
        validateMarket0<T0, T1>(arg0);
        let v0 = 0x1::vector::length<u128>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = orderbook_mut(arg0);
            let v2 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::cancel_order(v1, 0x1::vector::pop_back<u128>(&mut arg1));
            let (v3, v4, _, v6, _) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::order_info(&v2);
            let v8 = v6;
            assert!(v4 == 0x2::tx_context::sender(arg3), 6007);
            assert!(!v3 && 0x1::option::is_some<0x2::object::ID>(&v8), 6003);
            0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::take<T0>(pkiosk_mut(arg0), 0x1::option::extract<0x2::object::ID>(&mut v8), v4, arg2);
        };
    }

    fun config_mut(arg0: &mut Market) : &mut Config {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Config>(&mut arg0.id, 0x1::type_name::get<Config>())
    }

    public(friend) fun createMarket<T0: store + key, T1>(arg0: &MarketAdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u16>, arg9: 0x1::option::Option<u16>, arg10: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg11: &mut 0x2::tx_context::TxContext) : Market {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg10, 1);
        assert!(arg1 > 0 && arg2 > 0 && arg3 <= 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::max_fee() && arg5 > 0 && arg6 <= 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::max_fee(), 6009);
        let v0 = pair<T0, T1>();
        let v1 = Market{
            id   : 0x2::object::new(arg11),
            pair : v0,
        };
        let v2 = 0x2::object::id<Market>(&v1);
        let v3 = BalanceManager<T1>{
            balance   : 0x2::balance::zero<T1>(),
            fee       : 0x2::balance::zero<T1>(),
            royal_fee : 0x2::balance::zero<T1>(),
        };
        let v4 = Config{
            tick_size : arg1,
            base_fee  : arg3,
            royal_fee : arg4,
        };
        let v5 = MarketCreated{
            id               : v2,
            bid              : 0x1::type_name::into_string(v0.token),
            ask              : 0x1::type_name::into_string(v0.nft),
            tick_size        : arg1,
            min_size         : arg2,
            base_fee         : arg3,
            max_order        : arg5,
            allow_self_match : arg7,
            filter_type      : arg8,
            filter_sub_type  : arg9,
        };
        0x2::event::emit<MarketCreated>(v5);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Book>(&mut v1.id, 0x1::type_name::get<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Book>(), 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::empty(v2, arg3, arg1, arg2, arg5, arg6, arg7, arg11));
        0x2::dynamic_field::add<0x1::type_name::TypeName, BalanceManager<T1>>(&mut v1.id, 0x1::type_name::get<BalanceManager<T1>>(), v3);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::PublicKiosk>(&mut v1.id, 0x1::type_name::get<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::PublicKiosk>(), 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::create(arg10, arg11));
        0x2::dynamic_field::add<0x1::type_name::TypeName, Config>(&mut v1.id, 0x1::type_name::get<Config>(), v4);
        0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::createVault<MarketAdminCap>(arg11);
        0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::createVault<MarketTreasureCap>(arg11);
        v1
    }

    fun deliver<T0: store + key, T1>(arg0: 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::TradeProof, arg1: &mut Market, arg2: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u128 {
        let (v0, v1) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::bill_info(&arg0);
        let v2 = 0x1::vector::length<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Bill>(v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            let v3 = 0x1::vector::borrow<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Bill>(v0, v2);
            let (v4, v5, v6, v7, v8, v9) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::fill_info(v3);
            let v10 = if (v4) {
                v6
            } else {
                v5
            };
            let v11 = if (v4) {
                v5
            } else {
                v6
            };
            let (v12, v13) = deliverNft<T0, T1>(arg1, v9, v8, v7, v10, v11, arg2, arg3);
            0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::make_and_fire_event_filled(0x2::object::id<Market>(arg1), v3, v12, v13);
        };
        let v14 = 0x1::vector::length<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::ExpiredBill>(v1);
        while (v14 > 0) {
            v14 = v14 - 1;
            let (v15, v16, v17, v18) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::expired_info(0x1::vector::borrow<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::ExpiredBill>(v1, v14));
            let v19 = v18;
            if (v15) {
                let v20 = balance_vault<T1>(arg1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v20.balance, v17), arg3), v16);
                continue
            };
            let v21 = pkiosk_mut(arg1);
            0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::take<T0>(v21, *0x1::option::borrow<0x2::object::ID>(&v19), v16, arg2);
        };
        let (v22, _, v24, v25, v26, v27) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::trade_info(&arg0);
        let v28 = v27;
        if (!v24) {
            if (v26) {
                if (v25 > 0) {
                    let v29 = balance_vault<T1>(arg1);
                    refund_coin<T1>(v29, v25, v22, arg3);
                };
            } else if (v25 > 0) {
                0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::take<T0>(pkiosk_mut(arg1), *0x1::option::borrow<0x2::object::ID>(&v28), v22, arg2);
            };
        };
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::confirm_proof(arg0)
    }

    fun deliverNft<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = balance_vault<T1>(arg0);
        let v1 = 0x2::balance::split<T1>(&mut v0.balance, arg3);
        let v2 = pkiosk_mut(arg0);
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::take<T0>(v2, arg1, arg4, arg6);
        pay<T1>(arg0, arg2, arg5, v1, arg7)
    }

    fun deliver_cross<T0: store + key, T1>(arg0: 0x1::option::Option<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Bill>, arg1: 0x1::option::Option<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::ExpiredBill>, arg2: address, arg3: u64, arg4: &mut Market, arg5: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Bill>(&arg0)) {
            let v0 = 0x1::option::extract<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Bill>(&mut arg0);
            let v1 = &v0;
            let (v2, v3, v4, v5, v6, v7) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::fill_info(v1);
            let v8 = if (v2) {
                v4
            } else {
                v3
            };
            let v9 = if (v2) {
                v3
            } else {
                v4
            };
            let (v10, v11) = deliverNft<T0, T1>(arg4, v7, v6, v5, v8, v9, arg5, arg6);
            0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::make_and_fire_event_filled(0x2::object::id<Market>(arg4), v1, v10, v11);
        };
        if (0x1::option::is_some<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::ExpiredBill>(&arg1)) {
            let v12 = 0x1::option::extract<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::ExpiredBill>(&mut arg1);
            let (v13, v14, v15, v16) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::expired_info(&v12);
            let v17 = v16;
            if (v13) {
                let v18 = balance_vault<T1>(arg4);
                refund_coin<T1>(v18, v15, v14, arg6);
            } else {
                let v19 = pkiosk_mut(arg4);
                0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::take<T0>(v19, *0x1::option::borrow<0x2::object::ID>(&v17), v14, arg5);
            };
        };
        if (arg3 > 0) {
            let v20 = balance_vault<T1>(arg4);
            refund_coin<T1>(v20, arg3, arg2, arg6);
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

    public(friend) fun market_id(arg0: &Market) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun market_id_mut(arg0: &mut Market) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun orderbook(arg0: &Market) : &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Book {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Book>(&arg0.id, 0x1::type_name::get<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Book>())
    }

    fun orderbook_mut(arg0: &mut Market) : &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Book {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Book>(&mut arg0.id, 0x1::type_name::get<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::Book>())
    }

    fun pair<T0: store + key, T1>() : Pair {
        Pair{
            nft   : 0x1::type_name::get<T0>(),
            token : 0x1::type_name::get<T1>(),
        }
    }

    public(friend) fun pay<T0>(arg0: &mut Market, arg1: u64, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg1 == 0 || arg1 <= 0x2::balance::value<T0>(&arg3), 6005);
        let v0 = config_mut(arg0);
        let v1 = v0.royal_fee;
        let v2 = config_mut(arg0);
        let v3 = if (arg1 == 0) {
            0x2::balance::value<T0>(&arg3)
        } else {
            arg1
        };
        let v4 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::max_fee();
        let v5 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::math::div(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::math::mul(v3, v2.base_fee), v4);
        let v6 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::math::div(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::math::mul(v3, v1), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3, v3 - v5 - v6), arg4), arg2);
        let v7 = balance_vault<T0>(arg0);
        if (v6 > 0) {
            0x2::balance::join<T0>(&mut v7.royal_fee, 0x2::balance::split<T0>(&mut arg3, v6));
        };
        if (v5 > 0) {
            0x2::balance::join<T0>(&mut v7.fee, 0x2::balance::split<T0>(&mut arg3, v5));
        };
        deposit_balance<T0>(arg0, arg3);
        (v5, v6)
    }

    fun pkiosk_mut(arg0: &mut Market) : &mut 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::PublicKiosk {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::PublicKiosk>(&mut arg0.id, 0x1::type_name::get<0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::PublicKiosk>())
    }

    fun refund_coin<T0>(arg0: &mut BalanceManager<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
    }

    public(friend) fun sell_flash<T0: store + key, T1>(arg0: &mut Market, arg1: T0, arg2: &0x2::clock::Clock, arg3: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg4: &mut 0x2::tx_context::TxContext) : u128 {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg3, 1);
        validateMarket<T0, T1>(false, arg0);
        let v0 = pkiosk_mut(arg0);
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::place<T0>(v0, arg1, arg3);
        let v1 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg4), 1, false, 0x1::option::some<0x2::object::ID>(0x2::object::id<T0>(&arg1)), 0, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::ord_market(), 0, 0, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::atomic());
        let v2 = orderbook_mut(arg0);
        deliver<T0, T1>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::place_order(v2, &v1, 0x2::clock::timestamp_ms(arg2)), arg0, arg3, arg4)
    }

    public(friend) fun sell_limit<T0: store + key, T1>(arg0: &mut Market, arg1: T0, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg5, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        validateMarket<T0, T1>(false, arg0);
        let v1 = config_mut(arg0);
        let v2 = arg2 - arg2 % v1.tick_size;
        let v3 = if (arg3 > 0) {
            v0 + 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::one_hour_ms() * arg3
        } else {
            0
        };
        let v4 = pkiosk_mut(arg0);
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::public_kiosk::place<T0>(v4, arg1, arg5);
        let v5 = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), 1, false, 0x1::option::some<0x2::object::ID>(0x2::object::id<T0>(&arg1)), v2, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::ord_limit(), 0, v3, 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::constants::atomic());
        let v6 = orderbook_mut(arg0);
        deliver<T0, T1>(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::place_order(v6, &v5, v0), arg0, arg5, arg6)
    }

    public(friend) fun sweep<T0: store + key, T1>(arg0: &mut Market, arg1: vector<u128>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(true, arg0);
        let v0 = 0x1::vector::length<u128>(&arg1);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = *0x1::vector::borrow<u128>(&arg1, v0);
            let (v2, _, _, v5, v6) = 0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::order_info(0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::order(orderbook(arg0), v1));
            let v7 = v5;
            assert!(!v2 && 0x1::option::is_some<0x2::object::ID>(&v7), 6003);
            let v8 = 0x2::coin::split<T1>(arg2, v6, arg5);
            buy_cross<T0, T1>(arg0, v8, v1, arg3, arg4, arg5);
        };
    }

    fun validateMarket<T0: store + key, T1>(arg0: bool, arg1: &Market) {
        assert!(arg1.pair == pair<T0, T1>(), 6001);
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::book::validate_max_order(orderbook(arg1), arg0);
    }

    fun validateMarket0<T0: store + key, T1>(arg0: &Market) {
        assert!(arg0.pair == pair<T0, T1>(), 6001);
    }

    public(friend) fun withdraw_fee<T0: store + key, T1>(arg0: &MarketTreasureCap, arg1: &mut Market, arg2: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version) : 0x2::balance::Balance<T1> {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg2, 1);
        assert!(pair<T0, T1>() == arg1.pair, 6001);
        let v0 = &mut balance_vault<T1>(arg1).fee;
        0x2::balance::split<T1>(v0, 0x2::balance::value<T1>(v0))
    }

    public(friend) fun withdraw_royal_fee<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: &mut Market, arg2: &0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::Version) : 0x2::balance::Balance<T1> {
        0x47aa74ac22ef9dda1a3847ae69c0355c0da47e29df0937bbbe82e216314f7f66::version::checkVersion(arg2, 1);
        assert!(pair<T0, T1>() == arg1.pair, 6001);
        assert!(0x2::package::from_module<T0>(arg0), 6012);
        let v0 = &mut balance_vault<T1>(arg1).royal_fee;
        0x2::balance::split<T1>(v0, 0x2::balance::value<T1>(v0))
    }

    // decompiled from Move bytecode v6
}

