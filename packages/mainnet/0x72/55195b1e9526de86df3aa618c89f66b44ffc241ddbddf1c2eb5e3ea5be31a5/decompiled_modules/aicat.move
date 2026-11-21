module 0x7255195b1e9526de86df3aa618c89f66b44ffc241ddbddf1c2eb5e3ea5be31a5::aicat {
    struct AICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<AICAT>(arg0, 9, 0x1::string::utf8(b"AICAT"), 0x1::string::utf8(b"AICAT"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/02ecb1f0b407e54b24c248a2c254ef9d876a42aec7d0d12da7fe230fd0b4b58f.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<AICAT>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AICAT>>(0x2::coin_registry::finalize<AICAT>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<AICAT>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

