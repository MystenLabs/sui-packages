module 0xc913e7ba995c8e4d57ffc73734587d1bcf22df90540f251ffd8b8672d10c00e7::yes {
    struct YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YES>(arg0, 6, b"YES", b"YesonSui", b"yEs or no", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3bvsp_V_Qx_400x400_2b98a3d626.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YES>>(v1);
    }

    // decompiled from Move bytecode v6
}

