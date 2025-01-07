module 0xd2849d154c93c3f46b9a2725ada32a1fc124d71446ae5dac04a26bb7147a512d::pump_fun {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    struct PUMP_FUN has drop {
        dummy_field: bool,
    }

    struct PumpFunTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<PUMP_FUN>,
    }

    public entry fun create_coin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MANAGED{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<MANAGED>(v0, 9, b"PUMP_FUN", b"PMP", b"Description of PUMP_FUN", 0x1::option::none<0x2::url::Url>(), arg0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v2);
        let v3 = PumpFunTreasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<PUMP_FUN>(),
        };
        0x2::transfer::share_object<PumpFunTreasury>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED>>(v1, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: PUMP_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP_FUN>(arg0, 2, b"MANAGED", b"MNG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP_FUN>>(v1);
        let v2 = PumpFunTreasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<PUMP_FUN>(),
        };
        0x2::transfer::share_object<PumpFunTreasury>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP_FUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

