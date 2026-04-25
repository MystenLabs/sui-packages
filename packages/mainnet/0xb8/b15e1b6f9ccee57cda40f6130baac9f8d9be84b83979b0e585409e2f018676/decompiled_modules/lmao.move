module 0xb8b15e1b6f9ccee57cda40f6130baac9f8d9be84b83979b0e585409e2f018676::lmao {
    struct CreateTicket has store, key {
        id: 0x2::object::UID,
    }

    struct LMAO has key {
        id: 0x2::object::UID,
    }

    public fun create_hop_coin(arg0: CreateTicket, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<LMAO>, 0x2::coin::TreasuryCap<LMAO>) {
        let CreateTicket { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::coin_registry::new_currency<LMAO>(arg1, 6, arg2, arg3, arg4, arg5, arg6)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateTicket{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CreateTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

