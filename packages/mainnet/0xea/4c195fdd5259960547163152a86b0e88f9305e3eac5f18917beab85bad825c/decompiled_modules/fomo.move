module 0xea4c195fdd5259960547163152a86b0e88f9305e3eac5f18917beab85bad825c::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<FOMO>(arg0, 9, 0x1::string::utf8(b"FOMO"), 0x1::string::utf8(b"fomo"), 0x1::string::utf8(b"The next big move starts before you notice. Don't miss FOMO."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f95ac8d6840af2306bbd8599c4a6f22bdece80dc072543cca161219f4747d169.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FOMO>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FOMO>>(0x2::coin_registry::finalize<FOMO>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<FOMO>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

