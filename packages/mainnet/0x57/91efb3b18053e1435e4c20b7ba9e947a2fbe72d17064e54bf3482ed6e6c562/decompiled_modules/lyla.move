module 0x5791efb3b18053e1435e4c20b7ba9e947a2fbe72d17064e54bf3482ed6e6c562::lyla {
    struct LYLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LYLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYLA>(arg0, 6, b"LYLA", b"Lyla on Sui v2 (cto)", b"After the success of $RAY LYLA, RAY's wife and queen of MOVE PUMP, arrives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c866f7a6_2061_41fa_acfa_730eba4b2519_9f316da210.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LYLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LYLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

