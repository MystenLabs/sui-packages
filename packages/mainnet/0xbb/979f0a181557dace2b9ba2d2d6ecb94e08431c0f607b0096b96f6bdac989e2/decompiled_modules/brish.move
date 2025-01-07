module 0xbb979f0a181557dace2b9ba2d2d6ecb94e08431c0f607b0096b96f6bdac989e2::brish {
    struct BRISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRISH>(arg0, 6, b"BRISH", b"Brish Bretts Fish", b"Brish Brett's Fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6510_123cfd39e0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

