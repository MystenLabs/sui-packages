module 0x5026b8a19067197d765c92af7d453de4ad286d2477fe07a717675fc7fe9cd556::rnbw {
    struct RNBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNBW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RNBW>(arg0, 6, b"RNBW", b"RAINBOW AI by SuiAI", b"Rainbow AI is decentralize agent who build Text to image and Text to code AI on $SUI, we powered to make 'THE CHEAPEST AI API' for developers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/LOGO_1733b205e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RNBW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNBW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

