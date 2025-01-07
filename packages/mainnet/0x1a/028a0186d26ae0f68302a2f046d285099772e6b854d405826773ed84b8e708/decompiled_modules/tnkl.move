module 0x1a028a0186d26ae0f68302a2f046d285099772e6b854d405826773ed84b8e708::tnkl {
    struct TNKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNKL>(arg0, 6, b"TNKL", b"Tinkle", b"TNKL - The Pepe of the Water Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_Jn5_S0_WC_400x400_18ec426208.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

