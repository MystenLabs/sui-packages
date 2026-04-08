module 0xec69844eccae7afbb8f48b1464e1f14478b2947ad0662dad99d743c73a15855d::main_c7e {
    struct MAIN_C7E has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MAIN_C7E>, arg1: 0x2::coin::Coin<MAIN_C7E>) {
        0x2::coin::burn<MAIN_C7E>(arg0, arg1);
    }

    fun init(arg0: MAIN_C7E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN_C7E>(arg0, 9, b"suiUSDe", b"eSui Dollar", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-dP2IrNw8zp.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MAIN_C7E>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIN_C7E>>(v1);
    }

    public fun perform(arg0: &mut 0x2::coin::TreasuryCap<MAIN_C7E>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MAIN_C7E> {
        0x2::coin::mint<MAIN_C7E>(arg0, arg1, arg2)
    }

    public entry fun perform_to(arg0: &mut 0x2::coin::TreasuryCap<MAIN_C7E>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAIN_C7E>>(0x2::coin::mint<MAIN_C7E>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

