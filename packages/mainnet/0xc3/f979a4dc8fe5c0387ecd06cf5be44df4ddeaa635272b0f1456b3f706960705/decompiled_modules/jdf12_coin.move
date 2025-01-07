module 0xc3f979a4dc8fe5c0387ecd06cf5be44df4ddeaa635272b0f1456b3f706960705::jdf12_coin {
    struct JDF12_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDF12_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::option::none<0x2::url::Url>();
        let (v0, v1) = 0x2::coin::create_currency<JDF12_COIN>(arg0, 8, b"jdf12", b"jdf12", b"this is jdf12_coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img0.baidu.com/it/u=1023821093,4105519612&fm=253&fmt=auto&app=138&f=JPEG?w=359&h=499")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDF12_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDF12_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

