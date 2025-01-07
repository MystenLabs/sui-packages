module 0x1a5aae3525bb5723d6912be9cb5bd199e4d518a1fc326dbe953a734f525a20f5::uap {
    struct UAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UAP>(arg0, 6, b"UAP", b"UAP pn SUI", b"Welcome to the UAP Coin community! Here, we explore the unknown together, blending the mysteries of the universe. Buckle up for an adventure where the sky's not the limitit's just the beginning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/978_C74_C2_0_F02_4013_BCD_392697_BCB_0057_source_b19b9f0fbe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

