module 0x7c166161436c8b8f1c7a3b46b601104c890f80aa95cbb7d72ac648031f819622::ayame {
    struct AYAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AYAME>(arg0, 6, b"AYAME", b"AYAME by SuiAI", b"Ayame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250112_225542_78f2bd1d4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AYAME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYAME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

