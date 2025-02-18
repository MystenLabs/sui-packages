module 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::coins {
    struct USDT has drop {
        dummy_field: bool,
    }

    struct XBTC has drop {
        dummy_field: bool,
    }

    struct BTC has drop {
        dummy_field: bool,
    }

    struct ETH has drop {
        dummy_field: bool,
    }

    struct BNB has drop {
        dummy_field: bool,
    }

    struct WBTC has drop {
        dummy_field: bool,
    }

    struct USDC has drop {
        dummy_field: bool,
    }

    struct DAI has drop {
        dummy_field: bool,
    }

    public(friend) fun get_coins(arg0: &mut 0x2::tx_context::TxContext) : 0x2::bag::Bag {
        let v0 = 0x2::bag::new(arg0);
        let v1 = USDT{dummy_field: false};
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Supply<USDT>>(&mut v0, 0x1::type_name::into_string(0x1::type_name::get<USDT>()), 0x2::balance::create_supply<USDT>(v1));
        let v2 = XBTC{dummy_field: false};
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Supply<XBTC>>(&mut v0, 0x1::type_name::into_string(0x1::type_name::get<XBTC>()), 0x2::balance::create_supply<XBTC>(v2));
        let v3 = BTC{dummy_field: false};
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Supply<BTC>>(&mut v0, 0x1::type_name::into_string(0x1::type_name::get<BTC>()), 0x2::balance::create_supply<BTC>(v3));
        let v4 = ETH{dummy_field: false};
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Supply<ETH>>(&mut v0, 0x1::type_name::into_string(0x1::type_name::get<ETH>()), 0x2::balance::create_supply<ETH>(v4));
        let v5 = BNB{dummy_field: false};
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Supply<BNB>>(&mut v0, 0x1::type_name::into_string(0x1::type_name::get<BNB>()), 0x2::balance::create_supply<BNB>(v5));
        let v6 = WBTC{dummy_field: false};
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Supply<WBTC>>(&mut v0, 0x1::type_name::into_string(0x1::type_name::get<WBTC>()), 0x2::balance::create_supply<WBTC>(v6));
        let v7 = USDC{dummy_field: false};
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Supply<USDC>>(&mut v0, 0x1::type_name::into_string(0x1::type_name::get<USDC>()), 0x2::balance::create_supply<USDC>(v7));
        let v8 = DAI{dummy_field: false};
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Supply<DAI>>(&mut v0, 0x1::type_name::into_string(0x1::type_name::get<DAI>()), 0x2::balance::create_supply<DAI>(v8));
        v0
    }

    // decompiled from Move bytecode v6
}

