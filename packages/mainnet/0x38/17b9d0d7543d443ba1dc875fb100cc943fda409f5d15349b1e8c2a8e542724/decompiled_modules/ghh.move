module 0x3817b9d0d7543d443ba1dc875fb100cc943fda409f5d15349b1e8c2a8e542724::ghh {
    struct GHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHH>(arg0, 9, b"Ghh", b"test111", b"111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/67e6fc495ce9d7cfe095ef7d94a5fde8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

