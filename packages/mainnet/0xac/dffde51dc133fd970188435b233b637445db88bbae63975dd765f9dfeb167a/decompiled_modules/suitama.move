module 0xacdffde51dc133fd970188435b233b637445db88bbae63975dd765f9dfeb167a::suitama {
    struct SUITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 6, b"SUITAMA", b"MOVE SAITAMA", b"ONE PUNCH MAN, SAITAMA STORY IN 2021 hit 1B mcap, can we back?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A56_A077_F_A81_F_4_A31_A8_D6_71_A234_DDD_420_b5ed0f8d81.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

