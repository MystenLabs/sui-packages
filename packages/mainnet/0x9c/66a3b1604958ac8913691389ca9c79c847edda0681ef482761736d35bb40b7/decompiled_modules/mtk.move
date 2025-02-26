module 0x9c66a3b1604958ac8913691389ca9c79c847edda0681ef482761736d35bb40b7::mtk {
    struct MTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTK>(arg0, 9, b"MTK", b"My Token", b"Just another Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MTK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

