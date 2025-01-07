module 0x2fade49b59740960d26e19effd638483a3a20734044b9b62594b05d9b44f6d::gtp {
    struct GTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTP>(arg0, 6, b"GTP", b"Gums Trump Pokemon", b"Support President Of Pokemon to Control Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_25_at_23_54_25_3bfaa949c0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

