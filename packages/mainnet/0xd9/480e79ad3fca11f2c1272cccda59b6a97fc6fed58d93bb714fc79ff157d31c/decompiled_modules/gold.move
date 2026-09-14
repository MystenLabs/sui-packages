module 0xd9480e79ad3fca11f2c1272cccda59b6a97fc6fed58d93bb714fc79ff157d31c::gold {
    struct GOLD has key {
        id: 0x2::object::UID,
    }

    struct CreationTicket has key {
        id: 0x2::object::UID,
    }

    public fun create_currency(arg0: CreationTicket, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<GOLD>, 0x2::coin::TreasuryCap<GOLD>) {
        let CreationTicket { id: v0 } = arg0;
        0x2::object::delete(v0);
        assert!(arg2 <= 18, 1);
        assert!(0x1::string::length(&arg3) > 0 && 0x1::string::length(&arg3) <= 16, 1);
        assert!(0x1::string::length(&arg4) > 0 && 0x1::string::length(&arg4) <= 64, 1);
        assert!(0x1::string::length(&arg5) <= 1000, 1);
        assert!(0x1::string::length(&arg6) <= 512, 1);
        0x2::coin_registry::new_currency<GOLD>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreationTicket{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CreationTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

