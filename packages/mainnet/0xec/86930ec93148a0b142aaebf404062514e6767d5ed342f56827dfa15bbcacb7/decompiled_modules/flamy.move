module 0xec86930ec93148a0b142aaebf404062514e6767d5ed342f56827dfa15bbcacb7::flamy {
    struct FLAMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAMY>(arg0, 6, b"FLAMY", b"Flamy Sui", b"There is s a blue flame coming to brighten the path.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiexorhykl2qkyyxckhf7rjl46ohmwenlh2dfjhsb7427ydffh3xpa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLAMY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

