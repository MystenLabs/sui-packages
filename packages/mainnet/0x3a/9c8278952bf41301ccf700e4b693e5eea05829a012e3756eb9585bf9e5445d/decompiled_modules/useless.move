module 0x3a9c8278952bf41301ccf700e4b693e5eea05829a012e3756eb9585bf9e5445d::useless {
    struct USELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: USELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USELESS>(arg0, 6, b"USELESS", b"USELESS COIN", b"We made a coin. It does nothing. You're welcome.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiduzfnk7zcmqm4unmdymepa5z3jcbhqiapvaqh62u2k3625dqf7oe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USELESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USELESS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

