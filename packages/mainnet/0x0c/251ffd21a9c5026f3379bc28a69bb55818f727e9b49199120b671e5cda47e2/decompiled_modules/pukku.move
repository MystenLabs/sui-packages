module 0xc251ffd21a9c5026f3379bc28a69bb55818f727e9b49199120b671e5cda47e2::pukku {
    struct PUKKU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PUKKU>, arg1: 0x2::coin::Coin<PUKKU>) {
        0x2::coin::burn<PUKKU>(arg0, arg1);
    }

    fun init(arg0: PUKKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUKKU>(arg0, 4, b"PUKKU", b"PUKKU", b"SUI PUKKU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CZNCrkTVEP8RzfpvfnYsaE1EimEJE11HBhSFixTev5ZA.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xfc66d8f0d18c8887fe9bc699c12283f8494a16332aa624c374e88904d8d67c63, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUKKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUKKU>>(v2, @0xfc66d8f0d18c8887fe9bc699c12283f8494a16332aa624c374e88904d8d67c63);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUKKU>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PUKKU>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

