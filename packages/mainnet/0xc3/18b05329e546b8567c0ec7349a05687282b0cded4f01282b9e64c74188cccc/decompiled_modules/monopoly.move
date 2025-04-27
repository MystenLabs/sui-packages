module 0xc318b05329e546b8567c0ec7349a05687282b0cded4f01282b9e64c74188cccc::monopoly {
    struct MONOPOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONOPOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONOPOLY>(arg0, 6, b"MONOPOLY", b"TRUMPOPOLY", b"CRYPTO CAPITAL OF THE WORLDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidioep4z2q5f23m6qku6nx6m6grf2f7hnjkzhuyqevh3txf2aed44")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONOPOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONOPOLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

