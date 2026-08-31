module 0xea46fc7acffcc381b4766f631259945aff20c3f67ea978141a5721fc33c2223e::MMT5 {
    struct MMT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT5>(arg0, 9, b"MMT", b"MMT", b"MMT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/prJHp9zX/mmt-tu.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MMT5>>(0x2::coin::mint<MMT5>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT5>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMT5>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

