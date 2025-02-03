module 0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::market_right {
    struct MARKET_RIGHT has drop {
        dummy_field: bool,
    }

    struct MarketRightGlobal has key {
        id: 0x2::object::UID,
        culmulate_game_SHUI: u64,
        culmulate_game_SUI: u64,
        culmulate_nft_SHUI: u64,
        culmulate_nft_SUI: u64,
        balance_game_SHUI: 0x2::balance::Balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>,
        balance_game_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        balance_nft_SHUI: 0x2::balance::Balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>,
        balance_nft_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        nft_20_issued: u64,
        nft_15_issued: u64,
        nft_10_issued: u64,
        nft_5_issued: u64,
        nft_0_issued: u64,
        game_25_issued: u64,
        game_20_issued: u64,
        game_10_issued: u64,
        game_5_issued: u64,
        game_3_issued: u64,
        game_2_issued: u64,
        game_0_issued: u64,
        creator: address,
        version: u64,
    }

    struct MARKET_RIGHT_NFT20 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_NFT15 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_NFT10 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_NFT5 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_NFT0 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_GAME25 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_GAME20 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_GAME10 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_GAME5 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_GAME3 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_GAME2 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    struct MARKET_RIGHT_GAME0 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        claimed_sui_amount: u64,
        claimed_shui_amount: u64,
    }

    public entry fun buy_game_right_0(arg0: &mut MarketRightGlobal, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.game_0_issued <= 500, 2);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg1);
        let v1 = 0x1::string::utf8(b"GameFi-TOKEN ");
        let v2 = *0x1::string::bytes(&v1);
        0x1::vector::append<u8>(&mut v2, numbers_to_ascii_vector(arg0.game_0_issued + 1));
        let v3 = MARKET_RIGHT_GAME0{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(v2),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.game_0_issued = arg0.game_0_issued + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_game_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 888 * 1000000000, arg2)));
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        0x2::transfer::public_transfer<MARKET_RIGHT_GAME0>(v3, 0x2::tx_context::sender(arg2));
    }

    public entry fun buy_nft_right_0(arg0: &mut MarketRightGlobal, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.nft_0_issued <= 500, 2);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg1);
        let v1 = 0x1::string::utf8(b"NFT-TOKEN ");
        let v2 = *0x1::string::bytes(&v1);
        0x1::vector::append<u8>(&mut v2, numbers_to_ascii_vector(arg0.nft_0_issued + 1));
        let v3 = MARKET_RIGHT_NFT0{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(v2),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.nft_0_issued = arg0.nft_0_issued + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_game_SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 888 * 1000000000, arg2)));
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        0x2::transfer::public_transfer<MARKET_RIGHT_NFT0>(v3, 0x2::tx_context::sender(arg2));
    }

    public entry fun claimed_game_0(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_GAME0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_game_SHUI;
        let v1 = arg0.culmulate_game_SUI;
        if (v0 * 7 / 10000 > arg1.claimed_shui_amount) {
            let v2 = v0 * 7 / 10000 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v2), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * 7 / 10000 > arg1.claimed_sui_amount) {
            let v3 = v1 * 7 / 10000 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_game_10(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_GAME10, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_game_SHUI;
        let v1 = arg0.culmulate_game_SUI;
        let v2 = 10;
        if (v0 * v2 / 100 > arg1.claimed_shui_amount) {
            let v3 = v0 * v2 / 100 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * v2 / 100 > arg1.claimed_sui_amount) {
            let v4 = v1 * v2 / 100 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v4), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_game_2(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_GAME2, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_game_SHUI;
        let v1 = arg0.culmulate_game_SUI;
        let v2 = 2;
        if (v0 * v2 / 100 > arg1.claimed_shui_amount) {
            let v3 = v0 * v2 / 100 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * v2 / 100 > arg1.claimed_sui_amount) {
            let v4 = v1 * v2 / 100 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v4), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_game_20(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_GAME20, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_game_SHUI;
        let v1 = arg0.culmulate_game_SUI;
        let v2 = 20;
        if (v0 * v2 / 100 > arg1.claimed_shui_amount) {
            let v3 = v0 * v2 / 100 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * v2 / 100 > arg1.claimed_sui_amount) {
            let v4 = v1 * v2 / 100 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v4), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_game_25(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_GAME25, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_game_SHUI;
        let v1 = arg0.culmulate_game_SUI;
        let v2 = 25;
        if (v0 * v2 / 100 > arg1.claimed_shui_amount) {
            let v3 = v0 * v2 / 100 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * v2 / 100 > arg1.claimed_sui_amount) {
            let v4 = v1 * v2 / 100 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v4), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_game_3(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_GAME3, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_game_SHUI;
        let v1 = arg0.culmulate_game_SUI;
        let v2 = 3;
        if (v0 * v2 / 100 > arg1.claimed_shui_amount) {
            let v3 = v0 * v2 / 100 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * v2 / 100 > arg1.claimed_sui_amount) {
            let v4 = v1 * v2 / 100 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v4), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_game_5(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_GAME5, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_game_SHUI;
        let v1 = arg0.culmulate_game_SUI;
        let v2 = 5;
        if (v0 * v2 / 100 > arg1.claimed_shui_amount) {
            let v3 = v0 * v2 / 100 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * v2 / 100 > arg1.claimed_sui_amount) {
            let v4 = v1 * v2 / 100 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v4), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_nft_0(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_NFT0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_nft_SHUI;
        let v1 = arg0.culmulate_nft_SUI;
        if (v0 / 1000 > arg1.claimed_shui_amount) {
            let v2 = v0 / 1000 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v2), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 / 1000 > arg1.claimed_sui_amount) {
            let v3 = v1 / 1000 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_nft_10(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_NFT10, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_nft_SHUI;
        let v1 = arg0.culmulate_nft_SUI;
        let v2 = 10;
        if (v0 * v2 / 100 > arg1.claimed_shui_amount) {
            let v3 = v0 * v2 / 100 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * v2 / 100 > arg1.claimed_sui_amount) {
            let v4 = v1 * v2 / 100 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v4), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_nft_15(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_NFT15, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_nft_SHUI;
        let v1 = arg0.culmulate_nft_SUI;
        let v2 = 15;
        if (v0 * v2 / 100 > arg1.claimed_shui_amount) {
            let v3 = v0 * v2 / 100 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * v2 / 100 > arg1.claimed_sui_amount) {
            let v4 = v1 * v2 / 100 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v4), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_nft_20(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_NFT20, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_nft_SHUI;
        let v1 = arg0.culmulate_nft_SUI;
        let v2 = 20;
        if (v0 * v2 / 100 > arg1.claimed_shui_amount) {
            let v3 = v0 * v2 / 100 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * v2 / 100 > arg1.claimed_sui_amount) {
            let v4 = v1 * v2 / 100 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v4), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claimed_nft_5(arg0: &mut MarketRightGlobal, arg1: &mut MARKET_RIGHT_NFT5, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.culmulate_nft_SHUI;
        let v1 = arg0.culmulate_nft_SUI;
        let v2 = 5;
        if (v0 * v2 / 100 > arg1.claimed_shui_amount) {
            let v3 = v0 * v2 / 100 - arg1.claimed_shui_amount;
            arg1.claimed_shui_amount = arg1.claimed_shui_amount + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v1 * v2 / 100 > arg1.claimed_sui_amount) {
            let v4 = v1 * v2 / 100 - arg1.claimed_sui_amount;
            arg1.claimed_sui_amount = arg1.claimed_sui_amount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, v4), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public fun get_culmulate_game_SHUI(arg0: &MarketRightGlobal) : u64 {
        arg0.culmulate_game_SHUI
    }

    public fun get_culmulate_game_SUI(arg0: &MarketRightGlobal) : u64 {
        arg0.culmulate_game_SUI
    }

    public fun get_culmulate_nft_SHUI(arg0: &MarketRightGlobal) : u64 {
        arg0.culmulate_nft_SHUI
    }

    public fun get_culmulate_nft_SUI(arg0: &MarketRightGlobal) : u64 {
        arg0.culmulate_nft_SUI
    }

    fun init(arg0: MARKET_RIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRightGlobal{
            id                  : 0x2::object::new(arg1),
            culmulate_game_SHUI : 0,
            culmulate_game_SUI  : 0,
            culmulate_nft_SHUI  : 0,
            culmulate_nft_SUI   : 0,
            balance_game_SHUI   : 0x2::balance::zero<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(),
            balance_game_SUI    : 0x2::balance::zero<0x2::sui::SUI>(),
            balance_nft_SHUI    : 0x2::balance::zero<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(),
            balance_nft_SUI     : 0x2::balance::zero<0x2::sui::SUI>(),
            nft_20_issued       : 0,
            nft_15_issued       : 0,
            nft_10_issued       : 0,
            nft_5_issued        : 0,
            nft_0_issued        : 0,
            game_25_issued      : 0,
            game_20_issued      : 0,
            game_10_issued      : 0,
            game_5_issued       : 0,
            game_3_issued       : 0,
            game_2_issued       : 0,
            game_0_issued       : 0,
            creator             : 0x2::tx_context::sender(arg1),
            version             : 0,
        };
        0x2::transfer::share_object<MarketRightGlobal>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/SHUI-NFT20.jpg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"metaGame"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/SHUI-NFT15.jpg"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"metaGame"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/SHUI-NFT10.jpg"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"metaGame"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/SHUI-NFT5.jpg"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"metaGame"));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/NFT-TOKEN.jpg"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"metaGame"));
        let v13 = 0x1::vector::empty<0x1::string::String>();
        let v14 = &mut v13;
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/SHUI-NFT20.jpg"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"metaGame"));
        let v15 = 0x1::vector::empty<0x1::string::String>();
        let v16 = &mut v15;
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/SHUI-NFT15.jpg"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"metaGame"));
        let v17 = 0x1::vector::empty<0x1::string::String>();
        let v18 = &mut v17;
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/SHUI-NFT10.jpg"));
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"metaGame"));
        let v19 = 0x1::vector::empty<0x1::string::String>();
        let v20 = &mut v19;
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/SHUI-NFT5.jpg"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"metaGame"));
        let v21 = 0x1::vector::empty<0x1::string::String>();
        let v22 = &mut v21;
        0x1::vector::push_back<0x1::string::String>(v22, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v22, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v22, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v22, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/SHUI-NFT5.jpg"));
        0x1::vector::push_back<0x1::string::String>(v22, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v22, 0x1::string::utf8(b"metaGame"));
        let v23 = 0x1::vector::empty<0x1::string::String>();
        let v24 = &mut v23;
        0x1::vector::push_back<0x1::string::String>(v24, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v24, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v24, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v24, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/SHUI-NFT5.jpg"));
        0x1::vector::push_back<0x1::string::String>(v24, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v24, 0x1::string::utf8(b"metaGame"));
        let v25 = 0x1::vector::empty<0x1::string::String>();
        let v26 = &mut v25;
        0x1::vector::push_back<0x1::string::String>(v26, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v26, 0x1::string::utf8(b"shui metagame market fee rights, owner can gain gas fee from it cyclically"));
        0x1::vector::push_back<0x1::string::String>(v26, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v26, 0x1::string::utf8(b"https://bafybeifnidwalkxnx2y4nmjgeocut7pgys6vsxph7hsucowt3fvxsgynme.ipfs.nftstorage.link/NFT-TOKEN.jpg"));
        0x1::vector::push_back<0x1::string::String>(v26, 0x1::string::utf8(b"https://shui.game/"));
        0x1::vector::push_back<0x1::string::String>(v26, 0x1::string::utf8(b"metaGame"));
        let v27 = 0x2::package::claim<MARKET_RIGHT>(arg0, arg1);
        let v28 = 0x2::display::new_with_fields<MARKET_RIGHT_NFT20>(&v27, v1, v3, arg1);
        0x2::display::update_version<MARKET_RIGHT_NFT20>(&mut v28);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_NFT20>>(v28, 0x2::tx_context::sender(arg1));
        let v29 = 0x2::display::new_with_fields<MARKET_RIGHT_NFT15>(&v27, v1, v5, arg1);
        0x2::display::update_version<MARKET_RIGHT_NFT15>(&mut v29);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_NFT15>>(v29, 0x2::tx_context::sender(arg1));
        let v30 = 0x2::display::new_with_fields<MARKET_RIGHT_NFT10>(&v27, v1, v7, arg1);
        0x2::display::update_version<MARKET_RIGHT_NFT10>(&mut v30);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_NFT10>>(v30, 0x2::tx_context::sender(arg1));
        let v31 = 0x2::display::new_with_fields<MARKET_RIGHT_NFT5>(&v27, v1, v9, arg1);
        0x2::display::update_version<MARKET_RIGHT_NFT5>(&mut v31);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_NFT5>>(v31, 0x2::tx_context::sender(arg1));
        let v32 = 0x2::display::new_with_fields<MARKET_RIGHT_NFT0>(&v27, v1, v11, arg1);
        0x2::display::update_version<MARKET_RIGHT_NFT0>(&mut v32);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_NFT0>>(v32, 0x2::tx_context::sender(arg1));
        let v33 = 0x2::display::new_with_fields<MARKET_RIGHT_GAME25>(&v27, v1, v13, arg1);
        0x2::display::update_version<MARKET_RIGHT_GAME25>(&mut v33);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_GAME25>>(v33, 0x2::tx_context::sender(arg1));
        let v34 = 0x2::display::new_with_fields<MARKET_RIGHT_GAME20>(&v27, v1, v15, arg1);
        0x2::display::update_version<MARKET_RIGHT_GAME20>(&mut v34);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_GAME20>>(v34, 0x2::tx_context::sender(arg1));
        let v35 = 0x2::display::new_with_fields<MARKET_RIGHT_GAME10>(&v27, v1, v17, arg1);
        0x2::display::update_version<MARKET_RIGHT_GAME10>(&mut v35);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_GAME10>>(v35, 0x2::tx_context::sender(arg1));
        let v36 = 0x2::display::new_with_fields<MARKET_RIGHT_GAME5>(&v27, v1, v19, arg1);
        0x2::display::update_version<MARKET_RIGHT_GAME5>(&mut v36);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_GAME5>>(v36, 0x2::tx_context::sender(arg1));
        let v37 = 0x2::display::new_with_fields<MARKET_RIGHT_GAME3>(&v27, v1, v21, arg1);
        0x2::display::update_version<MARKET_RIGHT_GAME3>(&mut v37);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_GAME3>>(v37, 0x2::tx_context::sender(arg1));
        let v38 = 0x2::display::new_with_fields<MARKET_RIGHT_GAME2>(&v27, v1, v23, arg1);
        0x2::display::update_version<MARKET_RIGHT_GAME2>(&mut v38);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_GAME2>>(v38, 0x2::tx_context::sender(arg1));
        let v39 = 0x2::display::new_with_fields<MARKET_RIGHT_GAME0>(&v27, v1, v25, arg1);
        0x2::display::update_version<MARKET_RIGHT_GAME0>(&mut v39);
        0x2::transfer::public_transfer<0x2::display::Display<MARKET_RIGHT_GAME0>>(v39, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v27, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun into_gas_pool_game_SHUI(arg0: &mut MarketRightGlobal, arg1: 0x2::balance::Balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>) {
        arg0.culmulate_game_SHUI = arg0.culmulate_game_SHUI + 0x2::balance::value<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&arg1);
        0x2::balance::join<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_game_SHUI, arg1);
    }

    public(friend) fun into_gas_pool_game_SUI(arg0: &mut MarketRightGlobal, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        arg0.culmulate_game_SUI = arg0.culmulate_game_SUI + 0x2::balance::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_game_SUI, arg1);
    }

    public(friend) fun into_gas_pool_nft_SHUI(arg0: &mut MarketRightGlobal, arg1: 0x2::balance::Balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>) {
        arg0.culmulate_nft_SHUI = arg0.culmulate_nft_SHUI + 0x2::balance::value<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&arg1);
        0x2::balance::join<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_nft_SHUI, arg1);
    }

    public(friend) fun into_gas_pool_nft_SUI(arg0: &mut MarketRightGlobal, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        arg0.culmulate_nft_SUI = arg0.culmulate_nft_SUI + 0x2::balance::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_nft_SUI, arg1);
    }

    public fun issue_game_right_10(arg0: &mut MarketRightGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        assert!(arg0.game_10_issued == 0, 2);
        let v0 = MARKET_RIGHT_GAME10{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"SHUI-GameFi 10"),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.game_10_issued = 1;
        0x2::transfer::public_transfer<MARKET_RIGHT_GAME10>(v0, arg1);
    }

    public fun issue_game_right_2(arg0: &mut MarketRightGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        assert!(arg0.game_2_issued == 0, 2);
        let v0 = MARKET_RIGHT_GAME2{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"SHUI-GameFi 2"),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.game_2_issued = 1;
        0x2::transfer::public_transfer<MARKET_RIGHT_GAME2>(v0, arg1);
    }

    public fun issue_game_right_20(arg0: &mut MarketRightGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        assert!(arg0.game_20_issued == 0, 2);
        let v0 = MARKET_RIGHT_GAME20{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"SHUI-GameFi 20"),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.game_20_issued = 1;
        0x2::transfer::public_transfer<MARKET_RIGHT_GAME20>(v0, arg1);
    }

    public fun issue_game_right_25(arg0: &mut MarketRightGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        assert!(arg0.game_25_issued == 0, 2);
        let v0 = MARKET_RIGHT_GAME25{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"SHUI-GameFi 25"),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.game_25_issued = 1;
        0x2::transfer::public_transfer<MARKET_RIGHT_GAME25>(v0, arg1);
    }

    public fun issue_game_right_3(arg0: &mut MarketRightGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        assert!(arg0.game_3_issued == 0, 2);
        let v0 = MARKET_RIGHT_GAME3{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"SHUI-GameFi 3"),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.game_3_issued = 1;
        0x2::transfer::public_transfer<MARKET_RIGHT_GAME3>(v0, arg1);
    }

    public fun issue_game_right_5(arg0: &mut MarketRightGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        assert!(arg0.game_5_issued == 0, 2);
        let v0 = MARKET_RIGHT_GAME5{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"SHUI-GameFi 5"),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.game_5_issued = 1;
        0x2::transfer::public_transfer<MARKET_RIGHT_GAME5>(v0, arg1);
    }

    public fun issue_nft_right_10(arg0: &mut MarketRightGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        assert!(arg0.nft_10_issued == 0, 2);
        let v0 = MARKET_RIGHT_NFT10{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"SHUI-NFT 10"),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.nft_10_issued = 1;
        0x2::transfer::public_transfer<MARKET_RIGHT_NFT10>(v0, arg1);
    }

    public fun issue_nft_right_15(arg0: &mut MarketRightGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        assert!(arg0.nft_15_issued == 0, 2);
        let v0 = MARKET_RIGHT_NFT15{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"SHUI-NFT 15"),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.nft_15_issued = 1;
        0x2::transfer::public_transfer<MARKET_RIGHT_NFT15>(v0, arg1);
    }

    public fun issue_nft_right_20(arg0: &mut MarketRightGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        assert!(arg0.nft_20_issued == 0, 2);
        let v0 = MARKET_RIGHT_NFT20{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"SHUI-NFT 20"),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.nft_20_issued = 1;
        0x2::transfer::public_transfer<MARKET_RIGHT_NFT20>(v0, arg1);
    }

    public fun issue_nft_right_5(arg0: &mut MarketRightGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        assert!(arg0.nft_5_issued == 0, 2);
        let v0 = MARKET_RIGHT_NFT5{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"SHUI-NFT 5"),
            claimed_sui_amount  : 0,
            claimed_shui_amount : 0,
        };
        arg0.nft_5_issued = 1;
        0x2::transfer::public_transfer<MARKET_RIGHT_NFT5>(v0, arg1);
    }

    fun numbers_to_ascii_vector(arg0: u64) : vector<u8> {
        let v0 = b"";
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun withdraw_shui(arg0: &mut MarketRightGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>>(0x2::coin::from_balance<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(0x2::balance::split<0x78642066f5c857b06483149ae61da3da23d3bc01a1af004947f24b4147aa0c5e::shui::SHUI>(&mut arg0.balance_game_SHUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_sui(arg0: &mut MarketRightGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_game_SUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

