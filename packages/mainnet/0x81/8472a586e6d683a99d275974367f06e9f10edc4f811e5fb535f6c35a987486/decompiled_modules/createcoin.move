module 0x818472a586e6d683a99d275974367f06e9f10edc4f811e5fb535f6c35a987486::createcoin {
    struct CoinInfo has drop {
        dummy_field: bool,
    }

    struct FixedSupply has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<CoinInfo>,
    }

    public fun create_fixed_supply_coin(arg0: &mut 0x2::tx_context::TxContext, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u8) {
        let v0 = CoinInfo{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<CoinInfo>(v0, arg4, arg2, arg3, b"", 0x1::option::none<0x2::url::Url>(), arg0);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CoinInfo>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CoinInfo>>(0x2::coin::mint<CoinInfo>(&mut v3, arg1, arg0), 0x2::tx_context::sender(arg0));
        let v4 = FixedSupply{
            id     : 0x2::object::new(arg0),
            supply : 0x2::coin::treasury_into_supply<CoinInfo>(v3),
        };
        0x2::transfer::public_transfer<FixedSupply>(v4, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

