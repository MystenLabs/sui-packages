module 0x2ed646e9b2e746b720edda3f7396014dbc7e8fee0201dd9d669eee615b19d570::texas {
    struct TEXAS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEXAS>, arg1: 0x2::coin::Coin<TEXAS>) {
        0x2::coin::burn<TEXAS>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEXAS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEXAS> {
        0x2::coin::mint<TEXAS>(arg0, arg1, arg2)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TEXAS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEXAS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TEXAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEXAS>(arg0, 9, b"TEXAS", b"Texas Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEXAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEXAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

