module 0x49011700eb8401a6a9bfe9f854e78dc1a0a75bfc956cb3011af7422ac642d6d3::tard {
    struct TARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARD>(arg0, 6, b"TARD", b"SUITARDIO", b"Suitardio World Order", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_E94_C7_D7_B9_AF_47_C6_BF_35_58_E3_CE_6_E5431_d75cbcdb9a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

