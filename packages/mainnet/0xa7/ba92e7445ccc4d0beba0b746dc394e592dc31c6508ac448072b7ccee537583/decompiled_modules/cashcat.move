module 0xa7ba92e7445ccc4d0beba0b746dc394e592dc31c6508ac448072b7ccee537583::cashcat {
    struct CASHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<CASHCAT>(arg0, 9, 0x1::string::utf8(b"CASHCAT"), 0x1::string::utf8(b"Cashcat"), 0x1::string::utf8(b"Cashcat"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/802c0a8d93f75a57619b4d117a28024a5d3485466cd95cc9eb3148852669f687.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CASHCAT>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CASHCAT>>(0x2::coin_registry::finalize<CASHCAT>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<CASHCAT>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

