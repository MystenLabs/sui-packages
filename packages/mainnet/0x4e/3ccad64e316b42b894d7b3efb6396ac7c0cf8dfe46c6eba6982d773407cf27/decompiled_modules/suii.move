module 0x4e3ccad64e316b42b894d7b3efb6396ac7c0cf8dfe46c6eba6982d773407cf27::suii {
    struct SUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<SUII>(arg0, 9, 0x1::string::utf8(b"SUII"), 0x1::string::utf8(b"SUII"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b9b7d4129eba9d1a58c729b3a195cd63c66ce9b10cee027c44d36050ca6cc600.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SUII>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUII>>(0x2::coin_registry::finalize<SUII>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<SUII>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

