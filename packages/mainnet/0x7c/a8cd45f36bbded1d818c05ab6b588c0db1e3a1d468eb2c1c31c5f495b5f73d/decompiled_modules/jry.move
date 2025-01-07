module 0x7ca8cd45f36bbded1d818c05ab6b588c0db1e3a1d468eb2c1c31c5f495b5f73d::jry {
    struct JRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JRY>(arg0, 6, b"Jry", b"jarry", b"a good dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731266531004.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

