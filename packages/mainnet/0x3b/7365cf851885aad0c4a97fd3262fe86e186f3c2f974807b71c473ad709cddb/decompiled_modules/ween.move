module 0x3b7365cf851885aad0c4a97fd3262fe86e186f3c2f974807b71c473ad709cddb::ween {
    struct WEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEN>(arg0, 6, b"Ween", b"hellocat", b"Amazingly cute halloween cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hand_drawn_flat_halloween_cat_illustration_23_2149070335_6f96ca36f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

