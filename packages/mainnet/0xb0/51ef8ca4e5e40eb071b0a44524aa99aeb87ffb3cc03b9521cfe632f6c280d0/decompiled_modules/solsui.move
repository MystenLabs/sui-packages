module 0xb051ef8ca4e5e40eb071b0a44524aa99aeb87ffb3cc03b9521cfe632f6c280d0::solsui {
    struct SOLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLSUI>(arg0, 6, b"SOLSUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLSUI>>(v1);
        0x2::coin::mint_and_transfer<SOLSUI>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

