module 0xe044ab4ae8300d495a67f20aaf453228f4601e05ffcdadbf464fe7967256d41a::mtk {
    struct MTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTK>(arg0, 9, b"MTK", b"My Token", b"A token created with Sui Token Creator", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MTK>>(0x2::coin::mint<MTK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

