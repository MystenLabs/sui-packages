module 0x2b79ffdb52a09fb68a2b97d90df20aabd8fea964a120ee19431171d60abf0eeb::roge {
    struct ROGE has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0x859cd661db3f9fe9a298e5249bf7a64f162383a7120068d4e3663b70ba50d7b6
    }

    fun init(arg0: ROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ROGE>(arg0, 9, 0x1::string::utf8(b"ROGE"), 0x1::string::utf8(b"Ript Doge"), 0x1::string::utf8(b"Swole Doge + Ript = Ript Doge"), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafkreifxy72xt32kodzc6vnrjh6k6wewlwvceybhmzswvui4sr3t6ncl6a"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ROGE>>(0x2::coin_registry::finalize<ROGE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

