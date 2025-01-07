module 0xa371d234b959d687bc627d05bd4ff562b931bfeef2a5727861ab2d4db4427e9a::food {
    struct FOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOD>(arg0, 6, b"FOOD", b"Food", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1::fud::fud.png?size=lg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOOD>(&mut v2, 69000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

