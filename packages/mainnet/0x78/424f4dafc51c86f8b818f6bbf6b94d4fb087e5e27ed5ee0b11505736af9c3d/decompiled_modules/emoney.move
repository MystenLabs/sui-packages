module 0x78424f4dafc51c86f8b818f6bbf6b94d4fb087e5e27ed5ee0b11505736af9c3d::emoney {
    struct EMONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMONEY>(arg0, 9, b"EMONEY", b"Money Electric", b"Money Electric is a fast, efficient token on the Sui blockchain, designed for quick transactions and low fees. It powers decentralized apps, symbolizing the future of digital finance in the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1649204300101427203/H9egs3l5.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EMONEY>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMONEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

