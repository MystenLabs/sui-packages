module 0x9747cbde5e16fd2ed9bf6439c10d1d82b933e79284598c73da73038bdda75a35::goon {
    struct GOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<GOON>(arg0, 9, 0x1::string::utf8(b"GOON"), 0x1::string::utf8(b"GOON"), 0x1::string::utf8(b"Gooner"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a7949c369162a9a9ee1adcd69bc17ca1e35146a7c83e1799018a2dafb0f1ca30.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GOON>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GOON>>(0x2::coin_registry::finalize<GOON>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<GOON>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

