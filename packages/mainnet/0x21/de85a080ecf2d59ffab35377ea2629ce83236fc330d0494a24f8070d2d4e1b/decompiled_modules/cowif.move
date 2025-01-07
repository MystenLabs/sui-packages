module 0x21de85a080ecf2d59ffab35377ea2629ce83236fc330d0494a24f8070d2d4e1b::cowif {
    struct COWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWIF>(arg0, 6, b"Cowif", b"ComoWifhat on sui", x"436f6d6f576966686174206d656d6520636f696e206f6e2053756920636861696e200a0a546f6b656e20666f722066616e20656e6a6f792074726164696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994362787.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

