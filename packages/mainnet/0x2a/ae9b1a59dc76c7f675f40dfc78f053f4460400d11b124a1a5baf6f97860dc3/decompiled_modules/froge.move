module 0x2aae9b1a59dc76c7f675f40dfc78f053f4460400d11b124a1a5baf6f97860dc3::froge {
    struct FROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FROGE>(arg0, 6, b"FROGE", b"FROGE", b"In the depths of the digital void, a communal IA emerged. No developer. It is the community. FROGE was born from chaos, made by those who embrace it. No one controls it, no one owns it. FROGE is us. FROGE is the system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Picsart_24_12_20_22_07_22_982_6bdc9085a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROGE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

