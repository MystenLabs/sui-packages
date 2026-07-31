module 0x1e8738548579eef4c426fbfb69defd07f6a3ba992e1dc4e44e378398194b3a21::usdc7 {
    struct USDC7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC7>(arg0, 9, b"USDC                   .", b"USDC                   .", b"USDC Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/CKYnWFGP/USDC2.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC7>>(0x2::coin::mint<USDC7>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC7>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDC7>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

