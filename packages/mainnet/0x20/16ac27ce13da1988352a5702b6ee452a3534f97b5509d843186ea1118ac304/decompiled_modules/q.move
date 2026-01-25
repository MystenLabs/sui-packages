module 0x2016ac27ce13da1988352a5702b6ee452a3534f97b5509d843186ea1118ac304::q {
    struct Q has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q>(arg0, 6, b"Q Coin", b"Q", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<Q>>(0x2::coin::mint<Q>(&mut v2, 1000000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<Q>>(v1);
    }

    // decompiled from Move bytecode v6
}

