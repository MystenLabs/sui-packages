module 0xd955e889ebb09dbd464d7039b726609c3a99b6de937c2f851c62045de22c3294::ashiba {
    struct ASHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHIBA>(arg0, 6, b"ASHIBA", b"Arbian Shiba", b"It's time to get together and build the arbian shiba  community together. The first community driven doge on sui is ready to build the hype. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009874_c005e4d717.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

