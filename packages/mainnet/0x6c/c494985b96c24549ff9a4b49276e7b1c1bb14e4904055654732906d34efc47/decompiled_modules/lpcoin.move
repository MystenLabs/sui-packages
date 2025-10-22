module 0x6cc494985b96c24549ff9a4b49276e7b1c1bb14e4904055654732906d34efc47::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    public fun finalize<T0>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<T0>(arg0, arg1, arg2);
    }

    public fun immutable<T0>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: 0x2::coin_registry::MetadataCap<T0>) {
        0x2::coin_registry::delete_metadata_cap<T0>(arg0, arg1);
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LPCOIN>(arg0, 6, 0x1::string::utf8(b"SUI-USDC Vault LPT"), 0x1::string::utf8(b"SUI-USDC Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, SUI-USDC Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/TZD49BnoQJTbSIsGi_qfnzfN0MuCE17hYMeOWaMqpEs"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

