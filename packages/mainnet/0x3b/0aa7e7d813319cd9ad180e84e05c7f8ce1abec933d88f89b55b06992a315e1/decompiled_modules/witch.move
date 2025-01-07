module 0x3b0aa7e7d813319cd9ad180e84e05c7f8ce1abec933d88f89b55b06992a315e1::witch {
    struct WITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITCH>(arg0, 6, b"WITCH", b"Witch of Sui", x"43617374696e67207370656c6c7320616e64207374697272696e67206361756c64726f6e732c20245749544348206272696e67732061206c6974746c65206461726b206d6167696320746f2074686520537569204e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_mascot_logo_design_of_a_arrogant_looking_witchmascot_l_42eb19a4_3d97_492f_89ed_546b58fe41fe_2_e6744309a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

