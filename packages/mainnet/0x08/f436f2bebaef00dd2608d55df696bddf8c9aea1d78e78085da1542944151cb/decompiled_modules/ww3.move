module 0x8f436f2bebaef00dd2608d55df696bddf8c9aea1d78e78085da1542944151cb::ww3 {
    struct WW3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW3>(arg0, 6, b"WW3", b"I JUST SOLD MY INITIALS", x"5056503a2049535241454c20424f4d42532054454852414e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbiu9u1_Y_Xhj2nhw_PU_7_Pyu9m_F3jdurxz7_Wp_ENS_Ddtf_Zm_N9_ee78fcc043.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WW3>>(v1);
    }

    // decompiled from Move bytecode v6
}

