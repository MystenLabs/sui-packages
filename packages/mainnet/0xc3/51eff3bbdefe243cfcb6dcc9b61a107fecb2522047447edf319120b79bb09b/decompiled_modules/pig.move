module 0xc351eff3bbdefe243cfcb6dcc9b61a107fecb2522047447edf319120b79bb09b::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PIG>, arg1: 0x2::coin::Coin<PIG>) {
        0x2::coin::burn<PIG>(arg0, arg1);
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG>(arg0, 6, b"PIGS", b"PIGSUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PIG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

