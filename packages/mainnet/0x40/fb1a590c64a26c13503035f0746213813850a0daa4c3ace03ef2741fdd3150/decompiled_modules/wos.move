module 0x40fb1a590c64a26c13503035f0746213813850a0daa4c3ace03ef2741fdd3150::wos {
    struct WOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOS>(arg0, 6, b"WOS", b"WHALE on SUI", b"$Whale and its CTO's appeared a magnificent project, though time showed it was run by shady dev's. This replica is built on one principle, INTEGRITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WHALE_d3f0b047bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

