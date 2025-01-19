module 0x74bb5f3ead1e9f12ce6d1cfd0b5fa0ba5766cf7439d64209d6bba7457dba2541::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMPSUI>(arg0, 6, b"TRUMPSUI", b"OFFICIAL TRUMP by SuiAI", b"The only OFFICIAL TRUMP by SUIAI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tick_ed4f4ab63c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMPSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

