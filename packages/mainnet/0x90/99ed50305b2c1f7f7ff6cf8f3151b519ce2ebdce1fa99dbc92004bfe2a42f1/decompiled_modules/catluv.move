module 0x9099ed50305b2c1f7f7ff6cf8f3151b519ce2ebdce1fa99dbc92004bfe2a42f1::catluv {
    struct CATLUV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATLUV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATLUV>(arg0, 6, b"Catluv", b"Catmeme", b"Lorem ipsum odor amet, consectetuer adipiscing elit. Convallis purus placerat fringilla fringilla ridiculus laoreet; aptent bibendum. Habitasse dolor sit integer sodales; elit proin et orci dapibus. Diam magnis neque viverra pulvinar libero. Ligula elit tempor orci dignissim lacinia ridiculus dictumst tellus. Facilisis auctor sollicitudin curabitur; fringilla pharetra dapibus auctor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBVAXGJ5QWZFF04ERMBMSZEF/01JCAZZGK10BAJ34NXFZQH832P")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATLUV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATLUV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

