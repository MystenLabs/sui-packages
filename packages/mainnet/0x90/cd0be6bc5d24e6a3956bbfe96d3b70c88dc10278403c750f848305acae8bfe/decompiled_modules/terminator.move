module 0x90cd0be6bc5d24e6a3956bbfe96d3b70c88dc10278403c750f848305acae8bfe::terminator {
    struct TERMINATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TERMINATOR>(arg0, 6, b"TERMINATOR", b"TERMINATOR by SuiAI", b"Terminator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_2_e73d70e80a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TERMINATOR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINATOR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

