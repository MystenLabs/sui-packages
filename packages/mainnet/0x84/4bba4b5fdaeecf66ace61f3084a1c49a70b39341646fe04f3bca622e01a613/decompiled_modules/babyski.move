module 0x844bba4b5fdaeecf66ace61f3084a1c49a70b39341646fe04f3bca622e01a613::babyski {
    struct BABYSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSKI>(arg0, 9, b"BABYSKI", b"BABY SKI MASK DOG", b"BABY SKI MASK DOG meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreie6it5d3j46qag3yv3dqx2e5gut5bahvbaw5q55j3q2s5tsazdlke.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYSKI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYSKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSKI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

