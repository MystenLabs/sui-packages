module 0xcb98fcdfd3217fdb2520cb4dff6d09f9b557216f747272da317e6dda29359276::betzy {
    struct BETZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETZY>(arg0, 6, b"BETZY", b"Betzy sui", x"4265747a7920697320796f757220676f6f642d6c75636b206d656d65636f696e20616e64206469676974616c20636f6d70616e696f6e2074686174207370726561647320666f7274756e6520616e6420666f737465727320636f6e6e656374696f6e7320616d6f6e6720576562332067616d65727320616e642067616d626c6572732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250101_034338_387_135561c332.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

