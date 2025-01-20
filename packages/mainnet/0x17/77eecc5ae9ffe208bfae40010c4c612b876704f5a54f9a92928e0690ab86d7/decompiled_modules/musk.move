module 0x1777eecc5ae9ffe208bfae40010c4c612b876704f5a54f9a92928e0690ab86d7::musk {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 9, b"MUSK", b"OFFICIAL MUSK", x"4a6f696e20746865204d75736b20436f6d6d756e6974792e205468697320697320486973746f727920696e20746865204d616b696e67210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW71sFVXFzQEWA5M8LNsvcap8XxrFyCzcQVqzGyc2RNSV")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUSK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

