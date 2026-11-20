module 0x38f10f9555e34fc7920c00d79512bf4b41577dabcb95c3394cf32091fe3583a3::nogas {
    struct NOGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<NOGAS>(arg0, 6, 0x1::string::utf8(b"NOGAS"), 0x1::string::utf8(b"Nogas"), 0x1::string::utf8(b"Built Thin.Moves Faster."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a45e70f06cf5acdff47fcde1ca3cd1b3882e82c0671f3476e4cb3d5a5821bf46.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOGAS>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NOGAS>>(0x2::coin_registry::finalize<NOGAS>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<NOGAS>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

