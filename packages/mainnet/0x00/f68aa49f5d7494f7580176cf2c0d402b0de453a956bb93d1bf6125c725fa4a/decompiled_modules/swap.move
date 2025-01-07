module 0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Swap has store, key {
        id: 0x2::object::UID,
        hk: 0x2::balance::Balance<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>,
        j_coin: 0x2::balance::Balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>,
        j_coin_profit: 0x2::balance::Balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>,
        hk_prifit: 0x2::balance::Balance<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>,
    }

    public entry fun deposit_hk(arg0: &mut Swap, arg1: 0x2::coin::Coin<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&mut arg0.hk, 0x2::coin::into_balance<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(arg1));
    }

    public entry fun deposit_jethro_coin(arg0: &mut Swap, arg1: 0x2::coin::Coin<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&mut arg0.j_coin, 0x2::coin::into_balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Swap{
            id            : 0x2::object::new(arg0),
            hk            : 0x2::balance::zero<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(),
            j_coin        : 0x2::balance::zero<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(),
            j_coin_profit : 0x2::balance::zero<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(),
            hk_prifit     : 0x2::balance::zero<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(),
        };
        0x2::transfer::share_object<Swap>(v1);
    }

    public entry fun swap_hk(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(arg1) > 0, 2);
        assert!(0x2::balance::value<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&arg0.hk) > 0 && 0x2::balance::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&arg0.j_coin) > 0, 3);
        let v0 = 0x2::coin::value<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(arg1) / 100;
        let v1 = 0x2::coin::value<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(arg1) - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>>(0x2::coin::from_balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(0x2::balance::split<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&mut arg0.j_coin, 0x2::balance::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&arg0.j_coin) - 0x2::balance::value<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&arg0.hk) * 0x2::balance::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&arg0.j_coin) / (v1 + 0x2::balance::value<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&arg0.hk))), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::join<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&mut arg0.hk_prifit, 0x2::coin::into_balance<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(0x2::coin::split<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(arg1, v0, arg2)));
        0x2::balance::join<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&mut arg0.hk, 0x2::coin::into_balance<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(0x2::coin::split<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(arg1, v1, arg2)));
    }

    public entry fun swap_usd(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(arg1) > 0, 2);
        assert!(0x2::balance::value<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&arg0.hk) > 0 && 0x2::balance::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&arg0.j_coin) > 0, 3);
        let v0 = 0x2::coin::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(arg1) / 100;
        let v1 = 0x2::coin::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(arg1) - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>>(0x2::coin::from_balance<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(0x2::balance::split<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&mut arg0.hk, 0x2::balance::value<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&arg0.hk) - 0x2::balance::value<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&arg0.hk) * 0x2::balance::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&arg0.j_coin) / (v1 + 0x2::balance::value<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&arg0.j_coin))), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::join<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&mut arg0.j_coin_profit, 0x2::coin::into_balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(0x2::coin::split<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(arg1, v0, arg2)));
        0x2::balance::join<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&mut arg0.j_coin, 0x2::coin::into_balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(0x2::coin::split<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(arg1, v1, arg2)));
    }

    public entry fun withdraw_hk(arg0: &AdminCap, arg1: &mut Swap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>>(0x2::coin::from_balance<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(0x2::balance::split<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&mut arg1.hk, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_jethro_coin(arg0: &AdminCap, arg1: &mut Swap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>>(0x2::coin::from_balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(0x2::balance::split<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&mut arg1.j_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_prifit(arg0: &AdminCap, arg1: &mut Swap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>>(0x2::coin::from_balance<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(0x2::balance::withdraw_all<0xdbdacdcea63c748df6e247db1fcdc759af2255e2463e6c60815b161d23d866e9::jethro_coin::JETHRO_COIN>(&mut arg1.j_coin_profit), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>>(0x2::coin::from_balance<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(0x2::balance::withdraw_all<0xf68aa49f5d7494f7580176cf2c0d402b0de453a956bb93d1bf6125c725fa4a::HK::HK>(&mut arg1.hk_prifit), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

