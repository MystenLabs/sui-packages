module 0xc91c1e200663193bf5a8e7a5f6f5df24dd5c8c8b79ba2d7a83c64e9ae6f0baa::qalate {
    struct QALATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QALATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<QALATE>(arg0, 9, 0x1::string::utf8(b"QALATE"), 0x1::string::utf8(b"Blast QA Public Window TSUI"), 0x1::string::utf8(b"Blast QA test asset. TSUI market. No real value."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<QALATE>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<QALATE>>(0x2::coin_registry::finalize<QALATE>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<QALATE>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

