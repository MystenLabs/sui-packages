module 0x143a71617b744bb44df7eb0059fd898f90bf30f1595320e30bba5fc3c2d92a64::moonusd {
    struct MOONUSD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOONUSD>, arg1: 0x2::coin::Coin<MOONUSD>) {
        0x2::coin::burn<MOONUSD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOONUSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOONUSD>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MOONUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONUSD>(arg0, 9, b"moonusd", b"MOONUSD", b"Releap Profile Token: moonusd", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<MOONUSD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MOONUSD> {
        0x2::coin::mint<MOONUSD>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

