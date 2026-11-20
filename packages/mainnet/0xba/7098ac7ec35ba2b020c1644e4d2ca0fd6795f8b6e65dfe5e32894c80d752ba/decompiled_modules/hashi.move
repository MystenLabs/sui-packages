module 0xba7098ac7ec35ba2b020c1644e4d2ca0fd6795f8b6e65dfe5e32894c80d752ba::hashi {
    struct HASHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<HASHI>(arg0, 9, 0x1::string::utf8(b"HASHI"), 0x1::string::utf8(b"Hashi"), 0x1::string::utf8(x"f09f90b120436f6d6d756e6974792d64726976656e206d656d652063656c6562726174696e67204861736869e2809973206c61756e6368206f6e2053756920f09f92a7"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/7a0fb072ca57d233c464fae76eca0fd4dda034f01f223560befa6608014d0107.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HASHI>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HASHI>>(0x2::coin_registry::finalize<HASHI>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<HASHI>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

