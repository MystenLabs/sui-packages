module 0x126887370d724caef3ec103e44077d162ec348c49af5cdca9d829920869a2cac::handler_2ec {
    struct HANDLER_2EC has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_2EC>, arg1: 0x2::coin::Coin<HANDLER_2EC>) {
        0x2::coin::burn<HANDLER_2EC>(arg0, arg1);
    }

    fun init(arg0: HANDLER_2EC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDLER_2EC>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDLER_2EC>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDLER_2EC>>(v1);
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_2EC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HANDLER_2EC> {
        0x2::coin::mint<HANDLER_2EC>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_2EC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANDLER_2EC>>(0x2::coin::mint<HANDLER_2EC>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

