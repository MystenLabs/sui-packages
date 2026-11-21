module 0x68538654274531e092a1f6c2e4d7bfd7f693f923082489d75e9e8972dbd5bb32::gays {
    struct GAYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<GAYS>(arg0, 9, 0x1::string::utf8(b"GAYS"), 0x1::string::utf8(b"Gays!!"), 0x1::string::utf8(b"Google, apple, yahoo, spaces"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/c69bd2cfaf286392aabda7311127af6cc90a7f1c4ae2940a605388a16cdc7435.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GAYS>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GAYS>>(0x2::coin_registry::finalize<GAYS>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<GAYS>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

