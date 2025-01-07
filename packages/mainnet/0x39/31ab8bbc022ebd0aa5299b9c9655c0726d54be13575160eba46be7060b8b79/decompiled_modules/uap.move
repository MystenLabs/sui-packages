module 0x3931ab8bbc022ebd0aa5299b9c9655c0726d54be13575160eba46be7060b8b79::uap {
    struct UAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UAP>(arg0, 6, b"UAP", b"UAP on SUI", b"Welcome to the UAP coin community! Here, we explore the unknown together, blending the mysteries of the universe. Buckle up for an adventure where the sky's not the limitit's just the beginning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/978_C74_C2_0_F02_4013_BCD_392697_BCB_0057_source_1ec046b401.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

