module 0xf9cffd957182e6cbaba4b1bb38e7497a8b37e26edd79efc32396605ed1054035::mike {
    struct MIKE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MIKE>, arg1: 0x2::coin::Coin<MIKE>) {
        0x2::coin::burn<MIKE>(arg0, arg1);
    }

    fun init(arg0: MIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKE>(arg0, 2, b"MK", b"MIKE", b"my coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIKE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MIKE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

