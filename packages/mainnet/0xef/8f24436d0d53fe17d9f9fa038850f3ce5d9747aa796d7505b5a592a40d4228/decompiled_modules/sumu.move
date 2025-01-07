module 0xef8f24436d0d53fe17d9f9fa038850f3ce5d9747aa796d7505b5a592a40d4228::sumu {
    struct SUMU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUMU>, arg1: 0x2::coin::Coin<SUMU>) {
        0x2::coin::burn<SUMU>(arg0, arg1);
    }

    fun init(arg0: SUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMU>(arg0, 2, b"SUMU", b"Suimurices", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/VNk72Sy.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUMU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUMU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUMU>(arg0, arg1, arg2, arg3);
    }

    public entry fun transferOwnership(arg0: 0x2::coin::TreasuryCap<SUMU>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMU>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

