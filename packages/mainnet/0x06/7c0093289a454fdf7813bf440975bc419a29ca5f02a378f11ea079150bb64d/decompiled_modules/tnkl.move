module 0x67c0093289a454fdf7813bf440975bc419a29ca5f02a378f11ea079150bb64d::tnkl {
    struct TNKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNKL>(arg0, 6, b"TNKL", b"TINKLE ON SUI", b"The Pepe of the Water Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tinkle_a429898e3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

