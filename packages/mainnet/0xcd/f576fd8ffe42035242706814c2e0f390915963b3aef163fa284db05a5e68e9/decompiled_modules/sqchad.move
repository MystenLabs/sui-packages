module 0xcdf576fd8ffe42035242706814c2e0f390915963b3aef163fa284db05a5e68e9::sqchad {
    struct SQCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQCHAD>(arg0, 6, b"SQCHAD", b"SQUIDCHARD", x"535155494443484152443a20546865204769676163686164206f662074686520536561200a41726520796f75207469726564206f662076697267696e20746f6b656e733f204469766520696e746f2074686520776f726c64206f662053515549444348415244210a0a537175696477617264277320676c6f772d7570207765206e65766572206b6e6577207765206e65656465640a4d6f72652074656e7461636c6573203d206d6f7265206761696e730a436c6172696e65742d706f776572656420626c6f636b636861696e0a313030252073616c7477617465722d70726f6f6620736d61727420636f6e747261637473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/The_Two_Faces_of_Squidward_174_a4319e759b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQCHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

