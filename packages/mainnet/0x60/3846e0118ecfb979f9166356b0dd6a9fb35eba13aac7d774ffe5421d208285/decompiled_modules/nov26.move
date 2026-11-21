module 0x603846e0118ecfb979f9166356b0dd6a9fb35eba13aac7d774ffe5421d208285::nov26 {
    struct NOV26 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOV26, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<NOV26>(arg0, 9, 0x1::string::utf8(b"NOV26"), 0x1::string::utf8(b"Remember November"), 0x1::string::utf8(x"45766572796f6e652073616964204e6f76203230323620697320636f6d696e672e204e6f7720697427732061637475616c6c792068657265e280946a6f696e2074686520726964652120f09f8d82f09f90bfefb88f"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/9c45eaca143b8bb45abadb6056b8d2e75f51bf49449a740ee29073b6ec77ef26.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOV26>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NOV26>>(0x2::coin_registry::finalize<NOV26>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<NOV26>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

