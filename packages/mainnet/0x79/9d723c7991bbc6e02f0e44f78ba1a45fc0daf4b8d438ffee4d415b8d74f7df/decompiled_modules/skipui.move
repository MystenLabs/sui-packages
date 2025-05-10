module 0x799d723c7991bbc6e02f0e44f78ba1a45fc0daf4b8d438ffee4d415b8d74f7df::skipui {
    struct SKIPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIPUI>(arg0, 6, b"SKIPUI", b"SKIPENGUI", b"Ski Pingui is a fearless green penguin with ski goggles, ready to shred slopes and dominate the memecoin game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihpabm7skxn25foxldhg3crmx556g6pq5sbhpn37ze7z3rdwylpla")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIPUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKIPUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

