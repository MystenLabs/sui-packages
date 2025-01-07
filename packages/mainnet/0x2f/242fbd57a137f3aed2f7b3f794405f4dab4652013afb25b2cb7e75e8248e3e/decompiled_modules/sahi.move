module 0x2f242fbd57a137f3aed2f7b3f794405f4dab4652013afb25b2cb7e75e8248e3e::sahi {
    struct SAHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAHI>(arg0, 6, b"SAHI", b"Satoshi Hippo", b"SATOSHI NAKAMOTO REVEALED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa_11ac8d96ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

