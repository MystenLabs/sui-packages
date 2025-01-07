module 0x97698577300c5a200d47ab1d2914b0b21757ee5b9506c43bf2c6f5e4f63a175::suibot {
    struct SUIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOT>(arg0, 6, b"SUIBOT", b"SUI BOT", b"SUIBOT is a project that exists on the SUI Chain. We offer a variety of features, including the ability to bridge tokens to various chains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_1463c0f78b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

