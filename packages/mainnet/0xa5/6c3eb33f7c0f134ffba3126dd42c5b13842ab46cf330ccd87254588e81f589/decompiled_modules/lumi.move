module 0xa56c3eb33f7c0f134ffba3126dd42c5b13842ab46cf330ccd87254588e81f589::lumi {
    struct LUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMI>(arg0, 6, b"LUMI", b"Sui Lumi", b"Lumi is a vibrant and magical character from the enchanting realm of creativity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_21_at_21_24_46_5afc34cb05.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

