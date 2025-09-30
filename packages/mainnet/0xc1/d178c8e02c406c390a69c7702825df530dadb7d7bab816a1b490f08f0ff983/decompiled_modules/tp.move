module 0xc1d178c8e02c406c390a69c7702825df530dadb7d7bab816a1b490f08f0ff983::tp {
    struct TP has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TP>, arg1: 0x2::coin::Coin<TP>) {
        0x2::coin::burn<TP>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TP>>(0x2::coin::mint<TP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TP>(arg0, 18, b"TP", b"TIMURPEPE", b"TIMURPEPE token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

