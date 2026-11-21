module 0xa52e004f63509ef5043e3e0ea8eea7a4667ac789f6a1e74481e9ac93e47637b4::fb {
    struct FB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<FB>(arg0, 9, 0x1::string::utf8(b"FB"), 0x1::string::utf8(b"fun blast"), 0x1::string::utf8(b"Fun blast"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/5c0829563f7e847014696b0c9c513171dc843ec8084f2520b2b8aaca8fae1054.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FB>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FB>>(0x2::coin_registry::finalize<FB>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<FB>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

