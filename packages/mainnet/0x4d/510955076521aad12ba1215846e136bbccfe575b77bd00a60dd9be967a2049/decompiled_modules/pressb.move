module 0x4d510955076521aad12ba1215846e136bbccfe575b77bd00a60dd9be967a2049::pressb {
    struct PRESSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<PRESSB>(arg0, 9, 0x1::string::utf8(b"PRESSB"), 0x1::string::utf8(b"Pressed B."), 0x1::string::utf8(b"Every game has that moment. No time to think. No time to read. You either hit it or you don't. I pressed B, do you?!"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/fc42cd8f1de8aafcbf0f592ced42e156787ceae2da19bce4a2db8a6a6f828673.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PRESSB>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PRESSB>>(0x2::coin_registry::finalize<PRESSB>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<PRESSB>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

