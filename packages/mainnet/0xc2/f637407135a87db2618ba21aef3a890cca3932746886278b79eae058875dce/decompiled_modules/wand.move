module 0xc2f637407135a87db2618ba21aef3a890cca3932746886278b79eae058875dce::wand {
    struct WAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAND>(arg0, 6, b"WAND", b"WizardCat", x"4d656574207468652057697a6172644361742066726f6d207468652057656233207265616c6d2120576974682061207377697368206f66206974732077616e642c20796f757220647265616d7320636f6d6520747275652e204461726520746f2062656c6965766520696e206d616769633f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sn_F_Pnd_Bm_Bzi_TQ_2z_Wz7q_KVSH_Ky_Bz_Droi_Ucdq4_VR_Tpi_Zbo_3e9355b1a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

