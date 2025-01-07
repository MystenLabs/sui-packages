module 0x59260f3455825dd884971308513f280a98726c93f5650faf32906458072afa1::ps530th {
    struct PS530TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PS530TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PS530TH>(arg0, 6, b"PS530th", b"PS5 30th", b"PS5 30th anniversary pre-orders ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_453_9df03361df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PS530TH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PS530TH>>(v1);
    }

    // decompiled from Move bytecode v6
}

