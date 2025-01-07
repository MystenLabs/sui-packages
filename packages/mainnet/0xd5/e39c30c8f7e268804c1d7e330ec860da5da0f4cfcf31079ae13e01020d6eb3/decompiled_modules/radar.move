module 0xd5e39c30c8f7e268804c1d7e330ec860da5da0f4cfcf31079ae13e01020d6eb3::radar {
    struct RADAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RADAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RADAR>(arg0, 6, b"Radar", b"RadarC", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733060160265.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RADAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RADAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

