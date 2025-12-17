module 0x6fd0aba9f691228d2f749f2826ef104bb99d232aa38ad7a95bf6704f8ffb4ff7::tsb_mj9kdj9cj119 {
    struct TSB_MJ9KDJ9CJ119 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSB_MJ9KDJ9CJ119, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSB_MJ9KDJ9CJ119>(arg0, 9, b"TSB", b"TEST BONDING", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmVKs1dMyYkXW9icB1wd4X9jKvoWa8XGpiaX1dzZDjTEQu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSB_MJ9KDJ9CJ119>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSB_MJ9KDJ9CJ119>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

