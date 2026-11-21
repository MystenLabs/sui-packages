module 0x3504654e946cc57206b5de5cc2d6a554f038aa1b710b777ca7a1def07faa6127::hb {
    struct HB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<HB>(arg0, 9, 0x1::string::utf8(b"HB"), 0x1::string::utf8(b"hype blast"), 0x1::string::utf8(b"blast"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/6111eb0be51abdcdfddb909646a4b92c582d161e67ed9e62e4e1872ba8fc6a41.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HB>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HB>>(0x2::coin_registry::finalize<HB>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<HB>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

