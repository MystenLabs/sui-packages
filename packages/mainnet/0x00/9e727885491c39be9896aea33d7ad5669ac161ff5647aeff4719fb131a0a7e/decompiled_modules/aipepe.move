module 0x9e727885491c39be9896aea33d7ad5669ac161ff5647aeff4719fb131a0a7e::aipepe {
    struct AIPEPE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIPEPE>, arg1: 0x2::coin::Coin<AIPEPE>) {
        0x2::coin::burn<AIPEPE>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AIPEPE>>(0x2::coin::mint<AIPEPE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPEPE>(arg0, 18, b"AIPEPE", b"AI PEPE", b"AI PEPE token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

