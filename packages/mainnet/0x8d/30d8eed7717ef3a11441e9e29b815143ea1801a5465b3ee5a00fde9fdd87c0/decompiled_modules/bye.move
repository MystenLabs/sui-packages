module 0x8d30d8eed7717ef3a11441e9e29b815143ea1801a5465b3ee5a00fde9fdd87c0::bye {
    struct BYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BYE>(arg0, 9, 0x1::string::utf8(b"BYE"), 0x1::string::utf8(b"Calm Squirrel"), 0x1::string::utf8(x"4d61726b65747320617265206372617368696e672c20627574207765206a75737420776176652026206368696c6c2e204a6f696e207468652063616c6d6573742072696465206f6e205375692120f09f90bf"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f1baf7277fd3a119c600643a56dda13084eb37df567e4e3e6e22ff97f5ae898f.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BYE>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BYE>>(0x2::coin_registry::finalize<BYE>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BYE>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

