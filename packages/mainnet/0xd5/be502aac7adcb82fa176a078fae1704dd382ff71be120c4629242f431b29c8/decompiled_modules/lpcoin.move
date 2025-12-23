module 0xd5be502aac7adcb82fa176a078fae1704dd382ff71be120c4629242f431b29c8::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 6, 0x1::string::utf8(b"ETH-USDC Vault LPT"), 0x1::string::utf8(b"ETH-USDC Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, ETH-USDC Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/AsgmYwj4r2jNmfjHBktWEPJP1pLaamS-SMICcmFZQIc"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

