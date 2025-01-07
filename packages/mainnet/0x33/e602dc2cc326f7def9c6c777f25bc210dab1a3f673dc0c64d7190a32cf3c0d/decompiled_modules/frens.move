module 0x33e602dc2cc326f7def9c6c777f25bc210dab1a3f673dc0c64d7190a32cf3c0d::frens {
    struct FRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENS>(arg0, 8, b"FRENS", b"Frens", b"Hold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x45c30fa6a2c7e031fe86e4f1cb5becfde149b980.png?size=xl&key=90c320")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FRENS>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

