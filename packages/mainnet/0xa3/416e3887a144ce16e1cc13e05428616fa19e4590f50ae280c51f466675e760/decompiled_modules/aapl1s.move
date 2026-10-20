module 0xa3416e3887a144ce16e1cc13e05428616fa19e4590f50ae280c51f466675e760::aapl1s {
    struct AAPL1S has key {
        id: 0x2::object::UID,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create(arg0: CreatorCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<AAPL1S>, 0x2::coin::TreasuryCap<AAPL1S>) {
        let CreatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::coin_registry::new_currency<AAPL1S>(arg1, 9, arg3, arg2, arg4, arg5, arg6)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

