module 0xd9f119b7f39ab8fe6ad7d030cf712acb6386d2e6e8dc496d20ee59d97f7a64cc::rickylam {
    struct RICKYLAM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RICKYLAM>, arg1: 0x2::coin::Coin<RICKYLAM>) {
        0x2::coin::burn<RICKYLAM>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RICKYLAM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RICKYLAM>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: RICKYLAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKYLAM>(arg0, 0, b"rickylam", b"{name}", b"Releap Profile Token: rickylam", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICKYLAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKYLAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<RICKYLAM>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RICKYLAM> {
        0x2::coin::mint<RICKYLAM>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

