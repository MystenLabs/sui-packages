module 0x57776b5445052ccd97d3844985fbd105f1aeb28cffc8f4cf346b602be2d6bd1a::shitcoin {
    struct SHITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITCOIN>(arg0, 6, b"SHITCOIN", b"Shitcoin On Sui", b"Pure crap. Absolute gold. $SHITCOIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieaizag7tls66an2rz67zbu7feu3qo7uqembxjmot257rf6wc6lmy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHITCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

