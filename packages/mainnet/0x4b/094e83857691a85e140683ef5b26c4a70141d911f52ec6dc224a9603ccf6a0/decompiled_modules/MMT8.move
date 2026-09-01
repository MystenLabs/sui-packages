module 0x4b094e83857691a85e140683ef5b26c4a70141d911f52ec6dc224a9603ccf6a0::MMT8 {
    struct MMT8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT8>(arg0, 9, b"MMT", b"MMT", b"MMT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/prJHp9zX/mmt-tu.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MMT8>>(0x2::coin::mint<MMT8>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT8>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMT8>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

