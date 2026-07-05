module 0x5516a5193d539402eb5f21c7302f51244de6189856e4ed1306c6cdf305966212::silly {
    struct SILLY has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SILLY", b"SILLY", b"Insert Laughter Here", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SILLY>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SILLY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SILLY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

