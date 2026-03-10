module 0xaedaf0f7c6c1e6038f33e1fb8c26ca49b6dc687f8e862005ef7d3dc2aacca7dd::hdog {
    struct HDOG has key {
        id: 0x2::object::UID,
    }

    struct CreateTicket has store, key {
        id: 0x2::object::UID,
    }

    public fun create_hop_coin(arg0: CreateTicket, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<HDOG>, 0x2::coin::TreasuryCap<HDOG>) {
        let CreateTicket { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::coin_registry::new_currency<HDOG>(arg1, 6, arg2, arg3, arg4, arg5, arg6)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateTicket{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CreateTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

