module 0xb392a781e51687e28415c54dccfcddfd5482010d4bac092b638c678f2db7f2d3::tommy {
    struct TOMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<TOMMY>(arg0, 9, 0x1::string::utf8(b"TOMMY"), 0x1::string::utf8(b"TOMMY"), 0x1::string::utf8(b"GTA"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/6c5687e050164c295fd19c1f5202a5fc86aa9e88f294e0ca68f273baa229df35.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TOMMY>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TOMMY>>(0x2::coin_registry::finalize<TOMMY>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<TOMMY>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

