module 0x5fdca67c8213fafefe227d925e546534b2303c7e44131fddcf0a2dd7c6b46990::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        image_url: 0x2::url::Url,
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/nftimagebucket/tokens/0x69226261e908d24b0127ad890c467080fedd7090/TVRjeE5EUTUTNDU1T1E9PV8xODE4.png"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/nftimagebucket/tokens/0x69226261e908d24b0127ad890c467080fedd7090/TVRjeE5EUTNDU1T1E9PV8xODE4.png"),
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

