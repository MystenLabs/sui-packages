module 0xf766408b39384ff99fcfe49f0bed65799a4f9a8c35da8f18b25a9042be9b7a02::token20 {
    struct TOKEN20 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN20>, arg1: 0x2::coin::Coin<TOKEN20>) {
        0x2::coin::burn<TOKEN20>(arg0, arg1);
    }

    fun init(arg0: TOKEN20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN20>(arg0, 9, b"li.fi", b"li.fi", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN20>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN20>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN20>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN20>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

