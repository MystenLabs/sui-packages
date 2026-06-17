module 0x5b31779a4336984d003cadf5a91e99afbb8d460bc9987d869b197c2365d46c8f::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 9, 0x1::string::utf8(b"LBTC-SUI Vault LPT"), 0x1::string::utf8(b"LBTC-SUI Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, LBTC-SUI Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/-CIyJycPqRHU1xnI0eJLtccVFr3PJDX_Ahz7Mlh8Pvo"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

