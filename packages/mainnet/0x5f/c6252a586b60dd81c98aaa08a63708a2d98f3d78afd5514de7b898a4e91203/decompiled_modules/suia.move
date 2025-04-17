module 0x5fc6252a586b60dd81c98aaa08a63708a2d98f3d78afd5514de7b898a4e91203::suia {
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

