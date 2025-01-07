module 0xbd43f136e013cd5debd2128787af99e51afe8edad078ec679d97a0209618e8f::gou {
    struct GOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOU>(arg0, 6, b"GOU", b"GOU Baby Neiro SUI", x"4d79206e616d6520697320476f75202c20697473204368696e65736520666f7220446f67210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOTHERS_LOVE_NEIRO_AND_BABY_NEIRO_2_ebad7d1cc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

