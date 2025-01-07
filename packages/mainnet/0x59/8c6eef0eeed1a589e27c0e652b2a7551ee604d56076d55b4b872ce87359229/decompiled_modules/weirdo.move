module 0x598c6eef0eeed1a589e27c0e652b2a7551ee604d56076d55b4b872ce87359229::weirdo {
    struct WEIRDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEIRDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEIRDO>(arg0, 6, b"WEIRDO", b"weirdo sui", x"77656972646f20626f692c20646567656e20616c6c2064617920616c6c20646179206c6f6e67206f6e2053756920636861696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_I1_G_Ho_TP_400x400_5f1f626b34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEIRDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEIRDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

