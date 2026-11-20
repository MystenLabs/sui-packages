module 0xa2bd801c5d43ff85d3d661705b75346f565e3587ca8687633b50b7d340c24997::vi {
    struct VI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<VI>(arg0, 9, 0x1::string::utf8(b"VI"), 0x1::string::utf8(b"vi"), 0x1::string::utf8(b"GTVI"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/59764a09c47bcd7fe918ea3b9a055df72cc45c212d46d30b785060c8471709af.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<VI>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VI>>(0x2::coin_registry::finalize<VI>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<VI>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

