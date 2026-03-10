module 0x704603133d52ee304def44b0300bea90c6b5946e07092f6b6d3a04d2a8af0857::hoppie {
    struct HOPPIE has key {
        id: 0x2::object::UID,
    }

    struct CreateTicket has store, key {
        id: 0x2::object::UID,
    }

    public fun create_hop_coin(arg0: CreateTicket, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<HOPPIE>, 0x2::coin::TreasuryCap<HOPPIE>) {
        let CreateTicket { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::coin_registry::new_currency<HOPPIE>(arg1, 6, arg2, arg3, arg4, arg5, arg6)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateTicket{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CreateTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

