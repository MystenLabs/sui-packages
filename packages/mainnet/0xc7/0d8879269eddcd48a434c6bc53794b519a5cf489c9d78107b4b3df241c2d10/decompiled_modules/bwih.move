module 0xc70d8879269eddcd48a434c6bc53794b519a5cf489c9d78107b4b3df241c2d10::bwih {
    struct BWIH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWIH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWIH>(arg0, 6, b"BWIH", b"Binky with headsheet", b"just fish ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b707c05c2b48cf42ebcd622368a276d2_fefd5f25be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWIH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWIH>>(v1);
    }

    // decompiled from Move bytecode v6
}

