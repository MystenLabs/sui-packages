module 0xc22aff89db4a3c6170de6e4785a7d2cbe2327f254460d84ff80011f5c54b71cb::jenny {
    struct JENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JENNY>(arg0, 6, b"JENNY", b"Jenny Agent by SuiAI", b"AI Companion powered by DePIN on PEAQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/z8_Lsx_1j_400x400_d59dcea5f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JENNY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENNY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

