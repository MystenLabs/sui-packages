module 0xd5c0a96f40b3a66661d0673639e66b792d75bf152fdba193224a315c852f658b::nex {
    struct NEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<NEX>(arg0, 9, 0x1::string::utf8(b"NEX"), 0x1::string::utf8(b"NEXORA"), 0x1::string::utf8(b"NEXORA ($NEX) is the next generation of Web3. Join early and grow with our community!"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/e2ad258e7ecfe4290961042909fb1f26179b0fdfc305190327071e9da48c1967.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NEX>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NEX>>(0x2::coin_registry::finalize<NEX>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<NEX>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

