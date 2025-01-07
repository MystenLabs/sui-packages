module 0xd0a5edd837ecd4fe33658e9d8175b72a535ab41cc2ab6166c3bb9ff0e809ae18::gigaai {
    struct GIGAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGAAI>(arg0, 6, b"GIGAAI", b"GIGA AI", x"576974682024474947412041492c207765206861726e6573732074686520696e66696e697465206379636c6573206f66206879706520616e64206d656d657320746f2067656e657261746520756e706172616c6c656c656420636f6d6d756e69747920656e676167656d656e7420616e64206578706f6e656e7469616c2067726f7774682e20546869732069732074686520636f696e20666f722074686f73652077686f206e65766572206d6973732061206265617420616e642072696465206576657279207761766520746f20746865206d6f6f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GIGA_AI_3_5ce1918151.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

