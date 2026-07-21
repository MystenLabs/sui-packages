module 0x8d6bf433aa658c453aa560c3c9fcbd72ae14c39fbffa9de13fdff7dc745d4fec::usdc3 {
    struct USDC3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC3>(arg0, 9, b"USDC .", b"USDC .", x"f090938ecd8fe1b2bdcd8fea9393cd8f4320546f6b656e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/CKYnWFGP/USDC2.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC3>>(0x2::coin::mint<USDC3>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC3>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDC3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

