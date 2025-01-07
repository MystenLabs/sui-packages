module 0x866d6b027b845df1ef0b10dee40e30af48328e6c6d82b9381250d281717d15c5::suitool {
    struct SUITOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOOL>(arg0, 6, b"Suitool", b"Suitools", b"Suitor is the most advance bot in Sui ecosystem. Trojan bot sniper . Tg invite bots much more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3915_d0304b901d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

