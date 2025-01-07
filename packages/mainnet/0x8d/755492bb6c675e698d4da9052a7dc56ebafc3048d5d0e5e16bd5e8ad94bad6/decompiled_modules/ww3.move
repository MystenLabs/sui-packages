module 0x8d755492bb6c675e698d4da9052a7dc56ebafc3048d5d0e5e16bd5e8ad94bad6::ww3 {
    struct WW3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW3>(arg0, 6, b"WW3", b"I JUST SOLD MY INITIALS", x"5056503a2049535241454c20424f4d42532054454852414e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbiu9u1_Y_Xhj2nhw_PU_7_Pyu9m_F3jdurxz7_Wp_ENS_Ddtf_Zm_N9_a3bf6fa61c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WW3>>(v1);
    }

    // decompiled from Move bytecode v6
}

