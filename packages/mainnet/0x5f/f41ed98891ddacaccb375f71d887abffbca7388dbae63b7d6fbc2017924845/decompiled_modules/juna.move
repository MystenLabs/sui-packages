module 0x5ff41ed98891ddacaccb375f71d887abffbca7388dbae63b7d6fbc2017924845::juna {
    struct JUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNA>(arg0, 6, b"JUNA", b"Juna Agent", b"Juna the Whale is an AI agent that aggregates on-chain data and tracks trends across the Key Opinion Leader (KOL) Twitter-sphere, providing valuable insights into cryptocurrency market dynamics.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidfvxiip4tvptj4iocukrfozot2q2z2wtsxjldx7xxcnirdni2f4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUNA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

