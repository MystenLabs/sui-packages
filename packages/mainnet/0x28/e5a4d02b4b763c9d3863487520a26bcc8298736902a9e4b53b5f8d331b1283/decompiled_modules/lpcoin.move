module 0x28e5a4d02b4b763c9d3863487520a26bcc8298736902a9e4b53b5f8d331b1283::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 6, 0x1::string::utf8(b"DEEP-USDC Vault LPT"), 0x1::string::utf8(b"DEEP-USDC Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, DEEP-USDC Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/chUcvcXOMvfXs_DJuQ3Xuhli9We5WrFeFe1x0HbDqfs"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

