module 0xe687e863928e4573bfa2cbc014cabb47a22a4e70c4751c88decc7f95a07fbd49::aorun {
    struct AORUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AORUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AORUN>(arg0, 6, b"AORUN", b"AORUNGUGU", b"nninnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_169_84c3c1dba6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AORUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AORUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

