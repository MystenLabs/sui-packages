module 0xdd3e20ab5abe5946dd17fcb7475802f1b780fd8452a1da4882f852b4ef3e0d8d::blastoff {
    struct BLASTOFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTOFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BLASTOFF>(arg0, 9, 0x1::string::utf8(b"BLASTOFF"), 0x1::string::utf8(b"BlastOff"), 0x1::string::utf8(b"Pink rocket. No brakes. $BLASTOFF on  @SuiNetwork , and yes, there's a game."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/e8a94ab348b182a867a627d88cfc90a2db94b991703f023ec4b3f1ccf1c81b61.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLASTOFF>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BLASTOFF>>(0x2::coin_registry::finalize<BLASTOFF>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BLASTOFF>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

