module 0x5e63cea36ff06e637b6f308477f41f70402b1a9585d8fb90b5f91a58f6defe08::rarity {
    struct RARITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RARITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RARITY>(arg0, 6, b"RARITY", b"RARITY ON SUI", b"Your decisions will decide Rarity's destiny.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rarity_5ec02f9120.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RARITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RARITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

