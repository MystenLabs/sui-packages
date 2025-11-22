module 0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest {
    struct NEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEST>(arg0, 6, b"NEST", b"NEST Token", b"Native token for the NEST ecosystem", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_cap_supply(arg0: 0x2::coin::TreasuryCap<NEST>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEST>>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEST>>(0x2::coin::mint<NEST>(&mut arg0, 333000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

