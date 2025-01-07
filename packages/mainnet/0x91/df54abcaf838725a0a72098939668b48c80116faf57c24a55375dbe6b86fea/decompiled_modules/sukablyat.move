module 0x91df54abcaf838725a0a72098939668b48c80116faf57c24a55375dbe6b86fea::sukablyat {
    struct SUKABLYAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKABLYAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKABLYAT>(arg0, 6, b"Sukablyat", b"suka", x"0a43796b6120426c796174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_0d97c61d3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKABLYAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUKABLYAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

