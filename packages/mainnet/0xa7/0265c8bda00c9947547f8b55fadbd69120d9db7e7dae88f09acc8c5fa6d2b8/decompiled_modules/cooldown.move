module 0xa70265c8bda00c9947547f8b55fadbd69120d9db7e7dae88f09acc8c5fa6d2b8::cooldown {
    struct COOLDOWN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COOLDOWN>, arg1: 0x2::coin::Coin<COOLDOWN>) {
        0x2::coin::burn<COOLDOWN>(arg0, arg1);
    }

    fun init(arg0: COOLDOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLDOWN>(arg0, 6, b"WAITTIME", b"Cooldown", b"429 is just the chain telling you to breathe. We wait, we return.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fDVEwNt.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOLDOWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLDOWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COOLDOWN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COOLDOWN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

