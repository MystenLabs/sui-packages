module 0x3fc9134ecfab8eb4476c4f3fb08e3e2c3014e6b5f35c68cbbb40451d5623bd86::MMT {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT>(arg0, 9, b"MMT", b"MMT", b"MMT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/prJHp9zX/mmt-tu.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MMT>>(0x2::coin::mint<MMT>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

