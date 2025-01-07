module 0x1d8242d619fd74cf60ad63b0bab612c8f9bd5c818dcce4ccd65135d4c2f38063::faucetb {
    struct FAUCETB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCETB>, arg1: 0x2::coin::Coin<FAUCETB>) {
        0x2::coin::burn<FAUCETB>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCETB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCETB>>(0x2::coin::mint<FAUCETB>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAUCETB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETB>(arg0, 6, b"FAUCETB", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETB>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCETB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

