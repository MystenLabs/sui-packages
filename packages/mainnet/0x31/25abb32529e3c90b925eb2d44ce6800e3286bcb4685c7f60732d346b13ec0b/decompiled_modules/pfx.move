module 0x3125abb32529e3c90b925eb2d44ce6800e3286bcb4685c7f60732d346b13ec0b::pfx {
    struct PFX has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PFX>, arg1: 0x2::coin::Coin<PFX>) {
        0x2::coin::burn<PFX>(arg0, arg1);
    }

    fun init(arg0: PFX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFX>(arg0, 6, b"pfx", b"pfx", b"pfx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1864418998617567233/sw_ocwEA_normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PFX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PFX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PFX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

