module 0xa980b54c4277f1bdce1680b3947f1478ac9fc0c1f18e0bd1a9bf4385aa412bb0::lw {
    struct LW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LW>(arg0, 6, b"LW", b"Little White", b"My cute dog: Litter White.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730972150521.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

