module 0xe7f1bec90164d319a8c8aa94d1da7adf8d2f874d827e2459659da3996088f291::mtk {
    struct MTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTK>(arg0, 9, b"MTK", b"My Token", b"My Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

