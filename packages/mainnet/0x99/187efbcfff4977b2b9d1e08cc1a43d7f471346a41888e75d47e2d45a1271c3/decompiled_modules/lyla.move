module 0x99187efbcfff4977b2b9d1e08cc1a43d7f471346a41888e75d47e2d45a1271c3::lyla {
    struct LYLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LYLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYLA>(arg0, 6, b"LYLA", b"Lyla on Sui", x"4166746572207468652073756363657373206f662024524159200a0a4c594c412c205241592773207769666520616e6420717565656e206f66204d4f56452050554d502c20617272697665732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_OFICIAL_f5618c2a86.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LYLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LYLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

