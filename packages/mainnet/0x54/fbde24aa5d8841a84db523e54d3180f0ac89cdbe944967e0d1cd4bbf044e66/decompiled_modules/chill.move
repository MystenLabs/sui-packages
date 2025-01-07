module 0x54fbde24aa5d8841a84db523e54d3180f0ac89cdbe944967e0d1cd4bbf044e66::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILL>(arg0, 6, b"CHILL", b"Sui guy", b"The smoothest most chill guy on Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732096468749.21")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

