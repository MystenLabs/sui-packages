module 0x11fd41f7bdcdf787aaac13bd9acb7d13b2da9d911d964bcd0c2759762924a50e::SUISUSHI {
    struct SUISUSHI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISUSHI>, arg1: 0x2::coin::Coin<SUISUSHI>) {
        0x2::coin::burn<SUISUSHI>(arg0, arg1);
    }

    fun init(arg0: SUISUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUSHI>(arg0, 9, b"SUSHI", b"Sui Sushi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/ynTLXD9/sushi.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISUSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISUSHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISUSHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

