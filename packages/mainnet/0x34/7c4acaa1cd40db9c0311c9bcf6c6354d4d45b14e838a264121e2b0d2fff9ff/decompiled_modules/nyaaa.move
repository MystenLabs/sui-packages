module 0x347c4acaa1cd40db9c0311c9bcf6c6354d4d45b14e838a264121e2b0d2fff9ff::nyaaa {
    struct NYAAA has key {
        id: 0x2::object::UID,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create(arg0: CreatorCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<NYAAA>, 0x2::coin::TreasuryCap<NYAAA>) {
        let CreatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::coin_registry::new_currency<NYAAA>(arg1, 6, arg3, arg2, arg4, arg5, arg6)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

