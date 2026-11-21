module 0x975324dffe0335fb30324d311e1ad56e9f3c710f4b40677bbfeb5d3a6df8c60e::npunk {
    struct NPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<NPUNK>(arg0, 9, 0x1::string::utf8(b"NPUNK"), 0x1::string::utf8(b"Near Punks"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/e47cbee3796b1b05ba0209b27cb9dd8ab0c63f57aba896adf40747abb42bfa0b.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NPUNK>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NPUNK>>(0x2::coin_registry::finalize<NPUNK>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<NPUNK>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

