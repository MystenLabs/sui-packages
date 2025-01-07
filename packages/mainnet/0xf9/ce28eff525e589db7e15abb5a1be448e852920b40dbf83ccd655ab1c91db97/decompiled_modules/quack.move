module 0xf9ce28eff525e589db7e15abb5a1be448e852920b40dbf83ccd655ab1c91db97::quack {
    struct QUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACK>(arg0, 6, b"QUACK", b"QuantumQuack", x"48617665206e6f20666561722e2e205175616e74756d517561636b2069732068657265210a486520697320612053757065726865726f204475636b2077686f20646566656e64732074686520706f6f7220616e642074686520646566656e73656c657373210a4865206973206865726520746f20666967687420616c6c207468652076696c6c61696e73206f6e204d6f766550756d700a4a6f696e206869732074656c656772616d20736f206865206b6e6f7773207520617265206e6f742061206261642067757921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_4_a51debc276.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

