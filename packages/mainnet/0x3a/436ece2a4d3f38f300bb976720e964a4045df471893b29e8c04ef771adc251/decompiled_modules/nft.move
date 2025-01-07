module 0x3a436ece2a4d3f38f300bb976720e964a4045df471893b29e8c04ef771adc251::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun transfer(arg0: NFT, arg1: address) {
        0x2::transfer::transfer<NFT>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Pings #1"),
            description : 0x1::string::utf8(b"A reaction to something big, capturing a moment of significant impact or change."),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://google.com"),
        };
        0x2::transfer::public_transfer<NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

