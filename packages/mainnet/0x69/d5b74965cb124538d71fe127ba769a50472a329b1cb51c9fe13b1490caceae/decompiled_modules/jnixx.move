module 0x69d5b74965cb124538d71fe127ba769a50472a329b1cb51c9fe13b1490caceae::jnixx {
    struct JNIXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNIXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNIXX>(arg0, 6, b"JNIXX", b"Jnix", b"jnix", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bg_2_54855cb86b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNIXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JNIXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

