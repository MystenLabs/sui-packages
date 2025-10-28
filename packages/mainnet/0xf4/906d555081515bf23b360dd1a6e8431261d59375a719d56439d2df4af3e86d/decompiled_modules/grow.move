module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::grow {
    struct GROW has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GROW>, arg1: 0x2::coin::Coin<GROW>) {
        0x2::coin::burn<GROW>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GROW>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GROW>>(0x2::coin::mint<GROW>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: GROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GROW>(arg0, 9, 0x1::string::utf8(b"GROW"), 0x1::string::utf8(b"Grow Coin"), 0x1::string::utf8(b"Grow Coin"), 0x1::string::utf8(b"https://grow.coin.xyz"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GROW>>(0x2::coin_registry::finalize<GROW>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROW>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<GROW>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<GROW>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

