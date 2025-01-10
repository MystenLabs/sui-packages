module 0xd1aebc3b15f19bcbbfbea5391f81334bcddb79055d0a7bf1afbfe3de1fc8698d::vladk {
    struct VLADK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLADK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VLADK>(arg0, 6, b"VLADK", b"VLADK by SuiAI", b"VLADK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suai_logo_4c609ed205.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VLADK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLADK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

