module 0xc2ac0556b52c8f095229e729d5365b8d2e667524d520a5b89ec2b4c2a55a6061::watch {
    struct WATCH has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WATCH>, arg1: 0x2::coin::Coin<WATCH>) {
        0x2::coin::burn<WATCH>(arg0, arg1);
    }

    fun init(arg0: WATCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATCH>(arg0, 6, b"WATCH", b"Watch", b"Luxury watch drops. Win a Rolex, AP, or Patek for next to nothing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fy1K4N2.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WATCH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WATCH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

