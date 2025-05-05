module 0xeec9b93b2eb7c4f2ceb62a32471811de4cd5b1865c3d4d85c9ac69920ec31dd6::hat {
    struct HAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAT>(arg0, 6, b"HAT", b"BaseHat", b"The sun is hot, however it is healthy, but if you wear a hat, it will be much safer for your skin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250505_193508_433d53c4ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

