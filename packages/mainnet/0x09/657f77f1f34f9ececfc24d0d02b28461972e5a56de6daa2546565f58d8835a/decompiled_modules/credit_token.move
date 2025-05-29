module 0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::credit_token {
    struct CREDIT_TOKEN has drop {
        dummy_field: bool,
    }

    public fun balance(arg0: &0x2::coin::Coin<CREDIT_TOKEN>) : &0x2::balance::Balance<CREDIT_TOKEN> {
        0x2::coin::balance<CREDIT_TOKEN>(arg0)
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CREDIT_TOKEN>, arg1: 0x2::coin::Coin<CREDIT_TOKEN>) {
        0x2::coin::burn<CREDIT_TOKEN>(arg0, arg1);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<CREDIT_TOKEN>) : u64 {
        0x2::coin::total_supply<CREDIT_TOKEN>(arg0)
    }

    public fun value(arg0: &0x2::coin::Coin<CREDIT_TOKEN>) : u64 {
        0x2::coin::value<CREDIT_TOKEN>(arg0)
    }

    fun init(arg0: CREDIT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREDIT_TOKEN>(arg0, 9, b"CRDT", b"Vault Credit Token", b"Token for paying for credit in the vault", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREDIT_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CREDIT_TOKEN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CREDIT_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CREDIT_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

