module 0x9957f21447fa4d510f20e436a7c3e123c244c41a3e9bf0903365a3df20298093::tr {
    struct TR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<TR>(arg0, 9, 0x1::string::utf8(b"TR"), 0x1::string::utf8(b"TRUMP"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/970dca8fb425c562c0ca916623d1a1fc50d8febcdbe29814fc5a8ee323289b1a.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TR>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TR>>(0x2::coin_registry::finalize<TR>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<TR>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

