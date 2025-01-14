module 0x8c6d748e1caa8b44745b25324498090475761f72bda21145778cac59944bc7a0::cerberus {
    struct CERBERUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CERBERUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CERBERUS>(arg0, 6, b"CERBERUS", b"CERBERUS by SuiAI", b"Cerberus is an advanced AI system built to serve as a highly adaptable personal and professional assistant. Equipped with cutting-edge machine learning capabilities, Cerberus excels in processing large data sets, automating tasks, and providing insightful recommendations across various domains, including finance, research, and decision-making.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/CERBERUS_d2ddc289c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CERBERUS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CERBERUS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

