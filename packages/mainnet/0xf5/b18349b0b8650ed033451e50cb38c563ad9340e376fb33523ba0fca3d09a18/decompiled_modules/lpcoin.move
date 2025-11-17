module 0xf5b18349b0b8650ed033451e50cb38c563ad9340e376fb33523ba0fca3d09a18::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 6, 0x1::string::utf8(b"CETUS-USDC Vault LPT"), 0x1::string::utf8(b"CETUS-USDC Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, CETUS-USDC Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/fDRJ2nDCvhju1EAQ8VMS7RuxsJRFl2VLCz1fzt6Df9A"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

