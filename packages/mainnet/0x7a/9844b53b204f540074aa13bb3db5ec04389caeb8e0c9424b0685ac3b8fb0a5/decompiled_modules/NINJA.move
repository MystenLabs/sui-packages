module 0x7a9844b53b204f540074aa13bb3db5ec04389caeb8e0c9424b0685ac3b8fb0a5::NINJA {
    struct NINJA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NINJA>, arg1: 0x2::coin::Coin<NINJA>) {
        0x2::coin::burn<NINJA>(arg0, arg1);
    }

    fun init(arg0: NINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINJA>(arg0, 9, b"NINJA", b"NINJA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://shinobininjatoken.com/wp-content/uploads/2024/01/ninja3.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NINJA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINJA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NINJA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NINJA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

