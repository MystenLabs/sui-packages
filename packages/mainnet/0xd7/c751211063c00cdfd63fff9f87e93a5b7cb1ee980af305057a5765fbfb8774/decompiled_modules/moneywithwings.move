module 0xd7c751211063c00cdfd63fff9f87e93a5b7cb1ee980af305057a5765fbfb8774::moneywithwings {
    struct MONEYWITHWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONEYWITHWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MONEYWITHWINGS>(arg0, 6, b"MONEYWITHWINGS", b"MONEY WITH WINGS", b"SuiEmoji Money with Wings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/moneywithwings.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONEYWITHWINGS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONEYWITHWINGS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

