module 0x4ab1417f58dc1ff57cf17823a74c93b86934fab2593d83d52f9e9ca10cbf4a9b::createcoin {
    struct CoinMetadata has copy, drop {
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
    }

    struct CoinInfo has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
    }

    struct SupplyHolder has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<CoinMetadata>,
    }

    entry fun create_fixed_supply_coin(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == 200000000, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0xe0864a5b1092864b843db0da04de607b47bd82ad76314a9aa69b130ece09f8f3);
        let v0 = CoinMetadata{
            name     : arg0,
            symbol   : arg1,
            decimals : arg2,
        };
        let v1 = CoinInfo{
            id       : 0x2::object::new(arg5),
            name     : arg0,
            symbol   : arg1,
            decimals : arg2,
        };
        let v2 = 0x2::balance::create_supply<CoinMetadata>(v0);
        let v3 = SupplyHolder{
            id     : 0x2::object::new(arg5),
            supply : v2,
        };
        0x2::transfer::transfer<SupplyHolder>(v3, 0x2::tx_context::sender(arg5));
        0x2::transfer::transfer<CoinInfo>(v1, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<CoinMetadata>>(0x2::coin::from_balance<CoinMetadata>(0x2::balance::increase_supply<CoinMetadata>(&mut v2, arg3), arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

