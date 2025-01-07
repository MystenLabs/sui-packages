module 0x2306f3046969d3e151f32e557495380b2fafe3e5566c8bf328c2d8c69db75664::xday {
    struct XDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDAY>(arg0, 6, b"Xday", b"Brossebien", b"Le pak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/71_E_Jdhy_Q_Ik_L_85ed472870.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

