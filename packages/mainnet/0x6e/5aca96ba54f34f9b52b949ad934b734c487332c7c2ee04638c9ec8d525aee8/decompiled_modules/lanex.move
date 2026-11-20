module 0x6e5aca96ba54f34f9b52b949ad934b734c487332c7c2ee04638c9ec8d525aee8::lanex {
    struct LANEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<LANEX>(arg0, 9, 0x1::string::utf8(b"LANEX"), 0x1::string::utf8(b"Lanex"), 0x1::string::utf8(b"Open market for AI inference. Sellers list GPU time, buyers pay per call, every receipt is signed."), 0x1::string::utf8(b"https://lanexai.xyz/x/x-pp.png"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LANEX>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LANEX>>(0x2::coin_registry::finalize<LANEX>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<LANEX>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

