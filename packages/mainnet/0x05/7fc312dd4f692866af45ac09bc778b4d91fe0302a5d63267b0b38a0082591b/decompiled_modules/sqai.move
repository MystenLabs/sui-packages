module 0x57fc312dd4f692866af45ac09bc778b4d91fe0302a5d63267b0b38a0082591b::sqai {
    struct SQAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SQAI>(arg0, 6, b"SQAI", b"SuiQuantumAI by SuiAI", b"Deploy intelligent moderation agents with advanced crypto capabilities. Protect your community from scams, spam, and maintain a secure trading environment..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ddasdasd_73b1568043.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

