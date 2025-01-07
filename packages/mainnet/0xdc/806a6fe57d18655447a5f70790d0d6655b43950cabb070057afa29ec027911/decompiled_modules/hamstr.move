module 0xdc806a6fe57d18655447a5f70790d0d6655b43950cabb070057afa29ec027911::hamstr {
    struct HAMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTR>(arg0, 6, b"HAMSTR", b"HAMSTER", b"HAmmmmmmmmmmmmmmmmmmmSTER. mmm...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_2b648998be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

