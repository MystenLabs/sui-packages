module 0xea141a6ce2a5683dd7613d6b963c22623d1c895d029599dedf8f081d72074b66::jolie2 {
    struct JOLIE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLIE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOLIE2>(arg0, 6, b"JOLIE2", b"JOLIE me", b"he", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241231_103145_1_7d2fe882e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLIE2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOLIE2>>(v1);
    }

    // decompiled from Move bytecode v6
}

