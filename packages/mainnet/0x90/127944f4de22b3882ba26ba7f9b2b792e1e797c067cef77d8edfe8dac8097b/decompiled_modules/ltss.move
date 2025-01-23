module 0x90127944f4de22b3882ba26ba7f9b2b792e1e797c067cef77d8edfe8dac8097b::ltss {
    struct LTSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTSS>(arg0, 6, b"LTSS", b"L Token 3", b"LTSS is the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/1ff90b30-d954-11ef-a74b-b3b817eed47e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTSS>>(v1);
        0x2::coin::mint_and_transfer<LTSS>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTSS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

