module 0x9f5f9a834d81038b8b959d8e8d24b0242a676bae6f711652f5f5199a4edadf7e::spritecat {
    struct SPRITECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRITECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRITECAT>(arg0, 6, b"SPRITECAT", b"SpriteCat Coin", x"496e74726f647563696e672053707269746543617420436f696e202853505249544543415429200a4469766520696e746f2074686520706978656c6174656420776f726c64206f66205370726974654361742c2074686520756c74696d6174652063727970746f206d6173636f742064657369676e656420746f206272696e672066756e20616e6420666f7274756e6520746f20796f75722077616c6c65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y28_S_Phwn_Bjacp2_Kjtx8_Uxb_A2n_GAD_Un_G_Hbbsbjh6s1_K9_Y_1_8090691cb6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRITECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRITECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

