module 0xcbb6182b9fdaab866dcf36b8f1d6c363ec09d55b0b3b1cb5d2e25f099d2ae994::okay {
    struct OKAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKAY>(arg0, 9, b"OKAY", b"OKAY", b"Okay Boss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://stickershop.line-scdn.net/stickershop/v1/product/23092592/LINEStorePC/main.png?v=1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OKAY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

