module 0x9304a04afd60e2f99b0dcfa95c5bd9e78c92ad91d274163d68553c66a068775e::yub {
    struct YUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUB>(arg0, 6, b"Yub", b"Yubid Yub", b"yubid yub yub yub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_img_1_0f7841f36b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

