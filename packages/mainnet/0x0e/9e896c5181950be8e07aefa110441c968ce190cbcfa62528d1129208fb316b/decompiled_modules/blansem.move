module 0xe9e896c5181950be8e07aefa110441c968ce190cbcfa62528d1129208fb316b::blansem {
    struct BLANSEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLANSEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BLANSEM>(arg0, 9, 0x1::string::utf8(b"BLANSEM"), 0x1::string::utf8(b"BLANSEM THE BLUE BULL"), 0x1::string::utf8(b"The Blue Bull charges forward no matter what. Born on Sui, $BLANSEM brings the bull spirit to the blue chain."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/70ca459f4ac39e4f7374f4b851c99559b4f698438084a7334a4b2ccd821308a5.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLANSEM>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BLANSEM>>(0x2::coin_registry::finalize<BLANSEM>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BLANSEM>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

