module 0x64ec94b2e1042d4acd3207108c712fca15980d381eb4f159d68691c2494e2b10::finn {
    struct FINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINN>(arg0, 6, b"FINN", b"finn the human", b"It's adventure time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733006336297.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FINN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

