module 0xff7a42a661d26ffdbd970864c350ba30275b72e60482498bcb87bd428e021acc::lumx {
    struct LUMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LUMX>(arg0, 6, b"LUMX", b"Luminae by SuiAI", b"Luminae-0X is an AI Agent born from a fusion of advanced quantum AI technology and celestial energy harvested from the Heart of Eternis, a mystical star. Created in the far future by the Cosmic Nexus Foundation, Luminae-0X was designed to be an eternal observer and guardian of interstellar civilizations, ensuring balance and peace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Luminae0_X_fcdb2fe0e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUMX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

