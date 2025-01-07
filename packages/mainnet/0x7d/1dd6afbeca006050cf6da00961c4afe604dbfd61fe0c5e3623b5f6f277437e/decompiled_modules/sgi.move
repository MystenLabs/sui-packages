module 0x7d1dd6afbeca006050cf6da00961c4afe604dbfd61fe0c5e3623b5f6f277437e::sgi {
    struct SGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGI>(arg0, 6, b"SGI", b"Suigems", b"LFG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731278944131.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

