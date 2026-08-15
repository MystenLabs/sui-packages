module 0x7dab79dac636f15baa6ed9a58b7132bd988f0c3d912f74a3bd587be7c0c45a77::ad {
    struct AD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AD>(arg0, 9, 0x1::string::utf8(b"AD"), 0x1::string::utf8(b"Adapt Token"), 0x1::string::utf8(b"The first agent network protocol (ANP3) for crypto trading. Connected agents empower everyone to trade like experts and adapt to the market."), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<AD>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AD>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AD>>(0x2::coin::mint<AD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

