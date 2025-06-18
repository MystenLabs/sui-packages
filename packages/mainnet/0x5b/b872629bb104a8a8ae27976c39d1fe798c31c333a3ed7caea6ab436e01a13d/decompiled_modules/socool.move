module 0x5bb872629bb104a8a8ae27976c39d1fe798c31c333a3ed7caea6ab436e01a13d::socool {
    struct SOCOOL has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOCOOL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SOCOOL>>(0x2::coin::mint<SOCOOL>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: SOCOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCOOL>(arg0, 9, b"SOCOOL", b"Wow Nice Token", b"A test token to show off on twitter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plz.money/coin-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SOCOOL>>(0x2::coin::mint<SOCOOL>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOCOOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCOOL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

