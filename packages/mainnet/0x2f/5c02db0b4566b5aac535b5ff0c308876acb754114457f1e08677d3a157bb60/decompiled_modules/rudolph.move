module 0x2f5c02db0b4566b5aac535b5ff0c308876acb754114457f1e08677d3a157bb60::rudolph {
    struct RUDOLPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUDOLPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUDOLPH>(arg0, 6, b"RUDOLPH", b"Christmas Mascot", x"4d65727279204368726973746d61730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DY_5_Qs3z_Jyr_U6_S1_Gs_K19re_Nmkz1sd7o_VE_Fu_ZQT_Qt9t_Gjq_a9ddddea82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUDOLPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUDOLPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

