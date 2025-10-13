module 0xf0cd5e0be8cbd8e867299b5395f09dc4166e8a23c2aa78fed04d3e3b4370b93d::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 9, b"SS", b"Sample Share", b"sssssssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"1111111.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SS>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

