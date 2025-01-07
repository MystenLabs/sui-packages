module 0xfb589b661fb6f68f7424d68406cf2e68bfd051edd8acb8bcc98d61c79d8be7e6::tokend {
    struct TOKEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKEND>(arg0, 6, b"TOKEND", b"TOKEND by SuiAI", b"TOKEND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/level_closed_2246033130.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEND>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEND>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

