module 0x772bd3248f6e1e1892319b8a81ea1179a7225484eba306103df06d3c5f5cc6ed::qaopen {
    struct QAOPEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QAOPEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<QAOPEN>(arg0, 9, 0x1::string::utf8(b"QAOPEN"), 0x1::string::utf8(b"Blast QA Open TSUI"), 0x1::string::utf8(b"Blast QA test asset. TSUI market. No real value."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<QAOPEN>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<QAOPEN>>(0x2::coin_registry::finalize<QAOPEN>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<QAOPEN>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

