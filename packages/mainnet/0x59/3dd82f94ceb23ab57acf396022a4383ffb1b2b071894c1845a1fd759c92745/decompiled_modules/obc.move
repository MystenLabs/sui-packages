module 0x593dd82f94ceb23ab57acf396022a4383ffb1b2b071894c1845a1fd759c92745::obc {
    struct OBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBC>(arg0, 9, b"OBC", b"OBACRYPTO", b"TRADING OF CRYPTOCURRENCY, BUYING AND SELLING OF BTC ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d8c7125-0193-4457-8a45-b2d9ab651755.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

