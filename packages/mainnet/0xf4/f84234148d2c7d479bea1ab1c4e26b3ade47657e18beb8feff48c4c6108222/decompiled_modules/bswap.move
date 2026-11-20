module 0xf4f84234148d2c7d479bea1ab1c4e26b3ade47657e18beb8feff48c4c6108222::bswap {
    struct BSWAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BSWAP>(arg0, 9, 0x1::string::utf8(b"BSWAP"), 0x1::string::utf8(b"BlueSwap"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/c85efbadaeca1391d4e01997f3d393a7d03a14f25ba6256bf48451fb69a6f536.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BSWAP>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BSWAP>>(0x2::coin_registry::finalize<BSWAP>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BSWAP>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

