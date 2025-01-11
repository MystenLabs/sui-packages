module 0xa40879affdf7c837bcbdf12aad1f470a6177f88ed06b188ec1401b03299a009a::streaming_royalty {
    struct StreamingRoyalty has store, key {
        id: 0x2::object::UID,
        path: vector<u8>,
        owner: address,
    }

    // decompiled from Move bytecode v6
}

