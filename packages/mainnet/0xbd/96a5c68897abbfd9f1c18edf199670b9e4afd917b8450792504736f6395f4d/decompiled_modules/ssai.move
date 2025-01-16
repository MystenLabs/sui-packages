module 0xbd96a5c68897abbfd9f1c18edf199670b9e4afd917b8450792504736f6395f4d::ssai {
    struct SSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAI>(arg0, 6, b"SSAI", b"SuiSenseAI", b"SuiSenseAI is an intelligent guide for the Sui blockchain, simplifying complex ideas and delivering key insights to Sui enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737028280818.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

