module 0x210b6b061b330b4c772257fa072866975585be8120f4bc88659a961bd4ccd4b0::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<DB>(arg0, 9, 0x1::string::utf8(b"DB"), 0x1::string::utf8(b"Dvidia blast"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/c49db6df465ef1d672c3d1c038329231ba8a85b0f4fc6e89d9076585943d5df0.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DB>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DB>>(0x2::coin_registry::finalize<DB>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<DB>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

