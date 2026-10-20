module 0x37ed98f245b19e6a4212c038087e8ba99186edb43852cf07f022b396e8e3867f::googl1s {
    struct GOOGL1S has key {
        id: 0x2::object::UID,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create(arg0: CreatorCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<GOOGL1S>, 0x2::coin::TreasuryCap<GOOGL1S>) {
        let CreatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::coin_registry::new_currency<GOOGL1S>(arg1, 9, arg3, arg2, arg4, arg5, arg6)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

