module 0x99e23e21d0480cc53359acc1952c56959eac0166babef427ffaa608bc5d9eb36::eqx {
    struct EQX has drop {
        dummy_field: bool,
    }

    fun init(arg0: EQX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<EQX>(arg0, 9, 0x1::string::utf8(b"EQX"), 0x1::string::utf8(b"EQX"), 0x1::string::utf8(b"EXQ COIN"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/fd6d46effcfb253fa0e441abf5198a9ecb4848be3168f305ec6efd029aaf92c7.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<EQX>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<EQX>>(0x2::coin_registry::finalize<EQX>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<EQX>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

