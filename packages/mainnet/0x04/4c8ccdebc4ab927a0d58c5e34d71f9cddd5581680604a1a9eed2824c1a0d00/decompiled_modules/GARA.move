module 0x44c8ccdebc4ab927a0d58c5e34d71f9cddd5581680604a1a9eed2824c1a0d00::GARA {
    struct GARA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GARA>, arg1: 0x2::coin::Coin<GARA>) {
        0x2::coin::burn<GARA>(arg0, arg1);
    }

    fun init(arg0: GARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARA>(arg0, 9, b"GARA", b"GARA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GARA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GARA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

