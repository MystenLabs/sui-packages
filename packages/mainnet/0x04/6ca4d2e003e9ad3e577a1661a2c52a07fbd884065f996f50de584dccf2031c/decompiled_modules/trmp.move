module 0x46ca4d2e003e9ad3e577a1661a2c52a07fbd884065f996f50de584dccf2031c::trmp {
    struct TRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMP>(arg0, 6, b"TRMP", b"TrumpPump", b"In trump we trust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3201_fca8bd67d6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

