module 0xdadb603f4b19c71de7951a723bc3e88fff719a34c424e1b00993623386a8fd0e::gucho {
    struct GUCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUCHO>(arg0, 6, b"GUCHO", b"GUCHO SUI", b"Legendary furry character with Dynosaurus Blue $GUCHO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3714_3ec97a2155.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUCHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUCHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

