module 0x294ff23c6664ed344a640a0ddea9cbd2066934b28fd58f1fe98887c4777ab944::my_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, @0x748ab0101702695a5624680710b9a470f89c6df5cbc4889a6159bb7d5c54f57f);
    }

    public entry fun mint(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id        : 0x2::object::new(arg4),
            name      : 0x1::string::utf8(b"SherVite NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/201323230?v=4"),
        };
        0x2::transfer::public_transfer<NFT>(v0, arg3);
    }

    public entry fun mint_github_avatar(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        mint(arg0, b"My GitHub NFT", b"https://avatars.githubusercontent.com/u/201323230?v=4", arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

