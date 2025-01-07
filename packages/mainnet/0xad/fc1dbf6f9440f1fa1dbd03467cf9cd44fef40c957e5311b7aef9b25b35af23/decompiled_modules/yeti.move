module 0xadfc1dbf6f9440f1fa1dbd03467cf9cd44fef40c957e5311b7aef9b25b35af23::yeti {
    struct YETI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETI>(arg0, 6, b"YETI", b"The Awkward Yeti", x"5468652041776b776172642059657469202d2043726561746564206279204e69636b2053656c756b2077686f20686173206761696e6564206f7665722034206d696c6c696f6e20666f6c6c6f77657273206163726f737320616c6c20736f6369616c206d6564696120706c6174666f726d732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vruxdm_Gq_Si9_F_Lo_Bzb56q6u_Fr_R3_K_Mk2_Pwd5h9_Ekg4_C_Kyg_93f0285eab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETI>>(v1);
    }

    // decompiled from Move bytecode v6
}

