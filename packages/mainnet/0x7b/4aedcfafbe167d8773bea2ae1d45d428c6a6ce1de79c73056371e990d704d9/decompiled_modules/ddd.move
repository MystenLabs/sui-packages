module 0x7b4aedcfafbe167d8773bea2ae1d45d428c6a6ce1de79c73056371e990d704d9::ddd {
    struct DDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDD>(arg0, 6, b"DDD", b"Delay Delay Deploy", b"Delay Delay Delay never Deploy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000103793_cd621a1eb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

