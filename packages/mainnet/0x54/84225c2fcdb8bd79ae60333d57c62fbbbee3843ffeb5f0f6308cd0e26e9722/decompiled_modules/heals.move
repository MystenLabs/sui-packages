module 0x5484225c2fcdb8bd79ae60333d57c62fbbbee3843ffeb5f0f6308cd0e26e9722::heals {
    struct HEALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEALS>(arg0, 6, b"HEALS", b"Heal sui", b"We need to heal the memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_01_08_54_8db803b458.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

