module 0xc0bed2ad879e7abeecb2e65aaa1930b795976859d70f634917622bd2a5a507cc::diamondsui {
    struct DIAMONDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMONDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DIAMONDSUI>(arg0, 6, b"DIAMONDSUI", b"SUIDIAMOND by SuiAI", x"436f6d6d756e6974792064726976656e2c20646f6e27742073656c6c206469616d6f6e64732c20627579207468656d2c20646f6e27742072656772657420697420e29c85f09f928ef09f928ef09f92aaf09f928ef09f928ee29c85", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20250112_003936_Telegram_887b9c483c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIAMONDSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMONDSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

