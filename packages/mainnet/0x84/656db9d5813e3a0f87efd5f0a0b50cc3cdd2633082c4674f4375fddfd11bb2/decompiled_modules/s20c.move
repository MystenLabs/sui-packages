module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::s20c {
    struct S20C has drop {
        dummy_field: bool,
    }

    fun do_init(arg0: S20C, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<S20C> {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<S20C>(arg0, 6, 0x1::string::utf8(b"S20C"), 0x1::string::utf8(b"SUI20 Core"), 0x1::string::utf8(b"Top 20 liquid Sui tokens, float-cap weighted with 15% per-name cap. Weekly rebalance."), 0x1::string::utf8(b"https://pbs.twimg.com/profile_images/2054281997011275776/ag5KQZtW_400x400.jpg"), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<S20C>(v0, arg1);
        v1
    }

    fun init(arg0: S20C, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = do_init(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S20C>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

