module 0xe23548a003a3a63eb68b190764d17bdf46d0691d2438c644aacaf157b82fcd0f::pump_fun {
    struct TokenInfo has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<PUMP_FUN>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
    }

    struct PUMP_FUN has drop {
        dummy_field: bool,
    }

    entry fun buy_token(arg0: &mut TokenInfo, arg1: &0xe23548a003a3a63eb68b190764d17bdf46d0691d2438c644aacaf157b82fcd0f::config::FeeConfig, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg3, 0);
        let v0 = arg3 * 0xe23548a003a3a63eb68b190764d17bdf46d0691d2438c644aacaf157b82fcd0f::config::fee_rate(arg1) / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP_FUN>>(0x2::coin::take<PUMP_FUN>(&mut arg0.balance, 0xe23548a003a3a63eb68b190764d17bdf46d0691d2438c644aacaf157b82fcd0f::math::calculate_buy_amount(1000000000000000000 - 0x2::balance::value<PUMP_FUN>(&arg0.balance), arg3 - v0), arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v0, arg7), 0xe23548a003a3a63eb68b190764d17bdf46d0691d2438c644aacaf157b82fcd0f::config::fee_recipient(arg1));
        let v1 = 0x2::coin::from_balance<PUMP_FUN>(0x2::balance::split<PUMP_FUN>(&mut arg0.balance, 1), arg7);
        let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 1), arg7);
        create_pool(arg4, arg5, v1, v2, arg6, arg7);
    }

    fun create_pool(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x2::coin::Coin<PUMP_FUN>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::create_pool_with_liquidity<PUMP_FUN, 0x2::sui::SUI>(arg0, arg1, 2, 18446744073, 0x1::string::utf8(b""), 4294523660, 443636, arg2, arg3, 1, 1, true, arg4, arg5);
        let v3 = v2;
        let v4 = v1;
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, 0x2::tx_context::sender(arg5));
        if (0x2::coin::value<PUMP_FUN>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<PUMP_FUN>>(v4, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<PUMP_FUN>(v4);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
        };
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

    entry fun sell_token(arg0: &mut TokenInfo, arg1: &0xe23548a003a3a63eb68b190764d17bdf46d0691d2438c644aacaf157b82fcd0f::config::FeeConfig, arg2: &mut 0x2::coin::Coin<PUMP_FUN>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<PUMP_FUN>(arg2) >= arg3, 0);
        let v0 = 0xe23548a003a3a63eb68b190764d17bdf46d0691d2438c644aacaf157b82fcd0f::math::calculate_sell_amount(1000000000000000000 - 0x2::balance::value<PUMP_FUN>(&arg0.balance), arg3);
        let v1 = v0 * 0xe23548a003a3a63eb68b190764d17bdf46d0691d2438c644aacaf157b82fcd0f::config::fee_rate(arg1) / 100;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= v0, 1);
        0x2::balance::join<PUMP_FUN>(&mut arg0.balance, 0x2::balance::split<PUMP_FUN>(0x2::coin::balance_mut<PUMP_FUN>(arg2), arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v0 - v1, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v1, arg4), 0xe23548a003a3a63eb68b190764d17bdf46d0691d2438c644aacaf157b82fcd0f::config::fee_recipient(arg1));
    }

    // decompiled from Move bytecode v6
}

