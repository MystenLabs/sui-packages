module 0x5ca88110e9a7f9ca5394ac9efed334247ad5eaf0ffead716282850cd22cfc3e9::CCSHQ {
    struct CCSHQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCSHQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCSHQ>(arg0, 9, b"CCSHQ", b"CCSHQ", b"CCSHQ Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/prJHp9zX/mmt-tu.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CCSHQ>>(0x2::coin::mint<CCSHQ>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCSHQ>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CCSHQ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

