module 0xdec4e35370bc87cf08be111f6da1cb9228d389afbc694622508c68ee2785dc00::yijing {
    struct YIJING has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIJING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIJING>(arg0, 6, b"YIJING", b"YIJing", b"YiJing on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/YINYANG_T_Qgk_T1_s_CZ_Ipd_Vo5bps_fed9ebcce0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIJING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YIJING>>(v1);
    }

    // decompiled from Move bytecode v6
}

