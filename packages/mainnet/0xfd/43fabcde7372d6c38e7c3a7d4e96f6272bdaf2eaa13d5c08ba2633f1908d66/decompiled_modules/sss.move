module 0xfd43fabcde7372d6c38e7c3a7d4e96f6272bdaf2eaa13d5c08ba2633f1908d66::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<SSS>(arg0, 9, 0x1::string::utf8(b"SSS"), 0x1::string::utf8(b"Six Star Syndicate"), 0x1::string::utf8(b"Six stars one legendary syndicate Welcome to the streets of Vice City"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/6f6667a16fc069bacfb33266406c3616d2021e19ef6a7db29e975dca77fc93cc.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SSS>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SSS>>(0x2::coin_registry::finalize<SSS>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<SSS>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

