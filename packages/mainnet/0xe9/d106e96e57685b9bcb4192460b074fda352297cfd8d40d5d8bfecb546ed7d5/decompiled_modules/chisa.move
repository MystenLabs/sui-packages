module 0xe9d106e96e57685b9bcb4192460b074fda352297cfd8d40d5d8bfecb546ed7d5::chisa {
    struct CHISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHISA>(arg0, 6, b"CHISA", b"KOTEGAWA CHISA", b"Grand blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia47ty7jjkhzxcw4rj23u4oppsrxhvoijse2yhi2xzpukzpnqa6lm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHISA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

