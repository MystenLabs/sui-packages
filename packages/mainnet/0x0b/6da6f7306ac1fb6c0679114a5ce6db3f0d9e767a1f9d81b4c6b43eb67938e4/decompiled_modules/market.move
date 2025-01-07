module 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::market {
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
        taker_fee: u64,
        maker_fee: u64,
        allow_self_match: bool,
    }

    struct MarketAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        pair: Pair,
        coin_clt: u8,
    }

    struct BalanceManager<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T0>,
    }

    struct MarketCreated has copy, drop, store {
        id: 0x2::object::ID,
        bid: 0x1::type_name::TypeName,
        ask: 0x1::type_name::TypeName,
        pay_coin: bool,
        tick_size: u64,
        min_size: u64,
        taker_fee: u64,
        maker_fee: u64,
        allow_self_match: bool,
        policy: address,
    }

    fun balance_to_token<T0>(arg0: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, arg2), arg4), arg4);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::borrowMutTreasure<T0>(arg0), v1, arg4);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::borrowMutTreasure<T0>(arg0), 0x2::token::transfer<T0>(v0, arg3, arg4), arg4);
    }

    fun balance_vault<T0>(arg0: &mut Market) : &mut BalanceManager<T0> {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, BalanceManager<T0>>(&mut arg0.id, 0x1::type_name::get<BalanceManager<T0>>())
    }

    fun buyNftInt<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<T1>, arg3: address, arg4: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg5: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = pkiosk_mut(arg0);
        let (v1, v2, v3) = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::purchase<T0, T1>(v0, arg1, arg4, arg5);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        assert!(0x2::object::id<T0>(&v6) == 0x2::transfer_policy::item<T0>(&v5), 6002);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::payment_policy::payByCoin<T0, T1>(&mut v5, &v4, arg2, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(transferPolicy<T0>(arg0), v5);
        0x2::transfer::public_transfer<T0>(v6, arg3);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::orderId(&v4)
    }

    fun buyNftInt2<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::token::Token<T1>, arg4: address, arg5: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = pkiosk_mut(arg0);
        let (v1, v2, v3) = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::purchase<T0, T1>(v0, arg2, arg5, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        assert!(0x2::object::id<T0>(&v6) == 0x2::transfer_policy::item<T0>(&v5), 6002);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::payment_policy::payByToken<T0, T1>(arg1, &mut v5, &v4, arg3, arg6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(transferPolicy<T0>(arg0), v5);
        0x2::transfer::public_transfer<T0>(v6, arg4);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::orderId(&v4)
    }

    public entry fun buy_limit<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, 0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let v2 = config(arg0);
        let v3 = arg2 - arg2 % v2.tick_size;
        assert!(v3 > 0 && v1 >= v3, 6003);
        depositBalance<T1>(arg0, arg1);
        let v4 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), v1, true, 0x1::option::none<0x2::object::ID>(), v3, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ord_limit(), v0 + 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ten_days_ms(), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ice_berge());
        let v5 = orderbook(arg0);
        let v6 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::create_order(v5, &mut v4, v0);
        deliver<T0, T1>(&v6, arg0, arg4, arg5);
        refund<T0, T1>(&v6, arg0, arg4, arg5);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::confirm_proof(v6);
    }

    public entry fun buy_limit2<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg2: 0x2::token::Token<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(arg0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::token::value<T1>(&arg2);
        let v2 = config(arg0);
        let v3 = arg3 - arg3 % v2.tick_size;
        assert!(v3 > 0 && v1 >= v3, 6003);
        depositBalanceToken<T1>(arg0, arg2, arg1, arg6);
        let v4 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), v1, true, 0x1::option::none<0x2::object::ID>(), v3, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ord_limit(), v0 + 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ten_days_ms(), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ice_berge());
        let v5 = orderbook(arg0);
        let v6 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::create_order(v5, &mut v4, v0);
        deliver2<T0, T1>(&v6, arg0, arg1, arg5, arg6);
        refund2<T0, T1>(&v6, arg0, arg1, arg5, arg6);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::confirm_proof(v6);
    }

    public entry fun buy_market<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg3, 1);
        validateMarket<T0, T1>(arg0, 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v1 > 0, 6003);
        depositBalance<T1>(arg0, arg1);
        let v2 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg4), v1, true, 0x1::option::none<0x2::object::ID>(), 0, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ord_market(), v0 + 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ten_days_ms(), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ice_berge());
        let v3 = orderbook(arg0);
        let v4 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::create_order(v3, &mut v2, v0);
        deliver<T0, T1>(&v4, arg0, arg3, arg4);
        refund<T0, T1>(&v4, arg0, arg3, arg4);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::confirm_proof(v4);
    }

    public entry fun buy_market2<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg2: 0x2::token::Token<T1>, arg3: &0x2::clock::Clock, arg4: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::token::value<T1>(&arg2);
        assert!(v1 > 0, 6003);
        depositBalanceToken<T1>(arg0, arg2, arg1, arg5);
        let v2 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), v1, true, 0x1::option::none<0x2::object::ID>(), 0, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ord_market(), v0 + 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ten_days_ms(), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ice_berge());
        let v3 = orderbook(arg0);
        let v4 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::create_order(v3, &mut v2, v0);
        deliver2<T0, T1>(&v4, arg0, arg1, arg4, arg5);
        refund2<T0, T1>(&v4, arg0, arg1, arg4, arg5);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::confirm_proof(v4);
    }

    public entry fun buy_one<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg3, 1);
        validateMarket<T0, T1>(arg0, 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = buyNftInt<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::cancel_order(orderbook(arg0), v1, true);
    }

    public entry fun buy_one2<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::token::Token<T1>, arg4: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = buyNftInt2<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, arg5);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::cancel_order(orderbook(arg0), v1, true);
    }

    public entry fun buy_sweep<T0: store + key, T1>(arg0: &mut Market, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg3, 1);
        validateMarket<T0, T1>(arg0, 0);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg1) - 1;
        while (v0 >= 0) {
            buy_one<T0, T1>(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v0), arg2, arg3, arg4);
        };
    }

    public entry fun buy_sweep2<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::token::Token<T1>, arg4: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, 1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg2) - 1;
        while (v0 >= 0) {
            buy_one2<T0, T1>(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&arg2, v0), arg3, arg4, arg5);
        };
    }

    public entry fun cancel_buy<T0: store + key, T1>(arg0: &mut Market, arg1: u128, arg2: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg2, 1);
        validateMarket<T0, T1>(arg0, 0);
        let v0 = orderbook(arg0);
        assert!(0x2::tx_context::sender(arg3) == 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::owner(v0, arg1), 6004);
        let v1 = orderbook(arg0);
        let v2 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::cancel_order(v1, arg1, false);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut balance_vault<T1>(arg0).balance, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::remain_balance(&v2)), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun cancel_buy2<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg2: u128, arg3: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg3, 1);
        validateMarket<T0, T1>(arg0, 1);
        let v0 = orderbook(arg0);
        assert!(0x2::tx_context::sender(arg4) == 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::owner(v0, arg2), 6004);
        let v1 = orderbook(arg0);
        let v2 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::cancel_order(v1, arg2, false);
        let v3 = &mut balance_vault<T1>(arg0).balance;
        let v4 = 0x2::tx_context::sender(arg4);
        balance_to_token<T1>(arg1, v3, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::remain_balance(&v2), v4, arg4);
    }

    public entry fun cancel_sell<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::object::ID, arg2: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg2, 1);
        validateMarket<T0, T1>(arg0, 0);
        let v0 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::cancel_order(orderbook(arg0), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::delistAndTake<T0, T1>(v0, arg1, arg2, arg3), false);
    }

    fun config(arg0: &mut Market) : &mut Config {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Config>(&mut arg0.id, 0x1::type_name::get<Config>())
    }

    fun confirmTokenReq<T0>(arg0: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T0>, arg1: 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::borrowMutTreasure<T0>(arg0), arg1, arg2);
    }

    public entry fun createMarket<T0: store + key, T1>(arg0: &MarketAdminCap, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: 0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::transfer_policy::TransferPolicyCap<T0>, arg9: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg9, 1);
        let v0 = getPair<T0, T1>();
        let v1 = if (arg1) {
            0
        } else {
            1
        };
        let v2 = Market{
            id       : 0x2::object::new(arg10),
            pair     : v0,
            coin_clt : v1,
        };
        let v3 = BalanceManager<T1>{
            balance : 0x2::balance::zero<T1>(),
            fee     : 0x2::balance::zero<T1>(),
        };
        let v4 = Config{
            tick_size        : arg2,
            min_size         : arg3,
            taker_fee        : arg4,
            maker_fee        : arg5,
            allow_self_match : arg6,
        };
        let v5 = MarketCreated{
            id               : 0x2::object::id<Market>(&v2),
            bid              : v0.token,
            ask              : v0.nft,
            pay_coin         : arg1,
            tick_size        : arg2,
            min_size         : arg3,
            taker_fee        : arg4,
            maker_fee        : arg5,
            allow_self_match : arg6,
            policy           : 0x2::object::id_address<0x2::transfer_policy::TransferPolicy<T0>>(&arg7),
        };
        0x2::event::emit<MarketCreated>(v5);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::Book>(&mut v2.id, 0x1::type_name::get<0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::Book>(), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::empty(arg4, arg5, arg2, arg3, arg10));
        0x2::dynamic_field::add<0x1::type_name::TypeName, BalanceManager<T1>>(&mut v2.id, 0x1::type_name::get<BalanceManager<T1>>(), v3);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<T0>>(&mut v2.id, 0x1::type_name::get<0x2::transfer_policy::TransferPolicy<T0>>(), arg7);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicyCap<T0>>(&mut v2.id, 0x1::type_name::get<0x2::transfer_policy::TransferPolicyCap<T0>>(), arg8);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::PublicKiosk>(&mut v2.id, 0x1::type_name::get<0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::PublicKiosk>(), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::createPublicKiosk<T0, T1>(arg9, arg10));
        0x2::dynamic_field::add<0x1::type_name::TypeName, Config>(&mut v2.id, 0x1::type_name::get<Config>(), v4);
        0x2::transfer::public_share_object<Market>(v2);
    }

    fun deliver<T0: store + key, T1>(arg0: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::TradeProof, arg1: &mut Market, arg2: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _) = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::bill_info(arg0);
        let v3 = 0x1::vector::length<0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::Fill>(v0) - 1;
        while (v3 >= 0) {
            let (v4, v5, v6, v7) = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::fill_info(0x1::vector::borrow<0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::Fill>(v0, v3));
            let v8 = if (v4) {
                0x2::tx_context::sender(arg3)
            } else {
                v5
            };
            let v9 = balance_vault<T1>(arg1);
            let v10 = 0x2::coin::take<T1>(&mut v9.balance, v6, arg3);
            let v11 = &mut v10;
            buyNftInt<T0, T1>(arg1, v7, v11, v8, arg2, arg3);
            depositBalance<T1>(arg1, v10);
            v3 = v3 - 1;
        };
    }

    fun deliver2<T0: store + key, T1>(arg0: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::TradeProof, arg1: &mut Market, arg2: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg3: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _) = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::bill_info(arg0);
        let v3 = 0x1::vector::length<0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::Fill>(v0) - 1;
        while (v3 >= 0) {
            let (v4, v5, v6, v7) = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::fill_info(0x1::vector::borrow<0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::Fill>(v0, v3));
            let v8 = if (v4) {
                0x2::tx_context::sender(arg4)
            } else {
                v5
            };
            let v9 = balance_vault<T1>(arg1);
            let (v10, v11) = 0x2::token::from_coin<T1>(0x2::coin::take<T1>(&mut v9.balance, v6, arg4), arg4);
            let v12 = v10;
            confirmTokenReq<T1>(arg2, v11, arg4);
            let v13 = &mut v12;
            buyNftInt2<T0, T1>(arg1, arg2, v7, v13, v8, arg3, arg4);
            depositBalanceToken<T1>(arg1, v12, arg2, arg4);
            v3 = v3 - 1;
        };
    }

    fun depositBalance<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut balance_vault<T0>(arg0).balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun depositBalanceToken<T0>(arg0: &mut Market, arg1: 0x2::token::Token<T0>, arg2: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::to_coin<T0>(arg1, arg3);
        0x2::balance::join<T0>(&mut balance_vault<T0>(arg0).balance, 0x2::coin::into_balance<T0>(v0));
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::borrowMutTreasure<T0>(arg2), v1, arg3);
    }

    fun getPair<T0: store + key, T1>() : Pair {
        Pair{
            nft   : 0x1::type_name::get<T0>(),
            token : 0x1::type_name::get<T1>(),
        }
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MarketAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = TreasureAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<TreasureAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun orderbook(arg0: &mut Market) : &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::Book {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::Book>(&mut arg0.id, 0x1::type_name::get<0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::Book>())
    }

    fun pkiosk_mut(arg0: &mut Market) : &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::PublicKiosk {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::PublicKiosk>(&mut arg0.id, 0x1::type_name::get<0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::PublicKiosk>())
    }

    fun refund<T0: store + key, T1>(arg0: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::TradeProof, arg1: &mut Market, arg2: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, _, v4, v5, v6, _) = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::trade_info(arg0);
        let v8 = v6;
        if (!v2) {
            if (v5) {
                if (v4 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut balance_vault<T1>(arg1).balance, v4), arg3), v0);
                };
            } else {
                0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg1), *0x1::option::borrow<0x2::object::ID>(&v8), arg2, arg3);
            };
        };
    }

    fun refund2<T0: store + key, T1>(arg0: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::TradeProof, arg1: &mut Market, arg2: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg3: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, _, v4, v5, v6, _) = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::trade_info(arg0);
        let v8 = v6;
        if (!v2) {
            if (v5) {
                if (v4 > 0) {
                    let v9 = &mut balance_vault<T1>(arg1).balance;
                    balance_to_token<T1>(arg2, v9, v4, v0, arg4);
                };
            } else {
                0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::delistAndTake<T0, T1>(pkiosk_mut(arg1), *0x1::option::borrow<0x2::object::ID>(&v8), arg3, arg4);
            };
        };
    }

    public entry fun sell_limit<T0: store + key, T1>(arg0: &mut Market, arg1: T0, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, 0);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = config(arg0);
        let v3 = arg2 - arg2 % v2.tick_size;
        let v4 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::placeAndList<T0, T1>(v4, arg1, v3, arg4, arg5);
        let v5 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), 1, false, 0x1::option::some<0x2::object::ID>(v0), v3, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ord_limit(), v1 + 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ten_days_ms(), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::atomic());
        let v6 = orderbook(arg0);
        let v7 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::create_order(v6, &mut v5, v1);
        let v8 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::bindOrderId(v8, v0, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::order_id(&v7));
        deliver<T0, T1>(&v7, arg0, arg4, arg5);
        refund<T0, T1>(&v7, arg0, arg4, arg5);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::confirm_proof(v7);
    }

    public entry fun sell_limit2<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg5, 1);
        validateMarket<T0, T1>(arg0, 1);
        let v0 = 0x2::object::id<T0>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = config(arg0);
        let v3 = arg3 - arg3 % v2.tick_size;
        let v4 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::placeAndList<T0, T1>(v4, arg2, v3, arg5, arg6);
        let v5 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg6), 1, false, 0x1::option::some<0x2::object::ID>(v0), v3, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ord_limit(), v1 + 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ten_days_ms(), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::atomic());
        let v6 = orderbook(arg0);
        let v7 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::create_order(v6, &mut v5, v1);
        let v8 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::bindOrderId(v8, v0, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::order_id(&v7));
        deliver2<T0, T1>(&v7, arg0, arg1, arg5, arg6);
        refund2<T0, T1>(&v7, arg0, arg1, arg5, arg6);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::confirm_proof(v7);
    }

    public entry fun sell_market<T0: store + key, T1>(arg0: &mut Market, arg1: T0, arg2: &0x2::clock::Clock, arg3: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg3, 1);
        validateMarket<T0, T1>(arg0, 0);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::placeAndList<T0, T1>(v2, arg1, 0, arg3, arg4);
        let v3 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg4), 1, false, 0x1::option::some<0x2::object::ID>(v0), 0, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ord_market(), v1 + 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ten_days_ms(), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::atomic());
        let v4 = orderbook(arg0);
        let v5 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::create_order(v4, &mut v3, v1);
        let v6 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::bindOrderId(v6, v0, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::order_id(&v5));
        deliver<T0, T1>(&v5, arg0, arg3, arg4);
        refund<T0, T1>(&v5, arg0, arg3, arg4);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::confirm_proof(v5);
    }

    public entry fun sell_market2<T0: store + key, T1>(arg0: &mut Market, arg1: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg2: T0, arg3: &0x2::clock::Clock, arg4: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg4, 1);
        validateMarket<T0, T1>(arg0, 1);
        let v0 = 0x2::object::id<T0>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::placeAndList<T0, T1>(v2, arg2, 0, arg4, arg5);
        let v3 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::make_order_info(0x2::object::id<Market>(arg0), 0x2::tx_context::sender(arg5), 1, false, 0x1::option::some<0x2::object::ID>(v0), 0, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ord_market(), v1 + 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::ten_days_ms(), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::constants::atomic());
        let v4 = orderbook(arg0);
        let v5 = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::create_order(v4, &mut v3, v1);
        let v6 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::bindOrderId(v6, v0, 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::order_id(&v5));
        deliver2<T0, T1>(&v5, arg0, arg1, arg4, arg5);
        refund2<T0, T1>(&v5, arg0, arg1, arg4, arg5);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::confirm_proof(v5);
    }

    fun transferPolicy<T0>(arg0: &mut Market) : &mut 0x2::transfer_policy::TransferPolicy<T0> {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<T0>>(&mut arg0.id, 0x1::type_name::get<0x2::transfer_policy::TransferPolicy<T0>>())
    }

    public entry fun updatePrice<T0: store + key, T1>(arg0: &mut Market, arg1: 0x2::object::ID, arg2: u64, arg3: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg3, 1);
        let v0 = config(arg0);
        let v1 = arg2 - arg2 % v0.tick_size;
        validateMarket<T0, T1>(arg0, 0);
        let v2 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::replace<T0, T1>(v2, arg1, v1, arg3, arg5);
        let v3 = pkiosk_mut(arg0);
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::book::modify_order_price(orderbook(arg0), 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::orderId2(v3, arg1), v1, 0x2::clock::timestamp_ms(arg4));
    }

    fun validateMarket<T0: store + key, T1>(arg0: &Market, arg1: u8) {
        assert!(arg0.pair == getPair<T0, T1>(), 6001);
        assert!(arg0.coin_clt == arg1, 6005);
    }

    // decompiled from Move bytecode v6
}

