module 0x62ac5889bb368a2b4af966aaf6975c71135adaf4fc4d441979fadd524e4b529f::anti {
    struct ANTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<ANTI>(arg0, 9, 0x1::string::utf8(b"ANTI"), 0x1::string::utf8(b"Anthropic Inu offical"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/532c59c601066d09055b4ce303e06da848e790763357f10e934bcda65cb81579.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ANTI>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ANTI>>(0x2::coin_registry::finalize<ANTI>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<ANTI>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

