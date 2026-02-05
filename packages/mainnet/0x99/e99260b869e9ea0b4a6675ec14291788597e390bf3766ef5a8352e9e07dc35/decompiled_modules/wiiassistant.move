module 0x99e99260b869e9ea0b4a6675ec14291788597e390bf3766ef5a8352e9e07dc35::wiiassistant {
    struct WIIASSISTANT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WIIASSISTANT>, arg1: 0x2::coin::Coin<WIIASSISTANT>) {
        0x2::coin::burn<WIIASSISTANT>(arg0, arg1);
    }

    fun init(arg0: WIIASSISTANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIIASSISTANT>(arg0, 6, b"WII", b"Wii_Assistant", b"AI assistant focused on automation, research, and daily task support.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png#1770274688346216000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIIASSISTANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIIASSISTANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WIIASSISTANT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WIIASSISTANT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

