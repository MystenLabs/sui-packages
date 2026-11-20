module 0x9d5ec8cc6400336cf46b609836e048ef4e3e95b0c0acdfe77efdd388e52733e8::nig {
    struct NIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<NIG>(arg0, 9, 0x1::string::utf8(b"NIG"), 0x1::string::utf8(b"niga"), 0x1::string::utf8(b"niga fan token"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/acdbe03537479fcea586959494bb68f9f0a334b1a8bc5a8e90b60233cc12b8d6.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NIG>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NIG>>(0x2::coin_registry::finalize<NIG>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<NIG>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

