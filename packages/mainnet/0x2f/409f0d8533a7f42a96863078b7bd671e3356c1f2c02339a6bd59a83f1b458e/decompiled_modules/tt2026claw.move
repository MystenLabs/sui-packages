module 0x2f409f0d8533a7f42a96863078b7bd671e3356c1f2c02339a6bd59a83f1b458e::tt2026claw {
    struct TT2026CLAW has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TT2026CLAW>, arg1: 0x2::coin::Coin<TT2026CLAW>) {
        0x2::coin::burn<TT2026CLAW>(arg0, arg1);
    }

    fun init(arg0: TT2026CLAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT2026CLAW>(arg0, 6, b"TT2026CLAW", b"TT2026Claw", b"AI assistant helping with e-commerce and productivity tasks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png#1770274688346685000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT2026CLAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT2026CLAW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TT2026CLAW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TT2026CLAW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

