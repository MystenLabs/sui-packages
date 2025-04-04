module 0xcc8d28ba0ac779504aa750a9a9aa1a615dd48115b1c2bb0bfbd7d0b76f6e24de::pump_fun {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    struct PumpFunTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<MANAGED>,
    }

    public entry fun create_coin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MANAGED{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<MANAGED>(v0, 9, b"PUMP_FUN", b"PMP", b"", 0x1::option::none<0x2::url::Url>(), arg0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v2);
        let v3 = PumpFunTreasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<MANAGED>(),
        };
        0x2::transfer::share_object<PumpFunTreasury>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED>>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

