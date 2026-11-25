module 0x761661545f0b9a927eccb622dd563573686f2e28d10133d1b5570d70ae881b15::aqr {
    struct AQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<AQR>(arg0, 9, 0x1::string::utf8(b"AQR"), 0x1::string::utf8(b"AQRIVO"), 0x1::string::utf8(x"41515249564f20e28093204275696c64696e67206120536d61727465722026205361666572204469676974616c20576f726c642e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/905129cdfc870b0e1b8127d01cfb1e75afad3023cf599048b67dc1e0491eb994.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<AQR>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AQR>>(0x2::coin_registry::finalize<AQR>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<AQR>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

