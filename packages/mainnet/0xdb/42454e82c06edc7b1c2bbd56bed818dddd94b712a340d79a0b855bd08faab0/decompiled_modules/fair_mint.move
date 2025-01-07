module 0xdb42454e82c06edc7b1c2bbd56bed818dddd94b712a340d79a0b855bd08faab0::fair_mint {
    struct FAIR_MINT has drop {
        dummy_field: bool,
    }

    struct FAIR_MINT_COIN<phantom T0> has drop {
        dummy_field: bool,
    }

    struct FairMintAdminCap has key {
        id: 0x2::object::UID,
    }

    struct MintConfig has store, key {
        id: 0x2::object::UID,
        mintSupply: u128,
        mintPrice: u128,
        singleMintMin: u128,
        singleMintMax: u128,
        mintMax: u128,
        endTimestamp: u64,
        liquidityPrice: u128,
    }

    struct TradeConfig has store, key {
        id: 0x2::object::UID,
        tradeStep: u8,
    }

    struct FairMintState has store, key {
        id: 0x2::object::UID,
        protocolReceiver: address,
        dex_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        dex_meme: 0x2::balance::Balance<FAIR_MINT>,
        mintConfig: MintConfig,
        tradeConfig: TradeConfig,
        treasuryCap: 0x2::coin::TreasuryCap<FAIR_MINT>,
        initialized: bool,
    }

    struct TradeStep has copy, drop {
        trade_step: u8,
        unix_timestamp: u64,
    }

    struct FairMint has copy, drop {
        sender: address,
        amount: u128,
        unix_timestamp: u64,
    }

    fun addLiquidity(arg0: &mut FairMintState, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<FAIR_MINT>(0x2::balance::withdraw_all<FAIR_MINT>(&mut arg0.dex_meme), arg4);
        let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.dex_sui), arg4);
        let (v2, v3, v4) = 0xdb42454e82c06edc7b1c2bbd56bed818dddd94b712a340d79a0b855bd08faab0::cetus_adapter::add_liquidity_simple<FAIR_MINT, 0x2::sui::SUI>(arg1, arg2, arg0.mintConfig.liquidityPrice, v0, v1, 0x2::coin::value<FAIR_MINT>(&v0), 0x2::coin::value<0x2::sui::SUI>(&v1), arg3, arg4);
        0x2::coin::burn<FAIR_MINT>(&mut arg0.treasuryCap, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, @0x0);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v2, @0x0);
    }

    public entry fun fairMint(arg0: u128, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut FairMintState, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.tradeConfig.tradeStep == 0, 6);
        assert!(arg0 > 0, 0);
        assert!(arg0 >= arg2.mintConfig.singleMintMin, 2);
        assert!(arg0 <= arg2.mintConfig.singleMintMax, 2);
        assert!((0x2::coin::value<0x2::sui::SUI>(arg1) as u128) * 1000000000 >= arg2.mintConfig.mintPrice * arg0, 5);
        assert!((0x2::coin::total_supply<FAIR_MINT>(&arg2.treasuryCap) as u128) + arg0 <= arg2.mintConfig.mintSupply, 2);
        let v0 = ((arg2.mintConfig.mintPrice * arg0 / 1000000000) as u64);
        let v1 = v0 * 5 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v1, arg6), arg2.protocolReceiver);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.dex_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v0 - v1, arg6)));
        0xdb42454e82c06edc7b1c2bbd56bed818dddd94b712a340d79a0b855bd08faab0::converter::mint_and_keep<FAIR_MINT>(&mut arg2.treasuryCap, (arg0 as u64), arg6);
        if ((0x2::coin::total_supply<FAIR_MINT>(&arg2.treasuryCap) as u128) + arg2.mintConfig.singleMintMin > arg2.mintConfig.mintSupply) {
            arg2.tradeConfig.tradeStep = 2;
            let v2 = TradeStep{
                trade_step     : 2,
                unix_timestamp : 0x2::clock::timestamp_ms(arg5) / 1000,
            };
            0x2::event::emit<TradeStep>(v2);
            0x2::balance::join<FAIR_MINT>(&mut arg2.dex_meme, 0x2::coin::into_balance<FAIR_MINT>(0xdb42454e82c06edc7b1c2bbd56bed818dddd94b712a340d79a0b855bd08faab0::converter::mint_token_to_coin<FAIR_MINT>((((0x2::balance::value<0x2::sui::SUI>(&arg2.dex_sui) as u128) * 1000000000 / arg2.mintConfig.liquidityPrice * 1001 / 1000) as u64), &mut arg2.treasuryCap, arg6)));
            addLiquidity(arg2, arg3, arg4, arg5, arg6);
        };
        let v3 = FairMint{
            sender         : 0x2::tx_context::sender(arg6),
            amount         : arg0,
            unix_timestamp : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<FairMint>(v3);
    }

    fun init(arg0: FAIR_MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FairMintAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<FairMintAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<FAIR_MINT>(arg0, 9, b"", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = MintConfig{
            id             : 0x2::object::new(arg1),
            mintSupply     : 0,
            mintPrice      : 0,
            singleMintMin  : 0,
            singleMintMax  : 0,
            mintMax        : 0,
            endTimestamp   : 0,
            liquidityPrice : 0,
        };
        let v4 = TradeConfig{
            id        : 0x2::object::new(arg1),
            tradeStep : 0,
        };
        let v5 = FairMintState{
            id               : 0x2::object::new(arg1),
            protocolReceiver : @0x0,
            dex_sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            dex_meme         : 0x2::balance::zero<FAIR_MINT>(),
            mintConfig       : v3,
            tradeConfig      : v4,
            treasuryCap      : v1,
            initialized      : false,
        };
        0x2::transfer::public_share_object<FairMintState>(v5);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAIR_MINT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun initialize(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u64, arg11: u128, arg12: &mut FairMintState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::coin::CoinMetadata<FAIR_MINT>, arg15: &FairMintAdminCap, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg12.treasuryCap;
        0x2::coin::update_symbol<FAIR_MINT>(v0, arg14, 0x1::ascii::string(arg0));
        0x2::coin::update_name<FAIR_MINT>(v0, arg14, 0x1::string::utf8(arg1));
        0x2::coin::update_description<FAIR_MINT>(v0, arg14, 0x1::string::utf8(arg2));
        0x2::coin::update_icon_url<FAIR_MINT>(v0, arg14, 0x1::ascii::string(arg3));
        assert!(!arg12.initialized, 7);
        assert!(arg5 > 0, 0);
        assert!(arg8 >= arg7, 2);
        assert!(arg9 > 0, 2);
        assert!(arg6 > 0, 3);
        assert!(arg11 > 0, 3);
        assert!(arg4 != @0x0, 4);
        arg12.protocolReceiver = arg4;
        arg12.mintConfig.mintSupply = arg5;
        arg12.mintConfig.mintPrice = arg6;
        arg12.mintConfig.singleMintMin = arg7;
        arg12.mintConfig.singleMintMax = arg8;
        arg12.mintConfig.mintMax = arg9;
        arg12.mintConfig.endTimestamp = arg10;
        arg12.mintConfig.liquidityPrice = arg11;
        arg12.tradeConfig.tradeStep = 0;
        arg12.initialized = true;
        let v1 = TradeStep{
            trade_step     : 0,
            unix_timestamp : 0x2::clock::timestamp_ms(arg13) / 1000,
        };
        0x2::event::emit<TradeStep>(v1);
    }

    public entry fun unlock(arg0: vector<0x2::token::Token<FAIR_MINT>>, arg1: &mut FairMintState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.tradeConfig.tradeStep == 2, 6);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<FAIR_MINT>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::token::Token<FAIR_MINT>>(&arg0)) {
            0x1::vector::push_back<0x2::coin::Coin<FAIR_MINT>>(&mut v0, 0xdb42454e82c06edc7b1c2bbd56bed818dddd94b712a340d79a0b855bd08faab0::converter::to_coin<FAIR_MINT>(0x1::vector::pop_back<0x2::token::Token<FAIR_MINT>>(&mut arg0), &mut arg1.treasuryCap, arg2));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::token::Token<FAIR_MINT>>(arg0);
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<FAIR_MINT>>(&mut v0);
        0x2::pay::join_vec<FAIR_MINT>(&mut v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAIR_MINT>>(v2, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

