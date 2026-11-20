module 0xdc9b8cd26296f5f0276ab2ed284b16b9a2144fa888e53cd96671d5e88e3d3f3c::geg {
    struct GEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<GEG>(arg0, 9, 0x1::string::utf8(b"GEG"), 0x1::string::utf8(b"Golden Egg"), 0x1::string::utf8(b"A golden symbol of rarity and endless possibilities Built to shine and stand out"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/7a19127f0f3eebac35553e380b57de87c8c17da522a26616c3b3e7e1a4afc03b.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GEG>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GEG>>(0x2::coin_registry::finalize<GEG>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<GEG>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

