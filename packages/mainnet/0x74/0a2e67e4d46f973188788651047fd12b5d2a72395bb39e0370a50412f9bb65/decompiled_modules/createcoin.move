module 0x740a2e67e4d46f973188788651047fd12b5d2a72395bb39e0370a50412f9bb65::createcoin {
    struct CoinInfo has drop {
        dummy_field: bool,
    }

    struct FixedSupply has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<CoinInfo>,
    }

    public fun create_fixed_supply_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u8) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0xcc0b68f6adac0c95b48a55c8b4c134507a4009aadd3cc0dfee1a8b8166919d29);
        let v0 = CoinInfo{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<CoinInfo>(v0, arg5, arg3, arg4, b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CoinInfo>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CoinInfo>>(0x2::coin::mint<CoinInfo>(&mut v3, arg2, arg1), 0x2::tx_context::sender(arg1));
        let v4 = FixedSupply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<CoinInfo>(v3),
        };
        0x2::transfer::public_transfer<FixedSupply>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

