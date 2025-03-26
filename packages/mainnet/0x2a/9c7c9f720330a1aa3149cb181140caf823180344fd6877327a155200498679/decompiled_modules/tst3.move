module 0x2a9c7c9f720330a1aa3149cb181140caf823180344fd6877327a155200498679::tst3 {
    struct TST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST3>(arg0, 6, b"TST3", b"test3", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

