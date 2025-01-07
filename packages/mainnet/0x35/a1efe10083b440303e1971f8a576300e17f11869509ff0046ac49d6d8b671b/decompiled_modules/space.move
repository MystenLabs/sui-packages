module 0x35a1efe10083b440303e1971f8a576300e17f11869509ff0046ac49d6d8b671b::space {
    struct SPACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACE>(arg0, 6, b"SPACE", b"SPACE ORDIMAN", b"A new concept of Role Play Game at the same time you will return to the tabletop RPG games of the 90s... Just hold on. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732669971978.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

