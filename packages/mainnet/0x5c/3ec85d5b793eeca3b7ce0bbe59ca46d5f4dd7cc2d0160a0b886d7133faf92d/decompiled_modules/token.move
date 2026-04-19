module 0x5c3ec85d5b793eeca3b7ce0bbe59ca46d5f4dd7cc2d0160a0b886d7133faf92d::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public fun freeze_metadata(arg0: 0x2::coin::CoinMetadata<TOKEN>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(arg0);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"TOKEN", b"Launchpad Token", b"Token launched via Strategy Launchpad", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

