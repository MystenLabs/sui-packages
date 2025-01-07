module 0x937c740b28496b1afcdf327db99c32f8e7274e253aee359a4e8aeae8194aeec7::twtr {
    struct TWTR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TWTR>, arg1: 0x2::coin::Coin<TWTR>) {
        0x2::coin::burn<TWTR>(arg0, arg1);
    }

    fun init(arg0: TWTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWTR>(arg0, 4, b"TWTR", b"TWTR", b"TWTR coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x6982508145454ce325ddbe47a25d4ec3d2311933.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xd437be3eb32e137a6b287d114cb37f6be9a5412483c5913bf1734174e7fd46dd, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWTR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TWTR>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<TWTR>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TWTR>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

