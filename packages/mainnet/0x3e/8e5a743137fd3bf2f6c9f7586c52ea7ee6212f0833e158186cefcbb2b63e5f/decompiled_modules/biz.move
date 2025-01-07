module 0x3e8e5a743137fd3bf2f6c9f7586c52ea7ee6212f0833e158186cefcbb2b63e5f::biz {
    struct BIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIZ>(arg0, 6, b"BIZ", b"Bizkit", x"42697a6b6974200a0a546865205355492d545a550a0a5468652063757465737420646f67206f6e2053554920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7247_936866e77d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

