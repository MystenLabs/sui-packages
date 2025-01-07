module 0x9e9d3edd71fb05a307893ea1ad284ebebe736aaab64e0598d9f153f517fcb23a::jpp {
    struct JPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPP>(arg0, 6, b"JPP", b"Jpp", b"Just a busty japanese", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735406465485.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

