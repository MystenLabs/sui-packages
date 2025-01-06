module 0xf73eb61a78176f30e52354ffec17bad189a52543e1157096d304ae78bb34de84::helenaai {
    struct HELENAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELENAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HELENAAI>(arg0, 6, b"HELENAAI", b"HelenaAI by SuiAI", b"HelenaAI is a dynamic bot designed to help X users explore the vast world of the Sui_NetWork blockchain, providing essential knowledge and practical strategies to maximize profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Helena_AI_af93db0641.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELENAAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELENAAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

