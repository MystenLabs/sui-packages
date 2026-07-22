module 0x4b28064601e34b22c2b830a509bc8400c41e2b258814bfd349226c6eba3c20a7::usdc4 {
    struct USDC4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC4>(arg0, 9, x"5553444309", x"5553444309", x"555344430920546f6b656e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/CKYnWFGP/USDC2.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC4>>(0x2::coin::mint<USDC4>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC4>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDC4>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

