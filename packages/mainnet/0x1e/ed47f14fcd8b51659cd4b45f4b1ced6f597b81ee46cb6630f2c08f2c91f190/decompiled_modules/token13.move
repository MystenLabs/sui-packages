module 0x1eed47f14fcd8b51659cd4b45f4b1ced6f597b81ee46cb6630f2c08f2c91f190::token13 {
    struct TOKEN13 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN13>, arg1: 0x2::coin::Coin<TOKEN13>) {
        0x2::coin::burn<TOKEN13>(arg0, arg1);
    }

    fun init(arg0: TOKEN13, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN13>(arg0, 9, b"li.fi", b"li.fi", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN13>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN13>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN13>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN13>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

