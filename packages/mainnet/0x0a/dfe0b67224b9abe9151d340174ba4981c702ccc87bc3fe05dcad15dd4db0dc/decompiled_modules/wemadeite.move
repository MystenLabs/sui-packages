module 0xadfe0b67224b9abe9151d340174ba4981c702ccc87bc3fe05dcad15dd4db0dc::wemadeite {
    struct CreateTicket has store, key {
        id: 0x2::object::UID,
    }

    struct WEMADEITE has key {
        id: 0x2::object::UID,
    }

    public fun create_hop_coin(arg0: CreateTicket, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<WEMADEITE>, 0x2::coin::TreasuryCap<WEMADEITE>) {
        let CreateTicket { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::coin_registry::new_currency<WEMADEITE>(arg1, 6, arg2, arg3, arg4, arg5, arg6)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateTicket{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CreateTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

