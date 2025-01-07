module 0x95bf1699ab33d1d48d17dbf9c487502c73d5e2142f34c4b401b1a5b3ad5a1eea::mkip {
    struct MKIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKIP>(arg0, 6, b"MKIP", b"Mudkip", b"just Mudkip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mudkip_035bc8cf86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

