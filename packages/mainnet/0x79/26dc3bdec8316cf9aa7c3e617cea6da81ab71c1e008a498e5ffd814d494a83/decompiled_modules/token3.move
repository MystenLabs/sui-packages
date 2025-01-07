module 0x7926dc3bdec8316cf9aa7c3e617cea6da81ab71c1e008a498e5ffd814d494a83::token3 {
    struct TOKEN3 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN3>, arg1: 0x2::coin::Coin<TOKEN3>) {
        0x2::coin::burn<TOKEN3>(arg0, arg1);
    }

    fun init(arg0: TOKEN3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN3>(arg0, 9, b"li.fi", b"li.fi", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN3>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN3>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

