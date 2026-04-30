module 0xa4a4397ff93e0cb3f942c885fbf56edf7bafac7b3d6ff68a30a525bdf0c85515::crush {
    struct CRUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUSH>(arg0, 6, b"CRUSH", b"Scam Crusher", b"The official utility token for Scam Crusher Protocol on Sui. Fueling the destruction of scam NFTs. Burn to evolve, hold to earn. Powered by Walrus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiassogcz7mvdaj3z5kzqc4ew4a3zg2pkmhw7sjifq37vvgsnkkkzy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRUSH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

