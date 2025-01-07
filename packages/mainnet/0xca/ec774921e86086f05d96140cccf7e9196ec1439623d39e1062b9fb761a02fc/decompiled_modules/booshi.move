module 0xcaec774921e86086f05d96140cccf7e9196ec1439623d39e1062b9fb761a02fc::booshi {
    struct BOOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOSHI>(arg0, 6, b"BOOSHI", b"BOOSHI ON SUI", b"SHIBOO's BROTHER NOW ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/favicon_6cca217d51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

