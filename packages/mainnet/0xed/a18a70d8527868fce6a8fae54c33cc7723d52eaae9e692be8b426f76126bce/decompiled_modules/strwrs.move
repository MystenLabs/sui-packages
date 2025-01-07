module 0xeda18a70d8527868fce6a8fae54c33cc7723d52eaae9e692be8b426f76126bce::strwrs {
    struct STRWRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRWRS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STRWRS>(arg0, 6, b"STRWRS", b"STIR WIRS by SuiAI", b"The lightsaber duels you shoudlve seen as a kid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Stir_Wirs_be855faf42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STRWRS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRWRS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

