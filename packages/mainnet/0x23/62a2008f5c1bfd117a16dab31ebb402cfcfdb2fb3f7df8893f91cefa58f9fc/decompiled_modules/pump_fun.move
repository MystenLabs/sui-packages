module 0x2362a2008f5c1bfd117a16dab31ebb402cfcfdb2fb3f7df8893f91cefa58f9fc::pump_fun {
    struct TokenInfo has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<PUMP_FUN>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
    }

    struct PUMP_FUN has drop {
        dummy_field: bool,
    }

    entry fun buy_token(arg0: &mut TokenInfo, arg1: &0x2362a2008f5c1bfd117a16dab31ebb402cfcfdb2fb3f7df8893f91cefa58f9fc::config::FeeConfig, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg3, 0);
        let v0 = arg3 * 0x2362a2008f5c1bfd117a16dab31ebb402cfcfdb2fb3f7df8893f91cefa58f9fc::config::fee_rate(arg1) / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP_FUN>>(0x2::coin::take<PUMP_FUN>(&mut arg0.balance, 0x2362a2008f5c1bfd117a16dab31ebb402cfcfdb2fb3f7df8893f91cefa58f9fc::math::calculate_buy_amount(1000000000000000000 - 0x2::balance::value<PUMP_FUN>(&arg0.balance), arg3 - v0), arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v0, arg4), 0x2362a2008f5c1bfd117a16dab31ebb402cfcfdb2fb3f7df8893f91cefa58f9fc::config::fee_recipient(arg1));
    }

    fun init(arg0: PUMP_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP_FUN>(arg0, 9, b"PUMP_FUN_1728620907", b"PFN", b"Pump Fun Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP_FUN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUMP_FUN>>(v2);
        let v3 = TokenInfo{
            id          : 0x2::object::new(arg1),
            balance     : 0x2::coin::into_balance<PUMP_FUN>(0x2::coin::mint<PUMP_FUN>(&mut v2, 1000000000000000000, arg1)),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            admin       : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<TokenInfo>(v3);
    }

    entry fun open_position_with_liquidity_with_all(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<PUMP_FUN, 0x2::sui::SUI>, arg2: &mut TokenInfo, arg3: u32, arg4: u32, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<PUMP_FUN, 0x2::sui::SUI>(arg0, arg1, arg3, arg4, arg9);
        let v1 = if (arg7) {
            arg5
        } else {
            arg6
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<PUMP_FUN, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::split<PUMP_FUN>(&mut arg2.balance, arg5), 0x2::balance::split<0x2::sui::SUI>(&mut arg2.sui_balance, arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<PUMP_FUN, 0x2::sui::SUI>(arg0, arg1, &mut v0, v1, arg7, arg8));
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, 0x2::tx_context::sender(arg9));
    }

    entry fun sell_token(arg0: &mut TokenInfo, arg1: &0x2362a2008f5c1bfd117a16dab31ebb402cfcfdb2fb3f7df8893f91cefa58f9fc::config::FeeConfig, arg2: &mut 0x2::coin::Coin<PUMP_FUN>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<PUMP_FUN>(arg2) >= arg3, 0);
        let v0 = 0x2362a2008f5c1bfd117a16dab31ebb402cfcfdb2fb3f7df8893f91cefa58f9fc::math::calculate_sell_amount(1000000000000000000 - 0x2::balance::value<PUMP_FUN>(&arg0.balance), arg3);
        let v1 = v0 * 0x2362a2008f5c1bfd117a16dab31ebb402cfcfdb2fb3f7df8893f91cefa58f9fc::config::fee_rate(arg1) / 100;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= v0, 1);
        0x2::balance::join<PUMP_FUN>(&mut arg0.balance, 0x2::balance::split<PUMP_FUN>(0x2::coin::balance_mut<PUMP_FUN>(arg2), arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v0 - v1, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v1, arg4), 0x2362a2008f5c1bfd117a16dab31ebb402cfcfdb2fb3f7df8893f91cefa58f9fc::config::fee_recipient(arg1));
    }

    // decompiled from Move bytecode v6
}

