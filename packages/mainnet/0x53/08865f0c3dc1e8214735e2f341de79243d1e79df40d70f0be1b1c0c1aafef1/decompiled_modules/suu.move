module 0x5308865f0c3dc1e8214735e2f341de79243d1e79df40d70f0be1b1c0c1aafef1::suu {
    struct SUU has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUU>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUU>>(arg0, arg1);
    }

    fun init(arg0: SUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUU>(arg0, 9, b"SUU", b"sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUU>(&mut v2, 500000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUU>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

