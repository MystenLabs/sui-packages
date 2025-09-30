module 0x1e4dc2f565e26891f0c813fe8f63cbbe58448a27345ecd3cd14879d275b53610::ppr {
    struct PPR has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PPR>, arg1: 0x2::coin::Coin<PPR>) {
        0x2::coin::burn<PPR>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PPR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PPR>>(0x2::coin::mint<PPR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPR>(arg0, 18, b"PPR", b"PEPERED", b"PEPERED token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

