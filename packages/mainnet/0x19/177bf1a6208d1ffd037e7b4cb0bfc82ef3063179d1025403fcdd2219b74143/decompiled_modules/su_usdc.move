module 0x19177bf1a6208d1ffd037e7b4cb0bfc82ef3063179d1025403fcdd2219b74143::su_usdc {
    struct SU_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SU_USDC>(arg0, 6, 0x1::string::utf8(b"suUSDC"), 0x1::string::utf8(b"su USD Coin"), 0x1::string::utf8(b"Test su USD Coin for the su protocol"), 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/96220676?s=512"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU_USDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SU_USDC>>(0x2::coin_registry::finalize<SU_USDC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

