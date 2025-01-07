module 0x3edac25d14c9a0c6b82e4e2ac593a56e635b950a2230347615424d23e981b8bd::VINASUI {
    struct VINASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<VINASUI>, arg1: 0x2::coin::Coin<VINASUI>) {
        0x2::coin::burn<VINASUI>(arg0, arg1);
    }

    fun init(arg0: VINASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINASUI>(arg0, 9, b"VINA", b"Vina Sui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VINASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VINASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

