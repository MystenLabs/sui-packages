module 0x9f0d2d39022e2f6eeac61430464a061654250b1de62f3524103431bdda846c82::uu {
    struct UU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<UU>, arg1: 0x2::coin::Coin<UU>) {
        0x2::coin::burn<UU>(arg0, arg1);
    }

    fun init(arg0: UU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UU>(arg0, 0, b"UU", b"UU", b"this id my coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<UU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

