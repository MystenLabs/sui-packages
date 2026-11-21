module 0xa41cc51f9d8c3b40fe6f04dda04c9e13cc86d0bd0cffecbbb7a59f7a3e15da3b::ninip {
    struct NINIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<NINIP>(arg0, 9, 0x1::string::utf8(b"NINIP"), 0x1::string::utf8(b"Ninip"), 0x1::string::utf8(b"Ninip on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NINIP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NINIP>>(0x2::coin_registry::finalize<NINIP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

