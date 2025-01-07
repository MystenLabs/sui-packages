module 0xa507cf53298a4c397977c6bd6a6f530993e991b134a1a16d830621a8492160f2::jomc {
    struct JOMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOMC>(arg0, 6, b"JOMC", b"JustOneMoreCoin - by Lt. Columbo", x"4c69657574656e616e7420436f6c756d626f206172726976657320617420746865206d656d65207363656e652e0a0a2241682c206a757374206f6e65206d6f7265207468696e672e2e2e204272696e6720696e206a757374206f6e65206d6f726520667269656e642c20616e64207765276c6c20616c6c20676f20746f20746865206d6f6f6e2e0a492070726f6d69736520746f2072657665616c206d7920776966652773206e616d65206966207765206d616b6520697420746f2074686520746f7020323030206f6e20434d432e220a0a446f6e277420464f4d4f2c20627579206974204c4f572e2020234a7573744f6e654d6f7265436f696e20244a4f4d43", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fdfsfs_275b1c1750.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

