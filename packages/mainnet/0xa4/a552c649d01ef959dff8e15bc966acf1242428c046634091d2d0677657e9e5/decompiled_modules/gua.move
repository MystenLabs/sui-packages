module 0xa4a552c649d01ef959dff8e15bc966acf1242428c046634091d2d0677657e9e5::gua {
    struct GUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUA>(arg0, 6, b"GUA", b"GUA SUI", b"GUA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1731607661_5499759_45808577_2302_4602_AC_9_B_5_E1_FBFDE_72_D4_7d306ae791.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

