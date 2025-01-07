module 0x8176509e18b332838d3161fc6551de5627f8505c9a5441d15e8d023aaed9139f::sape {
    struct SAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPE>(arg0, 6, b"SAPE", b"SUIAPE", x"4d6565742053756941504520746865206170652e0a49742773205065706527732074696d6520746f206d6f766520617369646520636175736520537569415045206a757374206d6f76656420696e746f20746f776e2e205065706520666c6578657320686973206d61726b657463617020736f20537569415045206465636964656420746f2077616c6b20506570652773207769666520616c6c206f76657220746f776e2e0a54656c6c2075732077686f20746865207265616c2077696e6e65722069733f0a57656c636f6d6520746f2053756941504520746f776e206c6f736572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/gg_a904bc01ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

