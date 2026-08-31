module 0x4cdc1aa2fc9bdd69cc36fad0dc8b85bdb0cb8fa2ca088682e2e4f15c15f850a2::MMT3 {
    struct MMT3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT3>(arg0, 9, b"MMT", b"MMT", b"MMT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/prJHp9zX/mmt-tu.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MMT3>>(0x2::coin::mint<MMT3>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT3>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMT3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

