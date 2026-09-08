module 0x3a9a8a8e5f7329b28a5ed3bb8eff4f790b6e872ddd19459478c6d2cf606b82a9::MMT02 {
    struct MMT02 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT02, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT02>(arg0, 9, b"MMT", b"MMT", b"MMT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/prJHp9zX/mmt-tu.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MMT02>>(0x2::coin::mint<MMT02>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMT02>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT02>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

