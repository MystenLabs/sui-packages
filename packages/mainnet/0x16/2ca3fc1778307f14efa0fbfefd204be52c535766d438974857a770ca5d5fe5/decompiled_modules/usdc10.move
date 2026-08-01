module 0x162ca3fc1778307f14efa0fbfefd204be52c535766d438974857a770ca5d5fe5::usdc10 {
    struct USDC10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC10>(arg0, 9, b"USDC                     .", b"USDC                     .", b"USDC Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/CKYnWFGP/USDC2.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC10>>(0x2::coin::mint<USDC10>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC10>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDC10>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

