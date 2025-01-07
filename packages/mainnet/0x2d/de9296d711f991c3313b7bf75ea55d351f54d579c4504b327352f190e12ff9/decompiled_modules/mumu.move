module 0x2dde9296d711f991c3313b7bf75ea55d351f54d579c4504b327352f190e12ff9::mumu {
    struct MUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMU>(arg0, 6, b"MUMU", b"Mumu the Sui Bull", x"546865206d6173636f74206f6620746865205375692062756c6c206d61726b657420616e64206865726f20626568696e6420677265656e2063616e646c657320657665727977686572652e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bull_new_86f7c9f3ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

