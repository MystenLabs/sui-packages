module 0x22248cc402d0830eacf9651fe0be18f7158e513635679a8a961093891887e989::createcoin_v2 {
    struct CoinInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        supply: u64,
    }

    struct SupplyHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun create_fixed_supply_coin(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 200000000;
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg4)) {
            let v4 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4);
            v3 = v3 + 0x2::coin::value<0x2::sui::SUI>(&v4);
            0x2::coin::join<0x2::sui::SUI>(&mut v2, v4);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
        assert!(v3 >= v1, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v1, arg5), @0xe0864a5b1092864b843db0da04de607b47bd82ad76314a9aa69b130ece09f8f3);
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
        let (v5, v6) = 0x2::coin::create_currency<vector<u8>>(b"coin_metadata", arg2, arg1, arg0, b"Fixed supply coin", 0x1::option::none<0x2::url::Url>(), arg5);
        let v7 = v5;
        let v8 = CoinInfo{
            id       : 0x2::object::new(arg5),
            name     : 0x1::string::utf8(arg0),
            symbol   : 0x1::string::utf8(arg1),
            decimals : arg2,
            supply   : arg3,
        };
        let v9 = SupplyHolder<vector<u8>>{
            id      : 0x2::object::new(arg5),
            balance : 0x2::coin::mint_balance<vector<u8>>(&mut v7, arg3),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<vector<u8>>>(v7, v0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<vector<u8>>>(v6, v0);
        0x2::transfer::public_transfer<CoinInfo>(v8, v0);
        0x2::transfer::public_transfer<SupplyHolder<vector<u8>>>(v9, v0);
    }

    // decompiled from Move bytecode v6
}

