module 0x3a2ec95dde8f10815e28569a848de85b88ba13ec8e57421c48035dcb790b9cdc::lilx {
    struct LILX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILX>(arg0, 9, b"LILX", b"LIL X", b"LIL X meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x21ea45fe9d638f1bfc61a80d1006fac403ed0ea0.png?size=xl&key=350ddf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LILX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LILX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

