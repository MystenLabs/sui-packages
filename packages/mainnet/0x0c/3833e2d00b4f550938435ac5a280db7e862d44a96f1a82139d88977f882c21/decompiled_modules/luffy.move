module 0xc3833e2d00b4f550938435ac5a280db7e862d44a96f1a82139d88977f882c21::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LUFFY>, arg1: 0x2::coin::Coin<LUFFY>) {
        0x2::coin::burn<LUFFY>(arg0, arg1);
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY>(arg0, 2, b"LUFFY TOKEN", b"LUFFY", b"10000", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUFFY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LUFFY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

