module 0x88cc2bd8abf37290f175e4c7e34c3515ce0fe356e2cb638b2f2bf7eb8ed9ab44::jessui {
    struct JESSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESSUI>(arg0, 6, b"JESSUI", b"Jessui", b"Jesus token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061444_d4985352e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

