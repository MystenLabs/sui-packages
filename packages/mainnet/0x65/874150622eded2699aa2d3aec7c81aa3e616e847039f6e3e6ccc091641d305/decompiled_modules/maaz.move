module 0x65874150622eded2699aa2d3aec7c81aa3e616e847039f6e3e6ccc091641d305::maaz {
    struct MAAZ has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAAZ>, arg1: 0x2::coin::Coin<MAAZ>) {
        0x2::coin::burn<MAAZ>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAAZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAAZ>>(0x2::coin::mint<MAAZ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MAAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAAZ>(arg0, 6, b"maaz", b"MAAZ", b"Maaz Testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAAZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAAZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

