module 0x8a24551ca06b0688a1127ad0651a9dc89bce3a1899e492228169f083a84c5047::kares {
    struct KARES has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<KARES>(arg0, 9, 0x1::string::utf8(b"KARES"), 0x1::string::utf8(b"KARES"), 0x1::string::utf8(b"KARES is the AresRPG game token."), 0x1::string::utf8(b"https://aresrpg.world/kares.png"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<KARES>>(v1, 0x2::tx_context::sender(arg1));
        if (true) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<KARES>>(0x2::coin_registry::finalize<KARES>(v0, arg1), @0x37cf46b499f740e653644bd2f7a8ed97f248e8b3c69d5d12c97d7845a54c0cd8);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<KARES>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

