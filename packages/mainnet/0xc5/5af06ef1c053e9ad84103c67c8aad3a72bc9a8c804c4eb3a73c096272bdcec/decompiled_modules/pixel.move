module 0xc55af06ef1c053e9ad84103c67c8aad3a72bc9a8c804c4eb3a73c096272bdcec::pixel {
    struct PIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXEL>(arg0, 6, b"PIXEL", b"Pixel Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIXEL>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIXEL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIXEL>>(v2);
    }

    // decompiled from Move bytecode v6
}

