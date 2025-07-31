module 0x753db53895aae484f3814acd86dd9e46892d2d8744fa60d0b8f5fdb6a1e2aaf1::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TOKEN>(arg0, arg1);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"MTK", b"MyToken", b"My custom token on SUI mainnet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

