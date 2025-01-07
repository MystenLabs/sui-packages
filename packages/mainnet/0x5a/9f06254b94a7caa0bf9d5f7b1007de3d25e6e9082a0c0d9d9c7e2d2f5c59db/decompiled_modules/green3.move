module 0x5a9f06254b94a7caa0bf9d5f7b1007de3d25e6e9082a0c0d9d9c7e2d2f5c59db::green3 {
    struct GREEN3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEN3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEN3>(arg0, 6, b"GREEn3", b"GREEN", b"GREENGREENGREENGREENGREEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730894627209.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREEN3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEN3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

