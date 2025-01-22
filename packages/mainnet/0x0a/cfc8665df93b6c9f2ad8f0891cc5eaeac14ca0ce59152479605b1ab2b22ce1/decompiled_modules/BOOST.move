module 0xacfc8665df93b6c9f2ad8f0891cc5eaeac14ca0ce59152479605b1ab2b22ce1::BOOST {
    struct BOOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOST>(arg0, 9, b"BOOST", b"BOOST", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://graiscale.fun/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOOST>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOST>>(0x2::coin::mint<BOOST>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

