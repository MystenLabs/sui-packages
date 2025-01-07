module 0xd7efbf108fa8ca9b4d79a1b92d96f7ffb86dfe310fc05265068910d53491fec5::DUBAI {
    struct DUBAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUBAI>, arg1: 0x2::coin::Coin<DUBAI>) {
        0x2::coin::burn<DUBAI>(arg0, arg1);
    }

    fun init(arg0: DUBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUBAI>(arg0, 9, b"DUBAI", b"DUBAI", b"Ryan Coin Demo Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/5njhtvW/dubai.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUBAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUBAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUBAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DUBAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

