module 0xbbaf8eb21dafa920f65dd23bcff1cd5f0bc91397c7052484de9f2c6b2e3df40a::puccn {
    struct PUCCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCCN>(arg0, 9, b"PUCCN", b"PUCCOIN", x"2241206e6f7661206d6f656461206469676974616c207265766f6c7563696f6ec3a17269612070617261206573747564616e74657320756e69766572736974c3a172696f732c20666163696c6974616e646f207472616e7361c3a7c3b565732072c3a17069646173206520736567757261732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUCCN>(&mut v2, 1500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCCN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUCCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

