module 0xe97587eb946e9ac92f38ede5945d297cbcfce5fd6efc3609ef921df6d3cdeefa::gua {
    struct GUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUA>(arg0, 6, b"GUA", b"GUA SUI", b"GUA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731607866143.5499759")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

