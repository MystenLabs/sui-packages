module 0x613adc95b0e9efd84baa6469d83398af40501aa684e5374165a230105645b1ce::pub {
    struct PUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<PUB>(arg0, 9, 0x1::string::utf8(b"PUB"), 0x1::string::utf8(b"pugy blast"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/eb72f3ca674683e395c7a6fd8d4e4e7df4c7797dce0b118db7e31791576b69ab.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PUB>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PUB>>(0x2::coin_registry::finalize<PUB>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<PUB>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

