module 0x3b561709e19d7d38008bb0198f20ecdc5e5aad70ad1f84c9b10f8a08e3e5b1b6::helenaia {
    struct HELENAIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELENAIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HELENAIA>(arg0, 6, b"HELENAIA", b"HelenaIA by SuiAI", b"HelenaAI is a dynamic and easy-to-use AI bot designed to help X users explore the vast world of the Sui_NetWork, providing essential knowledge and practical strategies to maximize profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Helena_AI_43bda82e53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELENAIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELENAIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

