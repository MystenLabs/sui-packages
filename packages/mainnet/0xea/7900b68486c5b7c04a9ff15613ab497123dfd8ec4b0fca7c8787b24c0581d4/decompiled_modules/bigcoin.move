module 0xea7900b68486c5b7c04a9ff15613ab497123dfd8ec4b0fca7c8787b24c0581d4::bigcoin {
    struct BIGCOIN has key {
        id: 0x2::object::UID,
    }

    struct CreationTicket has key {
        id: 0x2::object::UID,
    }

    public fun create_currency(arg0: CreationTicket, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<BIGCOIN>, 0x2::coin::TreasuryCap<BIGCOIN>) {
        let CreationTicket { id: v0 } = arg0;
        0x2::object::delete(v0);
        assert!(arg2 <= 18, 1);
        assert!(0x1::string::length(&arg3) > 0 && 0x1::string::length(&arg3) <= 16, 1);
        assert!(0x1::string::length(&arg4) > 0 && 0x1::string::length(&arg4) <= 64, 1);
        assert!(0x1::string::length(&arg5) <= 1000, 1);
        assert!(0x1::string::length(&arg6) <= 512, 1);
        0x2::coin_registry::new_currency<BIGCOIN>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreationTicket{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CreationTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

