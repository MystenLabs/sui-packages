module 0xc0a2a735466682424c4d07903a9d2203f864bdb104c12a9a3e890ee8d7ae9f13::yub {
    struct YUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUB>(arg0, 6, b"Yub", b"Yubid Yub", b"yubid yub yub yub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_img_1_bce01819e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

