module 0x304492f402c624b936bdf071ae4cc60baf7b28fcd3a7ca661d94b094eaa6eb0b::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 6, 0x1::string::utf8(b"WAL-USDC Vault LPT"), 0x1::string::utf8(b"WAL-USDC Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, WAL-USDC Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/Mg3l6CyMGJXkJ1Gx919T6otWXSZ95RLAufsk6M_fljA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

