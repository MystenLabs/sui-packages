module 0x82c6cb8cfb3b5a1af9c97dc9ea335eff725643010a103e193070a8646ec423e9::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BCAT>(arg0, 9, 0x1::string::utf8(b"BCAT"), 0x1::string::utf8(b"Blast cat"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/3d897cd42fa3514be6c7220c4d2fa46d5ba8cfbf66134de3ce341a570a03942e.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BCAT>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BCAT>>(0x2::coin_registry::finalize<BCAT>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BCAT>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

