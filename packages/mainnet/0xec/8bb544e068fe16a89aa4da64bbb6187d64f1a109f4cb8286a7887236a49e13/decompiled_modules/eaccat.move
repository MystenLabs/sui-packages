module 0xec8bb544e068fe16a89aa4da64bbb6187d64f1a109f4cb8286a7887236a49e13::eaccat {
    struct EACCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EACCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<EACCAT>(arg0, 9, 0x1::string::utf8(b"EACCAT"), 0x1::string::utf8(b"eaccat"), 0x1::string::utf8(b"The cat accelerates"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f2925d10d503fbe767d8499d901971d4c86f38ce05dd5dd6bd70a03e8c5f3ccf.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<EACCAT>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<EACCAT>>(0x2::coin_registry::finalize<EACCAT>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<EACCAT>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

