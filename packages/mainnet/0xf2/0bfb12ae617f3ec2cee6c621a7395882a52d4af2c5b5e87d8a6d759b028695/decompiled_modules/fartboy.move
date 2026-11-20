module 0xf20bfb12ae617f3ec2cee6c621a7395882a52d4af2c5b5e87d8a6d759b028695::fartboy {
    struct FARTBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<FARTBOY>(arg0, 6, 0x1::string::utf8(b"FARTBOY"), 0x1::string::utf8(b"FARTBOY"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/da431a5c26e96cd74ef9ad5162cfc5bcf0c8e013a5204347e9bcfee99171e040.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FARTBOY>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FARTBOY>>(0x2::coin_registry::finalize<FARTBOY>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<FARTBOY>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

