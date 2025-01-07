module 0xb04e3e4abbbdb6d1c8a5f234b07cceb462358479cf6f769901d3071a43aaf1a7::peeg {
    struct PEEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEG>(arg0, 6, b"PEEG", b"Pee the pix", b"Pee pee peee can't stop pee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/747b52dbf563bc14b85780f87c496d09_3124759b6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

