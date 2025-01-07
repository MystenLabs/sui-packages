module 0x4e46dafe14406d3b3dc964abaa679bb5ee2986fb08c6e7230c823ccfd78142d0::hallodog {
    struct HALLODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLODOG>(arg0, 6, b"HALLODOG", b"Halloween Dogs", b"Im Halloween Dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xc2050b7140408277c1e28611c6fcd076259108978595b31e9172cf131f2de213_hallodog_hallodog_27cd66a0a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

