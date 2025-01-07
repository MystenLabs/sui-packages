module 0xaa8e4f8dc9f0256e58cc0835d4eaac44999a2630d1c803c2e2bacb9c5f4878c8::shrek {
    struct SHREK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHREK>, arg1: 0x2::coin::Coin<SHREK>) {
        0x2::coin::burn<SHREK>(arg0, arg1);
    }

    fun init(arg0: SHREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREK>(arg0, 9, b"SHREK", b"SHREK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tickerperry.xyz/shrek.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHREK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHREK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHREK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

