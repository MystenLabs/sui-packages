module 0x8d987bcce25418b651f4de3029eddd383c14c8330c6b18f489caa6bdb5290903::aroa {
    struct AROA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AROA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AROA>(arg0, 6, b"AROA", b"AROA on SUI", x"4275696c64696e67200a404f7474614875620a207c20557365200a4062756c6c785f696f0a20746f207472616465207369676e207570206e6f77", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3eei_Jqt_400x400_a5fc4bd556.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AROA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AROA>>(v1);
    }

    // decompiled from Move bytecode v6
}

