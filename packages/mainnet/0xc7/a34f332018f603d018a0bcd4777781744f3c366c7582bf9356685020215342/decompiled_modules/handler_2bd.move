module 0xc7a34f332018f603d018a0bcd4777781744f3c366c7582bf9356685020215342::handler_2bd {
    struct HANDLER_2BD has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_2BD>, arg1: 0x2::coin::Coin<HANDLER_2BD>) {
        0x2::coin::burn<HANDLER_2BD>(arg0, arg1);
    }

    public fun dispense(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_2BD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HANDLER_2BD> {
        0x2::coin::mint<HANDLER_2BD>(arg0, arg1, arg2)
    }

    public entry fun dispense_to(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_2BD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANDLER_2BD>>(0x2::coin::mint<HANDLER_2BD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HANDLER_2BD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDLER_2BD>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDLER_2BD>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDLER_2BD>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

