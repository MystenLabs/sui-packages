module 0x7cc51a6fa3cd4f2b4587c0b1496a2abbf3fbcd8d8fc8fc594f372088680db26b::tetemu {
    struct TETEMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETEMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<TETEMU>(arg0, 9, 0x1::string::utf8(b"TETEMU"), 0x1::string::utf8(b"Tetemuv"), 0x1::string::utf8(b"Tetemuv on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TETEMU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TETEMU>>(0x2::coin_registry::finalize<TETEMU>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

