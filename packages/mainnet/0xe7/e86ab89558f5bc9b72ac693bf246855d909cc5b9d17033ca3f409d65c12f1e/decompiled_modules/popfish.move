module 0xe7e86ab89558f5bc9b72ac693bf246855d909cc5b9d17033ca3f409d65c12f1e::popfish {
    struct POPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPFISH>(arg0, 6, 0x1::string::utf8(b"POPFISH"), 0x1::string::utf8(b"Pop FIsh"), 0x1::string::utf8(x"5468652068756e677269657374206669736820696e2074686520537569206f6365616e0a426967206d6f7574680a536d616c6c20627261696e0a4a757374207377696d6d696e670a504f50"), 0x1::string::utf8(b"https://popularsui.xyz/media/a0d3d028c303f04a72943eca2d79fe0af58765fcf5ad4e6982820b88e9a2a8f0.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPFISH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPFISH>>(0x2::coin_registry::finalize<POPFISH>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

