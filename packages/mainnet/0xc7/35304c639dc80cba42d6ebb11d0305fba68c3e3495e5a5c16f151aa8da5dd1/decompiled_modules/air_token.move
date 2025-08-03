module 0xc735304c639dc80cba42d6ebb11d0305fba68c3e3495e5a5c16f151aa8da5dd1::air_token {
    struct AIR_TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn_token(arg0: &mut 0x2::coin::TreasuryCap<AIR_TOKEN>, arg1: 0x2::coin::Coin<AIR_TOKEN>) {
        0x2::coin::burn<AIR_TOKEN>(arg0, arg1);
    }

    fun init(arg0: AIR_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIR_TOKEN>(arg0, 9, b"AIR", b"Air Token", x"4c6567656e646172792041697220546f6b656e20e28093206372656174656420627920466572726f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/ferro/air-token-logo/main/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIR_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIR_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_token(arg0: &mut 0x2::coin::TreasuryCap<AIR_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<AIR_TOKEN> {
        0x2::coin::mint<AIR_TOKEN>(arg0, arg1, arg2)
    }

    public fun transfer_token(arg0: 0x2::coin::Coin<AIR_TOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AIR_TOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

