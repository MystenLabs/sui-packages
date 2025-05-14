module 0x2716e6cdd902c6992de33ed49ae68ab296d51b1e6ff35b6ad3e0540088ef98f8::tappy {
    struct TAPPY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TAPPY>, arg1: 0x2::coin::Coin<TAPPY>) {
        0x2::coin::burn<TAPPY>(arg0, arg1);
    }

    public fun total_supply(arg0: &mut 0x2::coin::TreasuryCap<TAPPY>) : u64 {
        0x2::coin::total_supply<TAPPY>(arg0)
    }

    fun init(arg0: TAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAPPY>(arg0, 9, b"TAP", b"Tappy Token", b"This is the tappy token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_token(arg0: &mut 0x2::coin::TreasuryCap<TAPPY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TAPPY> {
        0x2::coin::mint<TAPPY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

