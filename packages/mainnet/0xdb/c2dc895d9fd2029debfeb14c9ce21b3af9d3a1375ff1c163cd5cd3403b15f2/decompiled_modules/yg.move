module 0xdbc2dc895d9fd2029debfeb14c9ce21b3af9d3a1375ff1c163cd5cd3403b15f2::yg {
    struct YG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YG>(arg0, 6, b"YG", b"YoGa", b"for yoga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735316701141.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

