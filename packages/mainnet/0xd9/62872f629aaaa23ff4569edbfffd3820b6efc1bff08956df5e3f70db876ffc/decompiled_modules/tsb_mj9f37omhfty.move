module 0xd962872f629aaaa23ff4569edbfffd3820b6efc1bff08956df5e3f70db876ffc::tsb_mj9f37omhfty {
    struct TSB_MJ9F37OMHFTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSB_MJ9F37OMHFTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSB_MJ9F37OMHFTY>(arg0, 9, b"TSB", b"TESTING BONDING", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmekajsUio7j3u1iQXQFdb15kqLsWwKwFyjP6mYNZkXqcb")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSB_MJ9F37OMHFTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSB_MJ9F37OMHFTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

