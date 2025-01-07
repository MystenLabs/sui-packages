module 0xe7849efa0617cea1e8aa1eb44a959f5ee5380647222421883e22916bfecfab9a::wtfwasthat {
    struct WTFWASTHAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WTFWASTHAT>, arg1: 0x2::coin::Coin<WTFWASTHAT>) {
        0x2::coin::burn<WTFWASTHAT>(arg0, arg1);
    }

    fun init(arg0: WTFWASTHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTFWASTHAT>(arg0, 3, b"WTFWASTHAT", b"DC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WTFWASTHAT>(&mut v2, 42069000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTFWASTHAT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WTFWASTHAT>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WTFWASTHAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WTFWASTHAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

