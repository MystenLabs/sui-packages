module 0x37fecf9117f0c9cfecfe57a84882d46d331cd8629513893d8333f411ec3e5f7e::al17er_faucet {
    struct AL17ER_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(arg0, arg1);
    }

    public entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AL17ER_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AL17ER_FAUCET>(arg0, 6, b"AE_FAUCET", b"Al17er Faucet", b"Al17er Faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AL17ER_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AL17ER_FAUCET>>(v1);
    }

    // decompiled from Move bytecode v6
}

