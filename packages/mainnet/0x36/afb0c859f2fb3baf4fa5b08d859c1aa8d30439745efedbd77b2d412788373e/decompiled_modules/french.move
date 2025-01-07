module 0x36afb0c859f2fb3baf4fa5b08d859c1aa8d30439745efedbd77b2d412788373e::french {
    struct FRENCH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FRENCH>, arg1: 0x2::coin::Coin<FRENCH>) {
        0x2::coin::burn<FRENCH>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FRENCH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FRENCH>>(0x2::coin::mint<FRENCH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENCH>(arg0, 9, b"french", b"FRENCH", b"fucking nice token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"example.com")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRENCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

