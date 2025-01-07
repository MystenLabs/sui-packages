module 0x5bed09980833010baf9122198adc15fe3db7a5d9c291563d3add2cfd95c26eb7::bea {
    struct BEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEA>(arg0, 6, b"BEA", b"Beaver on SUI", b"Protector of the sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730970132653.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

