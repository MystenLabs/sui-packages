module 0x86a0c7a38d2e2b755e5746d7d43f5442239c25f0ce170ae907fba458bcdc4e13::SUIHUSKY {
    struct SUIHUSKY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIHUSKY>, arg1: 0x2::coin::Coin<SUIHUSKY>) {
        0x2::coin::burn<SUIHUSKY>(arg0, arg1);
    }

    fun init(arg0: SUIHUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHUSKY>(arg0, 6, b"suiHUS", b"SUI HUSKY", b"https://twitter.com/suihusky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/9387.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIHUSKY>>(v1);
        0x2::coin::mint_and_transfer<SUIHUSKY>(&mut v2, 300000000000000, 0x2::address::from_u256(31303992602310038401626972843829450105232326274430858221383136573820732455561), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHUSKY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIHUSKY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIHUSKY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

