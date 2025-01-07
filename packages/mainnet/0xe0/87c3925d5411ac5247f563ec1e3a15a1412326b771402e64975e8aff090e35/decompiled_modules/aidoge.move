module 0xe087c3925d5411ac5247f563ec1e3a15a1412326b771402e64975e8aff090e35::aidoge {
    struct AIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOGE>(arg0, 6, b"AIDOGE", b"AiDoge On Sui", b"New SUI gamble play, find your entries, might do good, dyor.  AiDoge Where memes meet AI mastery. Smart, fun, and unleashing the future of meme innovation!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241218_003614_596_7773052ce4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

