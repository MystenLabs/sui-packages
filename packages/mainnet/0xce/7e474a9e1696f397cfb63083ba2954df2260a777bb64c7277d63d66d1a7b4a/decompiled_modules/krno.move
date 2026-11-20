module 0xce7e474a9e1696f397cfb63083ba2954df2260a777bb64c7277d63d66d1a7b4a::krno {
    struct KRNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<KRNO>(arg0, 9, 0x1::string::utf8(b"KRNO"), 0x1::string::utf8(b"Krono"), 0x1::string::utf8(b"Krono (KRNO) is a utility and DeFi token built on the Sui blockchain, designed f"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f2bc82d7091c8429f15beb134969eacc0d3b931eb5c4c3a78b44d90d07274982.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<KRNO>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<KRNO>>(0x2::coin_registry::finalize<KRNO>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<KRNO>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

