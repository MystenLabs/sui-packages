module 0x56b21da73ce04e591f0710af922cc9fdb030a9c6004fe6a75dd41f109c422af5::atest {
    struct ATEST has key {
        id: 0x2::object::UID,
    }

    public fun create(arg0: ATEST, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<ATEST>, 0x2::coin::TreasuryCap<ATEST>) {
        let ATEST { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::coin_registry::new_currency<ATEST>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ATEST{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ATEST>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

