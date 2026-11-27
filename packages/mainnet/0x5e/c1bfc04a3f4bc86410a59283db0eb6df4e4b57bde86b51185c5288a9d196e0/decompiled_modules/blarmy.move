module 0x5ec1bfc04a3f4bc86410a59283db0eb6df4e4b57bde86b51185c5288a9d196e0::blarmy {
    struct BLARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BLARMY>(arg0, 9, 0x1::string::utf8(b"BLARMY"), 0x1::string::utf8(b"Blast Army"), 0x1::string::utf8(x"7765e280996c6c20626520676976696e67206177617920612066726565204e465420746f2074686f73652077686f20686f6c6420746865206d656d6520746f6b656e207769746820612076616c7565206f662061726f756e64203330205355492e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/1a8360dba4aca8419f9861332d46605e1f93c952e880467a55878e9ad3b79f97.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLARMY>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BLARMY>>(0x2::coin_registry::finalize<BLARMY>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BLARMY>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

