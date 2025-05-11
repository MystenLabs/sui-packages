module 0x3b21fdad88ecc76591dfc1ae724325db16817c1caa1a5ae91cb2298082e0d23d::pikasui {
    struct PIKASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKASUI>(arg0, 6, b"PIKASUI", b"PikaSui Coin", b"Pika got zapped by a huge lightning and turned blue so he decided to join the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie3xhnmled5wab762zraz7wab7u5igha45kyp5od3ffd2gbkqyeem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIKASUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

