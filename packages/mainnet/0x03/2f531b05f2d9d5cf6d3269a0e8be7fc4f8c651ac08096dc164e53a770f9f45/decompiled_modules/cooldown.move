module 0x32f531b05f2d9d5cf6d3269a0e8be7fc4f8c651ac08096dc164e53a770f9f45::cooldown {
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

