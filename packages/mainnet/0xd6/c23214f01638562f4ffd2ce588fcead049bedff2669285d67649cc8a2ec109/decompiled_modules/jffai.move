module 0xd6c23214f01638562f4ffd2ce588fcead049bedff2669285d67649cc8a2ec109::jffai {
    struct JFFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFFAI>(arg0, 2, b"JFFAI", b"just for fun AI", b"JFF ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JFFAI>(&mut v2, 2100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFFAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFFAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

