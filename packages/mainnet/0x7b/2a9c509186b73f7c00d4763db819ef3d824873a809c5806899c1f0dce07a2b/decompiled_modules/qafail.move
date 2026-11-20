module 0x7b2a9c509186b73f7c00d4763db819ef3d824873a809c5806899c1f0dce07a2b::qafail {
    struct QAFAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: QAFAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<QAFAIL>(arg0, 9, 0x1::string::utf8(b"QAFAIL"), 0x1::string::utf8(b"Blast QA Refund TSUI"), 0x1::string::utf8(b"Blast QA test asset. TSUI market. No real value."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<QAFAIL>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<QAFAIL>>(0x2::coin_registry::finalize<QAFAIL>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<QAFAIL>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

