module 0x22248cc402d0830eacf9651fe0be18f7158e513635679a8a961093891887e989::createcoin {
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
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4), v0);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
        let (v1, v2) = 0x2::coin::create_currency<vector<u8>>(b"coin", arg2, arg1, arg0, b"", 0x1::option::none<0x2::url::Url>(), arg5);
        let v3 = v1;
        let v4 = CoinInfo{
            id       : 0x2::object::new(arg5),
            name     : 0x1::string::utf8(arg0),
            symbol   : 0x1::string::utf8(arg1),
            decimals : arg2,
            supply   : arg3,
        };
        let v5 = SupplyHolder<vector<u8>>{
            id      : 0x2::object::new(arg5),
            balance : 0x2::coin::mint_balance<vector<u8>>(&mut v3, arg3),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<vector<u8>>>(v3, v0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<vector<u8>>>(v2, v0);
        0x2::transfer::public_transfer<CoinInfo>(v4, v0);
        0x2::transfer::public_transfer<SupplyHolder<vector<u8>>>(v5, v0);
    }

    // decompiled from Move bytecode v6
}

