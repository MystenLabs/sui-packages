module 0xbf84e1dee2d4ef8daac49a5a9fc987b4c794c2bcd7dae246a99575f0733eb963::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIPSY>(arg0, 6, b"TIPSY", b"Tipsy", b"https://app.turbos.finance/fun/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955912493.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIPSY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIPSY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

