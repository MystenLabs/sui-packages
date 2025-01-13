module 0x22971b0b4acd1907f13c9b1a0f33ad0b5cefdb47578a3ee186686e3400975109::kyr {
    struct KYR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KYR>(arg0, 6, b"KYR", b"Kiyora by SuiAI", b"Kiyora is a captivating anime-style character, blending charm with a touch of mystery. Known for her sharp intelligence, intriguing nature, and extraordinary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tttrtgsdf_51c75c011d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KYR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

