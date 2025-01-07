module 0x6856fe26e2c9555c27694dd2c0272f5a6c0d0c5a9c1f85a6f0324fae9cab5a6b::crog {
    struct CROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROG>(arg0, 6, b"CROG", b"Crab dog", b"A crab looking like a dog,a dog looking like a crab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_1_523a43d89f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

