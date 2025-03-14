module 0xa5b0fa5c3d2db7db47e5307420724c9f89482392a6d39bdbd1b4796b3d5c9686::token1 {
    struct TOKEN1 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN1>, arg1: 0x2::coin::Coin<TOKEN1>) {
        0x2::coin::burn<TOKEN1>(arg0, arg1);
    }

    fun init(arg0: TOKEN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN1>(arg0, 9, b"tt", b"TT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

