module 0x9b5992fb34cfa7be6febdcad9d275b5d0c4190a4c86861344fdf52efd49db75a::fauceta {
    struct FAUCETA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCETA>, arg1: 0x2::coin::Coin<FAUCETA>) {
        0x2::coin::burn<FAUCETA>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCETA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCETA>>(0x2::coin::mint<FAUCETA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAUCETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETA>(arg0, 6, b"FAUCET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETA>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCETA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

