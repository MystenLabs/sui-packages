module 0xed377265ad740267a3b82422d1021e622318656f4c553af289f6590be82377fe::saul {
    struct SAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAUL>(arg0, 6, b"SAUL", b"Better Call SUI!", x"4265747465722063616c6c2053554921200a0a4861766520796f75206265656e206d6973756e64657273746f6f643f204361756768742072656468616e6465643f2050657268617073206d697374616b656e6c7920736f6c64206261627920706f7764657220666f722e2e2e2e2e2e2e746865206f6c20436861726c69652e2e2e2e2e696620736f2c204245545445522043414c4c2053554921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7c3xv6iytfd51_9c533a7fde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

