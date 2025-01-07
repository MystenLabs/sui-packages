module 0x8ea6867ab320c05320326c83c6266d5cce1f67babe047bf983805f27c47f6afd::gabby {
    struct GABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GABBY>(arg0, 6, b"GABBY", b"GABBY SUI", x"244741424259206973207468652063757465737420636174206f6e2053554920776974682061206d697373696f6e20746f20626520776f727468206d696c6c696f6e732121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Tze_Pi_DWUAACUU_7_6bd9dbd274.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GABBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GABBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

