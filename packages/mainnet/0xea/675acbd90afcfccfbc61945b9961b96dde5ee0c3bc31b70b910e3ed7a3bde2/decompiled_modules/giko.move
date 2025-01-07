module 0xea675acbd90afcfccfbc61945b9961b96dde5ee0c3bc31b70b910e3ed7a3bde2::giko {
    struct GIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIKO>(arg0, 9, b"GIKO", b"Giko Cat", x"2447494b4f20546865206669727374207c20282c2cefbe9fd094efbe9f2920e8a18ce381a3e381a6e38288e38197", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1805218998768070656/K7qZiSK1_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIKO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

