module 0x793db742a40aeb613597abab994d627c60e4861e9db9114e61b5c679b8249007::earn {
    struct EARN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARN>(arg0, 6, b"EARN", b"Buy Hold Earn", b"The Deflationary Rewards Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibsz2we254g3uqihlcmqezn66d56ws27xeluxl6brsgkvopch3dsa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EARN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

