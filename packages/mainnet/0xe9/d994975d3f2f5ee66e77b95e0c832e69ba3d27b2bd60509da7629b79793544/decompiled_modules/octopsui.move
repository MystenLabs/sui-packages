module 0xe9d994975d3f2f5ee66e77b95e0c832e69ba3d27b2bd60509da7629b79793544::octopsui {
    struct OCTOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPSUI>(arg0, 6, b"OCTOPSUI", b"OCTOP ON SUI", b"Dive into the Future with Octupos Coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_01_50477c61e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

