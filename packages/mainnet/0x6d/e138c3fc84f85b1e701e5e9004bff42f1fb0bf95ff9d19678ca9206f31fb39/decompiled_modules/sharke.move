module 0x6de138c3fc84f85b1e701e5e9004bff42f1fb0bf95ff9d19678ca9206f31fb39::sharke {
    struct SHARKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKE>(arg0, 6, b"SHARKE", b"SuiSharke", b"Get ready to dive into the deep and ride the waves with us. Nhack Nhack!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sherk_087320b0a8_c818ca40b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

