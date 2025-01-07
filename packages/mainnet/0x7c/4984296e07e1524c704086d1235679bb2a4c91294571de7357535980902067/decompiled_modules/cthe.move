module 0x7c4984296e07e1524c704086d1235679bb2a4c91294571de7357535980902067::cthe {
    struct CTHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTHE>(arg0, 6, b"CTHE", b"Crypto Telugu", x"43727970746f54656c7567750a0a4043727970746f54656c7567754f0a0a43727970746f54656c756775202d2020687474703a2f2f796f75747562652e636f6d2f632f43727970746f54656c7567750a0a43727970746f48696e6469202d20687474703a2f2f796f75747562652e636f6d2f632f43727970746f48696e64690a0a43727970746f456e676c697368202d2068747470733a2f2f796f75747562652e636f6d2f632f43727970746f456e676c697368", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_t_Aez_P_400x400_93cf1e68a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

