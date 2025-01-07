module 0x949afe06c58819a8042f332a9147c80f46c3948be98f5e3dc831ac2d1ed940ec::babydoge {
    struct BABYDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDOGE>(arg0, 6, b"Babydoge", b"dogecoinsui", b"babydoge on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_01_17_53_51_8ed71cc7fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

