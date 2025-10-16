module 0xb4a31cb622185dafb56067b663ee7dee8bdd6d120950488e05043947b5487fef::mist {
    struct MIST has key {
        id: 0x2::object::UID,
    }

    public fun create(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<MIST>(arg0, 6, 0x1::string::utf8(b"MIST"), 0x1::string::utf8(b"Mist"), 0x1::string::utf8(b"Fluid. Transparent. Adaptive. The essence of decentralized liquidity"), 0x1::string::utf8(b"https://node1.irys.xyz/E3xXfsgTvFKqG4UcRvohqX2kkqHuO3EOseakZvmeiZI"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MIST>>(0x2::coin_registry::finalize<MIST>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

