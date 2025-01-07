module 0x31d314e473643a50b574865ff04ef6e0944e2bac25b0cfa9cc8072903055e628::ww3 {
    struct WW3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW3>(arg0, 6, b"WW3", b"WW3_on_Sui", b"Welcome to the next chapter, years of misery coming our way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/46_A81_F7_E_AE_9_A_4210_9_E2_F_BA_8_FD_84_A63_EF_d80d37c4aa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WW3>>(v1);
    }

    // decompiled from Move bytecode v6
}

