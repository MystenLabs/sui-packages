module 0x25a386775351611a3007943448b9b013ab65b79e71470576eac840cca5ce3185::never {
    struct NEVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<NEVER>(arg0, 6, 0x1::string::utf8(b"NEVER"), 0x1::string::utf8(b"Never"), 0x1::string::utf8(b"97% locked till 2300. see you never"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/P3bJPJ2b2_spcCFYszO45dM7nHun8_OYoUOvBrJkw7YBAQAJAA"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NEVER>>(v1, 0x2::tx_context::sender(arg1));
        if (true) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NEVER>>(0x2::coin_registry::finalize<NEVER>(v0, arg1), @0x81a73ddedd642dad2dc375110e7cddefc4a52cb872c2f5c2c1e54ebcf798324a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<NEVER>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

