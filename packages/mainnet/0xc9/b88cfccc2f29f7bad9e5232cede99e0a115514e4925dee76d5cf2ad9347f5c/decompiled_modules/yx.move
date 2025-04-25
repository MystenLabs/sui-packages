module 0xc9b88cfccc2f29f7bad9e5232cede99e0a115514e4925dee76d5cf2ad9347f5c::yx {
    struct YX has drop {
        dummy_field: bool,
    }

    fun init(arg0: YX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YX>(arg0, 9, b"YX", b"YOXO", b"This coin meme coin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3c8a640b7a9f1c6c83a9aa7415d41991blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

