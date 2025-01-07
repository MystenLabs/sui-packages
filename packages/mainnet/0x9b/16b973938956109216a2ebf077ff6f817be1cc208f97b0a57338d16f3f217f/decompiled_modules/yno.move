module 0x9b16b973938956109216a2ebf077ff6f817be1cc208f97b0a57338d16f3f217f::yno {
    struct YNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YNO>(arg0, 6, b"YNO", b"YuNo", b"Y U No Upvote my Memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000143493_8a929481c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

