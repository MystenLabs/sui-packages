module 0xa4fa133fa6ea1c9e02252a85e2af5a0efc1435702df3f4bd4c341644311217ff::trollsui {
    struct TROLLSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TROLLSUI>, arg1: 0x2::coin::Coin<TROLLSUI>) {
        0x2::coin::burn<TROLLSUI>(arg0, arg1);
    }

    fun init(arg0: TROLLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLSUI>(arg0, 6, b"TROLL SUI", b"TROLLSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/RzfzBD1/TROLLSUI.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLLSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TROLLSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TROLLSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

