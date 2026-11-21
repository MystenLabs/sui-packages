module 0x3b0d6ec1039ad56663b5c59f2555a60d91e26abd1b402a47b4beaf843ec781a8::buyme {
    struct BUYME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUYME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BUYME>(arg0, 9, 0x1::string::utf8(b"BUYME"), 0x1::string::utf8(b"Buy me"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/4e12c8ec967616afb40bd245617db0fdf8782ae49732067150cfd31128ff0485.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BUYME>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BUYME>>(0x2::coin_registry::finalize<BUYME>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BUYME>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

