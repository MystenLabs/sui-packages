module 0xba4337bedef325d100b12217594684d227f5f3ea73f775e59318760a1eb7b2f1::brain {
    struct BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIN>(arg0, 6, b"BRAIN", b"Brain Boost", b"Brain Boost - contributing towards a less retarded future through memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicb347kswjy2ztz5witaoikrt3gwszrygcntbx7aon5gbjyuovlhm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRAIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

