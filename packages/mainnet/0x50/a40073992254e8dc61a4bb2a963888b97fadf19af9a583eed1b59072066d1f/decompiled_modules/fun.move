module 0x50a40073992254e8dc61a4bb2a963888b97fadf19af9a583eed1b59072066d1f::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<FUN>(arg0, 9, 0x1::string::utf8(b"FUN"), 0x1::string::utf8(b"fun"), 0x1::string::utf8(b"for fun"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/90262464c23d8aa8d0bcbf384ccff4f257096450a1d22531eb26c8f916e1fbc5.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FUN>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FUN>>(0x2::coin_registry::finalize<FUN>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<FUN>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

