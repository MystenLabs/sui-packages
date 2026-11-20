module 0x8f07d742ec4004e884e67aec52f3b683e92b3ce24bb1e6b92ffd099860131da6::jesus {
    struct JESUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<JESUS>(arg0, 9, 0x1::string::utf8(b"JESUS"), 0x1::string::utf8(b"Jesus"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<JESUS>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<JESUS>>(0x2::coin_registry::finalize<JESUS>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<JESUS>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

