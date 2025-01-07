module 0x8d4fa311c95d4945b01bbc25d560faaa129aa679ce311e401d771e2c66bc8052::menyu {
    struct MENYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENYU>(arg0, 6, b"Menyu", b"Menyu SUI", x"4d656e797520697320612063757465206c6974746c65206d6f757365206f6e2053756920776f726c642e0a0a726561647920746f206d616b652074686520776f726c642066756e6e696572207468616e2065766572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_L_Pf7_Pfo_N4_DPX_Wz9yovg_Q_Llv_L_78bcd7c449.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MENYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

