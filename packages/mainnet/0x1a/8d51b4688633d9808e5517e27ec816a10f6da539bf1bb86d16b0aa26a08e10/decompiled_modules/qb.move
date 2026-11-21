module 0x1a8d51b4688633d9808e5517e27ec816a10f6da539bf1bb86d16b0aa26a08e10::qb {
    struct QB has drop {
        dummy_field: bool,
    }

    fun init(arg0: QB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<QB>(arg0, 9, 0x1::string::utf8(b"QB"), 0x1::string::utf8(b"Queen Bast"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/4a2fadbecebc510049203a936744b456a8e7bd075ed1075ce07bf9e33c74d810.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<QB>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<QB>>(0x2::coin_registry::finalize<QB>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<QB>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

