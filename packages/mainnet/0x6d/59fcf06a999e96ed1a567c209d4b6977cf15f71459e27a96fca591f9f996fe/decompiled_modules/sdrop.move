module 0x6d59fcf06a999e96ed1a567c209d4b6977cf15f71459e27a96fca591f9f996fe::sdrop {
    struct SDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDROP>(arg0, 6, b"SDROP", b"Suidrop", b"Based on sui drop on sui network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7200_a99153fc8f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

