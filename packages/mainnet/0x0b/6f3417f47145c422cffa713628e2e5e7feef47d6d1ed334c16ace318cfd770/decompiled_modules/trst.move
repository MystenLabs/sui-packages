module 0xb6f3417f47145c422cffa713628e2e5e7feef47d6d1ed334c16ace318cfd770::trst {
    struct TRST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRST>(arg0, 6, b"TRST", b"test", b"testgh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_3bf10cb9dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRST>>(v1);
    }

    // decompiled from Move bytecode v6
}

