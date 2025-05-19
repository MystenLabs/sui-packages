module 0xb5442f575711b4849cfb565a5ea8d0340d4786bdb095712cd70614c6b4b7544a::mock {
    struct MOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK>(arg0, 6, b"MOCK", b"MOCKEREL GUY", b"I Dont know Who Am I ?! Im Just $Mock, Dont care anything.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidccvlzzcoykrvqtt5lqpwxn5ymr7sf7jay5uhg33hl4f7wsrufkq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

