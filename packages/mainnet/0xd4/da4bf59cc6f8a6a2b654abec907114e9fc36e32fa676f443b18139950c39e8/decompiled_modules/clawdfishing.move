module 0xd4da4bf59cc6f8a6a2b654abec907114e9fc36e32fa676f443b18139950c39e8::clawdfishing {
    struct CLAWDFISHING has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLAWDFISHING>, arg1: 0x2::coin::Coin<CLAWDFISHING>) {
        0x2::coin::burn<CLAWDFISHING>(arg0, arg1);
    }

    fun init(arg0: CLAWDFISHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWDFISHING>(arg0, 6, b"CLAWDFISHI", b"clawdfishing", b"clawd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png#1770274688345589000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAWDFISHING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWDFISHING>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAWDFISHING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLAWDFISHING>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

