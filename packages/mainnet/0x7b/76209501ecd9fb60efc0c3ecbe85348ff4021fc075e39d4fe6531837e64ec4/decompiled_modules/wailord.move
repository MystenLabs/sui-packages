module 0x7b76209501ecd9fb60efc0c3ecbe85348ff4021fc075e39d4fe6531837e64ec4::wailord {
    struct WAILORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAILORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAILORD>(arg0, 6, b"Wailord", b"WAILORD ON SUI", x"5761696c6f7264206973206f6e65206f6620746865206c61726765737420506f6bc3a96d6f6e20746f2068617665206265656e20646973636f76657265642e2044756520746f2069747320696d6d656e73652073697a652c2069742063616e206d616b65206769616e742073706c6173686573206279206a756d70696e67206f7574206f662074686520776174657220616e64207468656e206372617368696e67206261636b20646f776e2e2054686573652073686f636b776176657320616c6c6f77205761696c6f726420746f206b6e6f636b206f757420697473206f70706f6e656e747320616e6420686572642069747320707265792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieiorpshoc5zoquaqybnhjlqf45ljf2gpq2qnajdblp35m55w7cey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAILORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAILORD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

