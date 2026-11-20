module 0x34c1749c40571ae39c8253faf89aa28cb30e18cf7b2823106f327dc6ed8edf1c::nogas {
    struct NOGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<NOGAS>(arg0, 9, 0x1::string::utf8(b"NOGAS"), 0x1::string::utf8(b"Nogas"), 0x1::string::utf8(b"Built Thin.Moves Faster."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b8bba38bed7173eeb48f9556d6ab73cb0f5ef8da33fd90ed42b6372e9f600f25.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOGAS>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NOGAS>>(0x2::coin_registry::finalize<NOGAS>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<NOGAS>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

