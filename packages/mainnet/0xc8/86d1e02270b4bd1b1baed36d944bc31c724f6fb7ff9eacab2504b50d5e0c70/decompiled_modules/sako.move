module 0xc886d1e02270b4bd1b1baed36d944bc31c724f6fb7ff9eacab2504b50d5e0c70::sako {
    struct SAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKO>(arg0, 6, b"SAKO", b"SAKO TOSHI", x"53616b6f20697320546f73686973206461726b206d6972726f722e200a576865726520546f736869207374616e647320666f7220666169726e6573732c2053616b6f0a74687269766573206f6e206d616e6970756c6174696f6e20616e64206368616f732c0a77656176696e6720736368656d657320746f20646573746162696c697a6520616e640a646f6d696e617465207468652063727970746f20776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7988_7849e33761.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

