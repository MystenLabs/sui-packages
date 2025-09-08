module 0x32e3d55656723ead6ecc16f58c12842dc4995ef4dec7765883573d25248c0bb4::bums {
    struct BUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMS>(arg0, 6, b"Bums", b"BumsS2", b"Season 2 of those living homeless for a year. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000759_d0a775ccaf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

