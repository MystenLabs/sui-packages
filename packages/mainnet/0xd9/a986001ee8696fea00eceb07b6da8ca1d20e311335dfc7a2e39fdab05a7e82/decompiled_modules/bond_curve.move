module 0xd9a986001ee8696fea00eceb07b6da8ca1d20e311335dfc7a2e39fdab05a7e82::bond_curve {
    struct BOND_CURVE has drop {
        dummy_field: bool,
    }

    struct BondCurveAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TradeConfig has store, key {
        id: 0x2::object::UID,
        targetAmount: u128,
        tradeStep: u8,
        trade_A: u128,
        trade_fee_percent: u128,
        referrer_fee_percent: u128,
        initBuyValue: u128,
        intiBuyMaxPercent: u128,
    }

    struct BondCurveState has store, key {
        id: 0x2::object::UID,
        protocolReceiver: address,
        tradeFeeReceiver: address,
        dex_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        tradeConfig: TradeConfig,
        treasuryCap: 0x2::coin::TreasuryCap<BOND_CURVE>,
        totalBalance: 0x2::balance::Balance<BOND_CURVE>,
        totalMinted: u128,
        initialized: bool,
    }

    struct TradeStep has copy, drop {
        trade_step: u8,
        unix_timestamp: u64,
    }

    struct TradeInfo has copy, drop {
        referrer: address,
        referrer_amount: u64,
        up_referrer: address,
        up_referrer_amount: u64,
        fee_value: u64,
        remain_amount: u64,
    }

    struct Buy has copy, drop {
        sender: address,
        value: u64,
        tokenAmount: u128,
        lastTokenPrice: u128,
        trade_info: TradeInfo,
        unix_timestamp: u64,
    }

    struct Sell has copy, drop {
        sender: address,
        value: u64,
        tokenAmount: u128,
        lastTokenPrice: u128,
        trade_info: TradeInfo,
        unix_timestamp: u64,
    }

    fun addLiquidity(arg0: &mut BondCurveState, arg1: 0x2::coin::Coin<BOND_CURVE>, arg2: u128, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.tradeConfig.tradeStep == 2, 6);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.dex_sui), arg6);
        let (v1, v2, v3) = 0xd9a986001ee8696fea00eceb07b6da8ca1d20e311335dfc7a2e39fdab05a7e82::cetus_adapter::add_liquidity_simple<BOND_CURVE, 0x2::sui::SUI>(arg3, arg4, arg2, arg1, v0, 0x2::coin::value<BOND_CURVE>(&arg1), 0x2::coin::value<0x2::sui::SUI>(&v0), arg5, arg6);
        0x2::coin::burn<BOND_CURVE>(&mut arg0.treasuryCap, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, @0x0);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v1, @0x0);
    }

    public entry fun buy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut BondCurveState, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        buy_internal(arg0, arg1, arg2, arg3, arg4, v0, @0x0, arg5);
    }

    fun buy_internal(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut BondCurveState, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: address, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<0x2::sui::SUI>(&arg0) as u128);
        assert!(arg1.tradeConfig.tradeStep == 1, 6);
        assert!(v0 > 0, 0);
        let (v1, v2, v3, v4) = estimate_buy_result(v0, arg1);
        assert!(0 < v4 && v4 <= (0x2::balance::value<BOND_CURVE>(&arg1.totalBalance) as u128), 5);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.dex_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut v5, (v3 as u64), arg7)));
        0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v5, (v1 as u64), arg7), arg1.protocolReceiver);
        let v6 = if (arg6 != @0x0) {
            arg6
        } else {
            arg1.tradeFeeReceiver
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v5, (v2 as u64), arg7), v6);
        0xd9a986001ee8696fea00eceb07b6da8ca1d20e311335dfc7a2e39fdab05a7e82::converter::transfer<BOND_CURVE>(0xd9a986001ee8696fea00eceb07b6da8ca1d20e311335dfc7a2e39fdab05a7e82::converter::from_coin<BOND_CURVE>(0x2::coin::take<BOND_CURVE>(&mut arg1.totalBalance, (v4 as u64), arg7), &mut arg1.treasuryCap, arg7), &mut arg1.treasuryCap, arg5, arg7);
        let v7 = v3 * 1000000000 / v4;
        arg1.totalMinted = arg1.totalMinted + v4;
        let v8 = if ((0x2::balance::value<0x2::sui::SUI>(&arg1.dex_sui) as u128) >= arg1.tradeConfig.targetAmount) {
            arg1.tradeConfig.tradeStep = 2;
            let v9 = TradeStep{
                trade_step     : 2,
                unix_timestamp : 0x2::clock::timestamp_ms(arg4) / 1000,
            };
            0x2::event::emit<TradeStep>(v9);
            let v10 = (0x2::balance::value<0x2::sui::SUI>(&arg1.dex_sui) as u128);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.dex_sui, ((v10 * 5 / 100) as u64), arg7), arg1.protocolReceiver);
            let v11 = v10 * 1000000000 / v7;
            let v12 = 9850000000 * 1000000000 / init_buy_amount(1000000, arg1);
            if (v11 <= (0x2::balance::value<BOND_CURVE>(&arg1.totalBalance) as u128)) {
                0x2::coin::burn<BOND_CURVE>(&mut arg1.treasuryCap, 0x2::coin::take<BOND_CURVE>(&mut arg1.totalBalance, 0x2::balance::value<BOND_CURVE>(&arg1.totalBalance) - (v11 as u64), arg7));
            } else {
                0x2::balance::join<BOND_CURVE>(&mut arg1.totalBalance, 0x2::coin::mint_balance<BOND_CURVE>(&mut arg1.treasuryCap, ((v11 - (0x2::balance::value<BOND_CURVE>(&arg1.totalBalance) as u128)) as u64)));
            };
            let v13 = 0x2::coin::take<BOND_CURVE>(&mut arg1.totalBalance, (v11 as u64), arg7);
            addLiquidity(arg1, v13, v7, arg2, arg3, arg4, arg7);
            v12
        } else {
            9850000000 * 1000000000 / init_buy_amount(1000000, arg1)
        };
        let v14 = TradeInfo{
            referrer           : arg6,
            referrer_amount    : (v2 as u64),
            up_referrer        : @0x0,
            up_referrer_amount : 0,
            fee_value          : (v1 as u64),
            remain_amount      : (v3 as u64),
        };
        let v15 = Buy{
            sender         : arg5,
            value          : (v0 as u64),
            tokenAmount    : v4,
            lastTokenPrice : v8,
            trade_info     : v14,
            unix_timestamp : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<Buy>(v15);
    }

    public entry fun buy_refer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut BondCurveState, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &0x5b12ca89ae9c13cfc0d167a2e7da29e2bce5148b8350831045229c1960ffb871::referrerstorage::Referrer, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        buy_internal(arg0, arg1, arg2, arg3, arg4, v0, 0x5b12ca89ae9c13cfc0d167a2e7da29e2bce5148b8350831045229c1960ffb871::referrerstorage::referrer(arg5), arg6);
    }

    public fun estimate_buy_result(arg0: u128, arg1: &BondCurveState) : (u128, u128, u128, u128) {
        let v0 = arg0 * arg1.tradeConfig.trade_fee_percent / 1000;
        let v1 = arg0 * arg1.tradeConfig.referrer_fee_percent / 1000;
        let v2 = arg0 - v0 - v1;
        (v0, v1, v2, get_amount_out(v2, true, (0x2::balance::value<0x2::sui::SUI>(&arg1.dex_sui) as u128), (0x2::balance::value<BOND_CURVE>(&arg1.totalBalance) as u128), arg1.tradeConfig.trade_A))
    }

    public fun estimate_sell_result(arg0: u128, arg1: &BondCurveState) : (u128, u128, u128) {
        let v0 = get_amount_out(arg0, false, (0x2::balance::value<0x2::sui::SUI>(&arg1.dex_sui) as u128), (0x2::balance::value<BOND_CURVE>(&arg1.totalBalance) as u128), arg1.tradeConfig.trade_A);
        (v0 * arg1.tradeConfig.trade_fee_percent / 1000, v0 * arg1.tradeConfig.referrer_fee_percent / 1000, v0 * (1000 - arg1.tradeConfig.trade_fee_percent - arg1.tradeConfig.referrer_fee_percent) / 1000)
    }

    public fun get_amount_out(arg0: u128, arg1: bool, arg2: u128, arg3: u128, arg4: u128) : u128 {
        if (arg1) {
            return arg0 * arg3 / (arg2 + arg0 + arg4)
        };
        arg0 * (arg2 + arg4) / (arg3 + arg0)
    }

    fun init(arg0: BOND_CURVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BondCurveAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BondCurveAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<BOND_CURVE>(arg0, 9, b"", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        let v4 = TradeConfig{
            id                   : 0x2::object::new(arg1),
            targetAmount         : 0,
            tradeStep            : 0,
            trade_A              : 0,
            trade_fee_percent    : 0,
            referrer_fee_percent : 0,
            initBuyValue         : 0,
            intiBuyMaxPercent    : 0,
        };
        let v5 = BondCurveState{
            id               : 0x2::object::new(arg1),
            protocolReceiver : @0x0,
            tradeFeeReceiver : @0x0,
            dex_sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            tradeConfig      : v4,
            treasuryCap      : v3,
            totalBalance     : 0x2::coin::mint_balance<BOND_CURVE>(&mut v3, 1000000000000000000),
            totalMinted      : 0,
            initialized      : false,
        };
        0x2::transfer::public_share_object<BondCurveState>(v5);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOND_CURVE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun init_buy_amount(arg0: u128, arg1: &BondCurveState) : u128 {
        let (_, _, _, v3) = estimate_buy_result(arg0, arg1);
        v3
    }

    public entry fun initialize(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: address, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: address, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: &mut BondCurveState, arg15: &0x2::clock::Clock, arg16: &mut 0x2::coin::CoinMetadata<BOND_CURVE>, arg17: &BondCurveAdminCap, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg19: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg14.treasuryCap;
        0x2::coin::update_symbol<BOND_CURVE>(v0, arg16, 0x1::ascii::string(arg0));
        0x2::coin::update_name<BOND_CURVE>(v0, arg16, 0x1::string::utf8(arg1));
        0x2::coin::update_description<BOND_CURVE>(v0, arg16, 0x1::string::utf8(arg2));
        0x2::coin::update_icon_url<BOND_CURVE>(v0, arg16, 0x1::ascii::string(arg3));
        assert!(arg4 != @0x0, 4);
        assert!(arg5 != @0x0, 4);
        assert!(arg6 > 0, 0);
        assert!(arg8 <= 1000 && arg9 <= 1000, 7);
        assert!(arg11 <= 1000, 7);
        assert!(arg12 != @0x0, 4);
        assert!(!arg14.initialized, 8);
        arg14.protocolReceiver = arg4;
        arg14.tradeFeeReceiver = arg5;
        arg14.tradeConfig.targetAmount = arg6;
        arg14.tradeConfig.trade_A = arg7;
        arg14.tradeConfig.tradeStep = 1;
        arg14.tradeConfig.trade_fee_percent = arg8;
        arg14.tradeConfig.referrer_fee_percent = arg9;
        arg14.tradeConfig.initBuyValue = arg10;
        arg14.tradeConfig.intiBuyMaxPercent = arg11;
        arg14.initialized = true;
        if (arg10 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg13) == (arg10 as u64), 5);
            assert!(arg10 * 1000 <= arg6 * arg11, 7);
            buy_internal(arg13, arg14, arg18, arg19, arg15, arg12, @0x0, arg20);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg13, 0x2::tx_context::sender(arg20));
        };
        let v1 = TradeStep{
            trade_step     : 1,
            unix_timestamp : 0x2::clock::timestamp_ms(arg15) / 1000,
        };
        0x2::event::emit<TradeStep>(v1);
    }

    public entry fun sell(arg0: 0x2::token::Token<BOND_CURVE>, arg1: &mut BondCurveState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        sell_internal(arg0, arg1, arg2, @0x0, arg3);
    }

    fun sell_internal(arg0: 0x2::token::Token<BOND_CURVE>, arg1: &mut BondCurveState, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::token::value<BOND_CURVE>(&arg0) as u128);
        assert!(arg1.tradeConfig.tradeStep == 1, 6);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = estimate_sell_result(v0, arg1);
        let v4 = v1 + v2 + v3;
        assert!(0 < v4 && v4 <= (0x2::balance::value<0x2::sui::SUI>(&arg1.dex_sui) as u128), 5);
        0x2::balance::join<BOND_CURVE>(&mut arg1.totalBalance, 0x2::coin::into_balance<BOND_CURVE>(0xd9a986001ee8696fea00eceb07b6da8ca1d20e311335dfc7a2e39fdab05a7e82::converter::to_coin<BOND_CURVE>(arg0, &mut arg1.treasuryCap, arg4)));
        arg1.totalMinted = arg1.totalMinted - v0;
        let v5 = if (arg3 != @0x0) {
            arg3
        } else {
            arg1.tradeFeeReceiver
        };
        0x2::sui::transfer(0x2::coin::take<0x2::sui::SUI>(&mut arg1.dex_sui, (v1 as u64), arg4), arg1.protocolReceiver);
        0x2::sui::transfer(0x2::coin::take<0x2::sui::SUI>(&mut arg1.dex_sui, (v2 as u64), arg4), v5);
        0x2::sui::transfer(0x2::coin::take<0x2::sui::SUI>(&mut arg1.dex_sui, (v3 as u64), arg4), 0x2::tx_context::sender(arg4));
        let v6 = TradeInfo{
            referrer           : arg3,
            referrer_amount    : (v2 as u64),
            up_referrer        : @0x0,
            up_referrer_amount : 0,
            fee_value          : (v1 as u64),
            remain_amount      : (v3 as u64),
        };
        let v7 = Sell{
            sender         : 0x2::tx_context::sender(arg4),
            value          : (v3 as u64),
            tokenAmount    : v0,
            lastTokenPrice : 9850000000 * 1000000000 / init_buy_amount(1000000, arg1),
            trade_info     : v6,
            unix_timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<Sell>(v7);
    }

    public entry fun sell_refer(arg0: 0x2::token::Token<BOND_CURVE>, arg1: &mut BondCurveState, arg2: &0x2::clock::Clock, arg3: &0x5b12ca89ae9c13cfc0d167a2e7da29e2bce5148b8350831045229c1960ffb871::referrerstorage::Referrer, arg4: &mut 0x2::tx_context::TxContext) {
        sell_internal(arg0, arg1, arg2, 0x5b12ca89ae9c13cfc0d167a2e7da29e2bce5148b8350831045229c1960ffb871::referrerstorage::referrer(arg3), arg4);
    }

    public entry fun unlock(arg0: vector<0x2::token::Token<BOND_CURVE>>, arg1: &mut BondCurveState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.tradeConfig.tradeStep == 2, 6);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<BOND_CURVE>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::token::Token<BOND_CURVE>>(&arg0)) {
            0x1::vector::push_back<0x2::coin::Coin<BOND_CURVE>>(&mut v0, 0xd9a986001ee8696fea00eceb07b6da8ca1d20e311335dfc7a2e39fdab05a7e82::converter::to_coin<BOND_CURVE>(0x1::vector::pop_back<0x2::token::Token<BOND_CURVE>>(&mut arg0), &mut arg1.treasuryCap, arg2));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::token::Token<BOND_CURVE>>(arg0);
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<BOND_CURVE>>(&mut v0);
        0x2::pay::join_vec<BOND_CURVE>(&mut v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOND_CURVE>>(v2, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

