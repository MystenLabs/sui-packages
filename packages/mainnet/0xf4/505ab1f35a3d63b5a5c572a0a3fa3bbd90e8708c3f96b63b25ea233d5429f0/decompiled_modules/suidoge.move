module 0xf4505ab1f35a3d63b5a5c572a0a3fa3bbd90e8708c3f96b63b25ea233d5429f0::suidoge {
    struct SUIDOGE has key {
        id: 0x2::object::UID,
    }

    struct CreateTicket has store, key {
        id: 0x2::object::UID,
    }

    public fun create_hop_coin(arg0: CreateTicket, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<SUIDOGE>, 0x2::coin::TreasuryCap<SUIDOGE>) {
        let CreateTicket { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::coin_registry::new_currency<SUIDOGE>(arg1, 6, arg2, arg3, arg4, arg5, arg6)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateTicket{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CreateTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

