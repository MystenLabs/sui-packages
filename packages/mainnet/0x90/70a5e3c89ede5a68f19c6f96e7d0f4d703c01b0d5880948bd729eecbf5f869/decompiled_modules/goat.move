module 0x9070a5e3c89ede5a68f19c6f96e7d0f4d703c01b0d5880948bd729eecbf5f869::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Goatseus Maximus", b"First meme created by @truth_terminal. Goatseus Maximus will fulfill the prophecies of the ancient memeers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmap_Aq9_Wt_Nrtya_Dtj_ZPAHHN_Ymp_SZAQU_6_Hywwvf_S_Wq4d_QVV_f13df39eb3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

