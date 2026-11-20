module 0xc9bd4455c522f5aa97a6bb860d10b351a2c0b80f2d6fad62913d32fa54c78a37::qalift {
    struct QALIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QALIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<QALIFT>(arg0, 9, 0x1::string::utf8(b"QALIFT"), 0x1::string::utf8(b"Blast QA Allowlist Cap Lift TSUI"), 0x1::string::utf8(b"Blast QA test asset. TSUI market. No real value."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<QALIFT>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<QALIFT>>(0x2::coin_registry::finalize<QALIFT>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<QALIFT>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

