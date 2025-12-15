module 0x5163cc9b1fed13ab5594ecacf2f35a75a889cfade3b59a91c31ebc9976748c18::chr {
    struct CHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHR>(arg0, 6, b"CHR", b"Chris", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1765764329198.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

