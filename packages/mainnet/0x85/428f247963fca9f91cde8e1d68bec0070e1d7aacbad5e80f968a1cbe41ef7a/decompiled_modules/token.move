module 0x85428f247963fca9f91cde8e1d68bec0070e1d7aacbad5e80f968a1cbe41ef7a::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TOKEN> {
        0x2::coin::mint<TOKEN>(arg0, arg1, arg2)
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"TEST", b"Test Inflow Token", b"Token for testing wallet inflow display", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(mint(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

