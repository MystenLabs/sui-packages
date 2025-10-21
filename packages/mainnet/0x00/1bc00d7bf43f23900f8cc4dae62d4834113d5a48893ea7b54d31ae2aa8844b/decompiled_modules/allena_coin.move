module 0x1bc00d7bf43f23900f8cc4dae62d4834113d5a48893ea7b54d31ae2aa8844b::allena_coin {
    struct ALLENA_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ALLENA_COIN>, arg1: 0x2::coin::Coin<ALLENA_COIN>) {
        0x2::coin::burn<ALLENA_COIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ALLENA_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ALLENA_COIN>>(0x2::coin::mint<ALLENA_COIN>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<ALLENA_COIN>) : u64 {
        0x2::coin::total_supply<ALLENA_COIN>(arg0)
    }

    fun init(arg0: ALLENA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ALLENA_COIN>(arg0, 9, 0x1::string::utf8(b"ALLENA"), 0x1::string::utf8(b"Allena Coin"), 0x1::string::utf8(b"Allena Coin - Earn Crypto by Working Out"), 0x1::string::utf8(b"https://public.allena.ai/allenacoin.png"), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<ALLENA_COIN>>(0x2::coin_registry::finalize<ALLENA_COIN>(v0, arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLENA_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

