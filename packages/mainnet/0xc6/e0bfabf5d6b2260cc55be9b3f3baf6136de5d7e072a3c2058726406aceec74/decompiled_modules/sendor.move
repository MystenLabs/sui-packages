module 0xc6e0bfabf5d6b2260cc55be9b3f3baf6136de5d7e072a3c2058726406aceec74::sendor {
    struct SENDOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENDOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENDOR>(arg0, 6, b"Sendor", b"Sendor Sui", b"Ultra Giga Chad of Suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiat6qzu24dwpozivnej2ukfhpekshpqjn67h7yhoyxmbwdmkt23a4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENDOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SENDOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

