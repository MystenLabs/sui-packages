module 0x39b0de8936ce7a590b8554c0e5f982bfb7fe821c7e8b51b4606dbba9c8b64cda::composition_share {
    struct CompositionShare has key {
        id: 0x2::object::UID,
    }

    struct InitializeCurrencyTicket has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitializeCurrencyTicket{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<InitializeCurrencyTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: InitializeCurrencyTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<CompositionShare> {
        let InitializeCurrencyTicket { id: v0 } = arg1;
        0x2::object::delete(v0);
        let (v1, v2) = 0x2::coin_registry::new_currency<CompositionShare>(arg0, 6, 0x1::string::utf8(b"CSHARE"), 0x1::string::utf8(b"Composition Share"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CompositionShare>(v1, arg2);
        v2
    }

    // decompiled from Move bytecode v7
}

