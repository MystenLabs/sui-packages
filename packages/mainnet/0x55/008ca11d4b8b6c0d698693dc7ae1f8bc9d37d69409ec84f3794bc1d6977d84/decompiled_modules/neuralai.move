module 0x55008ca11d4b8b6c0d698693dc7ae1f8bc9d37d69409ec84f3794bc1d6977d84::neuralai {
    struct NEURALAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURALAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEURALAI>(arg0, 6, b"NEURALAI", b"Spectre Neural System AI", x"53706563747265204e657572616c2053797374656d20414920697320796f757220616c6c2d696e2d6f6e65206d6f62696c6520736f6c7574696f6e20666f72206372656174696e6720616e64206d616e6167696e672041492d64726976656e207669727475616c206167656e74732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_CKYHB_En_400x400_9a8c35bb6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURALAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEURALAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

