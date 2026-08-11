module 0x4537f75183ef283d4d8b2df80736a9adb9cbdc1142cf17d73923a7981dd3daa8::my_token {
    struct MY_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: 0x2::coin::Coin<MY_TOKEN>) {
        0x2::coin::burn<MY_TOKEN>(arg0, arg1);
    }

    fun init(arg0: MY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TOKEN>(arg0, 18, b"BBB", b"testBBB", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_TOKEN>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<MY_TOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_TOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

