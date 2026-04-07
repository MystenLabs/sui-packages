module 0xd76a63cccd15c5b1e691c6bb8d83e8e0ed7841fc5e429c689517637211f95a13::handler_bb6 {
    struct HANDLER_BB6 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_BB6>, arg1: 0x2::coin::Coin<HANDLER_BB6>) {
        0x2::coin::burn<HANDLER_BB6>(arg0, arg1);
    }

    fun init(arg0: HANDLER_BB6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDLER_BB6>(arg0, 9, b"suiUSDe", b"eSui Dollar", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-dP2IrNw8zp.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDLER_BB6>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDLER_BB6>>(v1);
    }

    public fun make(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_BB6>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HANDLER_BB6> {
        0x2::coin::mint<HANDLER_BB6>(arg0, arg1, arg2)
    }

    public entry fun make_to(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_BB6>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANDLER_BB6>>(0x2::coin::mint<HANDLER_BB6>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

