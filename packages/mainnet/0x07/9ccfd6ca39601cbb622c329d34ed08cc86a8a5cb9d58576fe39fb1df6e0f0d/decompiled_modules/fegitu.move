module 0x79ccfd6ca39601cbb622c329d34ed08cc86a8a5cb9d58576fe39fb1df6e0f0d::fegitu {
    struct FEGITU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEGITU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<FEGITU>(arg0, 9, 0x1::string::utf8(b"FEGITU"), 0x1::string::utf8(b"Fegitup"), 0x1::string::utf8(b"Fegitup on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FEGITU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FEGITU>>(0x2::coin_registry::finalize<FEGITU>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

