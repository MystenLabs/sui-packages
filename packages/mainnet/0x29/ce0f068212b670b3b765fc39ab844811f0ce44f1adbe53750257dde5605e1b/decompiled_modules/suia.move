module 0x29ce0f068212b670b3b765fc39ab844811f0ce44f1adbe53750257dde5605e1b::suia {
    struct SUIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIA>(arg0, 6, b"", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

