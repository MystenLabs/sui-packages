module 0x94952228b05e7e3c05fcb39063f8f0b4fedf884319c84bbb252b66cedeaaeb9f::bigbrain {
    struct BIGBRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGBRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGBRAIN>(arg0, 6, b"BIGBRAIN", b"Big Brain", x"446567656e696e67206f6e204d6f76652050756d703f2042696720427261696e210a486f646c696e67205375693f2042696720427261696e210a466164696e6720796f7572206d6f7468657220696e206c61773f2042696720427261696e2021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030456_c93ad9c31b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGBRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGBRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

