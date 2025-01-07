module 0x4cd774fbce76c3e6d86ec6adc8d3c30bf0f29d07a80659cbeba7e8500516261::siniu {
    struct SINIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINIU>(arg0, 6, b"SINIU", b"Satoshi Inu", b"The official SATOSHI INU, INSPIRED BY THE HBO DOCUMENTARY \"MONEY ELECTRIC'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_02_34_09_ee1259e944.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

