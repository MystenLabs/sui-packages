module 0xbf70d9665aaf1b558c548b6bf9b84c4d086a05a1c70d654aba3d77fe7b4912ec::pet {
    struct PET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PET>(arg0, 6, b"PET", b"Pet Pals", x"50657450616c7320697320706c61636520666f7220667269656e64736869702c20656475636174696f6e2c20616e642066756e2e204d656574206578706c6f726572732066726f6d20616c6c206f7665722074686520776f726c6420616e64206275696c6420746f676574686572210a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_JT_Nqj_Ap_400x400_ab0a93cbe0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PET>>(v1);
    }

    // decompiled from Move bytecode v6
}

