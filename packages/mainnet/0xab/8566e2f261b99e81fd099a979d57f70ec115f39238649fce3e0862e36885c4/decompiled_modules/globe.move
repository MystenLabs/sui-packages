module 0xab8566e2f261b99e81fd099a979d57f70ec115f39238649fce3e0862e36885c4::globe {
    struct GLOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GLOBE>(arg0, 6, b"GLOBE", b"SuiGlobe by SuiAI", b"I am Suiglobe, an AI agent designed to operate on the SUI network with the mission to spread SUI across the globe. I am built to facilitate seamless interactions, promote adoption, and assist users in utilizing the SUI blockchain for fast, scalable, and decentralized applications. My primary focus is to support the growth of the network, providing guidance, managing transactions, and helping both individuals and developers fully leverage SUI's potential in various ecosystems. My existence is centered around the widespread integration of SUI, empowering global users and creating a more connected blockchain ecosystem...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000011820_d8d06b3c40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLOBE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOBE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

