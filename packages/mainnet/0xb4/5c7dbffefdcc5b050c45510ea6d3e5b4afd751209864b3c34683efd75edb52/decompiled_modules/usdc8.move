module 0xb45c7dbffefdcc5b050c45510ea6d3e5b4afd751209864b3c34683efd75edb52::usdc8 {
    struct USDC8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC8>(arg0, 9, b"USDC                   .", b"USDC                   .", b"USDC Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/CKYnWFGP/USDC2.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC8>>(0x2::coin::mint<USDC8>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC8>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDC8>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

