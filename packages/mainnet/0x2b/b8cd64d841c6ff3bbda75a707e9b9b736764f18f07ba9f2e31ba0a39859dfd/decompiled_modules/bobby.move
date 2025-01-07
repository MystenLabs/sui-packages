module 0x2bb8cd64d841c6ff3bbda75a707e9b9b736764f18f07ba9f2e31ba0a39859dfd::bobby {
    struct BOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBBY>(arg0, 6, b"Bobby", b"Bobby Kertanegara", b"Indonesia Official Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0829_70963ac520.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

