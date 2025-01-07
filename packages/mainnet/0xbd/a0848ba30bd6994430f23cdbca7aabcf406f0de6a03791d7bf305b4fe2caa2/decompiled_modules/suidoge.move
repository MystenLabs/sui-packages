module 0xbda0848ba30bd6994430f23cdbca7aabcf406f0de6a03791d7bf305b4fe2caa2::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGE>(arg0, 6, b"SUIDOGE", b"Sui Doge", x"4672657368206f7574206f66207468652077617465722e204e6577626f726e20535549444f474520726f6c6c7320696e207468652073616e6420616e6420656e6a6f79207468652068656174206f66207468652073756e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/br_L6ox_v_400x400_0365110ab3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

