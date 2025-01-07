module 0x29811f79c58b924c6df0ae8cc9f6118a83a1a125ecb60eb9d59b92212808f92b::xcsez {
    struct XCSEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCSEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCSEZ>(arg0, 6, b"XCSEZ", b"cxvxcgv", b"vcxvdhdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_a44127d619.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCSEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XCSEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

