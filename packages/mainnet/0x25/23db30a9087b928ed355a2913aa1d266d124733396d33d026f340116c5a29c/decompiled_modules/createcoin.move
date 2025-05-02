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

    entry fun create_fixed_supply_coin(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 200000000;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg4)) {
            v1 = v1 + 0x2::coin::value<0x2::sui::SUI>(0x1::vector::borrow<0x2::coin::Coin<0x2::sui::SUI>>(&arg4, v2));
            v2 = v2 + 1;
        };
        assert!(v1 >= v0, 1000);
        let v3 = 0x2::balance::zero<0x2::sui::SUI>();
        let v4 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        v2 = 0;
        while (v2 < 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg4)) {
            let v5 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4);
            if (0x2::balance::value<0x2::sui::SUI>(&v3) < v0) {
                let v6 = v0 - 0x2::balance::value<0x2::sui::SUI>(&v3);
                if (0x2::coin::value<0x2::sui::SUI>(&v5) <= v6) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v3, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
                } else {
                    0x2::balance::join<0x2::sui::SUI>(&mut v3, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v6, arg5)));
                    0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v4, v5);
                };
            } else {
                0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v4, v5);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg5), @0xe0864a5b1092864b843db0da04de607b47bd82ad76314a9aa69b130ece09f8f3);
        v2 = 0;
        while (v2 < 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&v4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v4), 0x2::tx_context::sender(arg5));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(v4);
        let v7 = CoinMetadata{
            name     : arg0,
            symbol   : arg1,
            decimals : arg2,
        };
        let v8 = CoinInfo{
            id       : 0x2::object::new(arg5),
            name     : arg0,
            symbol   : arg1,
            decimals : arg2,
        };
        let v9 = 0x2::balance::create_supply<CoinMetadata>(v7);
        let v10 = SupplyHolder{
            id     : 0x2::object::new(arg5),
            supply : v9,
        };
        0x2::transfer::transfer<SupplyHolder>(v10, 0x2::tx_context::sender(arg5));
        0x2::transfer::transfer<CoinInfo>(v8, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<CoinMetadata>>(0x2::coin::from_balance<CoinMetadata>(0x2::balance::increase_supply<CoinMetadata>(&mut v9, arg3), arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

