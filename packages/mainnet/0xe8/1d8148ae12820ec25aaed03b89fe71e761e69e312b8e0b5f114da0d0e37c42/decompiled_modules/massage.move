module 0xe81d8148ae12820ec25aaed03b89fe71e761e69e312b8e0b5f114da0d0e37c42::massage {
    struct MASSAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASSAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASSAGE>(arg0, 6, b"MASSAGE", b"Kanye's massage", b"kanye's massage to the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K_Massage_1ec765f3e8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASSAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASSAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

