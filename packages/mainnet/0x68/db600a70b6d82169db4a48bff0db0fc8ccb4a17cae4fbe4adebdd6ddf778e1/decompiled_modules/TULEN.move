module 0x68db600a70b6d82169db4a48bff0db0fc8ccb4a17cae4fbe4adebdd6ddf778e1::TULEN {
    struct TULEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TULEN>, arg1: 0x2::coin::Coin<TULEN>) {
        0x2::coin::burn<TULEN>(arg0, arg1);
    }

    fun init(arg0: TULEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TULEN>(arg0, 9, b"TULEN", b"TULEN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TULEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TULEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TULEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TULEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

