module 0x6c0b9d3ed6146b8272c7457baca53cb9bbd9a6849bcf4c05b6f2ac8fa03affe9::nago {
    struct NAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAGO>(arg0, 6, b"NAGO", b"Sui Wrapped Dog CTO", b"Sui Wrapped Dog CTO, TG updated", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZYB_Qzw_X0_AA_Ey_Q2_1_b870c96678.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

