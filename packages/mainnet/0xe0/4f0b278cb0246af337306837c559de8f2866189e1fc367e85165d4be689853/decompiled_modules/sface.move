module 0xe04f0b278cb0246af337306837c559de8f2866189e1fc367e85165d4be689853::sface {
    struct SFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFACE>(arg0, 6, b"SFACE", b"SUIFACE", b"Say Hello, To My Little Friend On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_C278_F55_BB_1_B_47_D5_A044_4343549400_FB_29800d94ed.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

