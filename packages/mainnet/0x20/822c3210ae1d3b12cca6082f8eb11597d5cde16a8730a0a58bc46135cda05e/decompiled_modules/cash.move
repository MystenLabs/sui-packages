module 0x20822c3210ae1d3b12cca6082f8eb11597d5cde16a8730a0a58bc46135cda05e::cash {
    struct CASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASH>(arg0, 6, b"CASH", b"No 1 Tiktok Cat", b"With over 4.9 million lovers on Tiktok this spectacular feline has become the most known furry friend on the platform with 100 million views on one video! https://www.tiktok.com/@meow__cash", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Tvb_Nd4_NU_Jz8m_V_Zx46_Aypzdp_Kcd17_Smcu_Go_X6op_XY_25f_b3707da496.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

