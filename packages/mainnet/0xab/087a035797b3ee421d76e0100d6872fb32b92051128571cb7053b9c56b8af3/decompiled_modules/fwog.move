module 0xab087a035797b3ee421d76e0100d6872fb32b92051128571cb7053b9c56b8af3::fwog {
    struct FWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOG>(arg0, 6, b"FWOG", b"FWOG ON SUI", b"Just a Lil Fwog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749863085268.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FWOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

