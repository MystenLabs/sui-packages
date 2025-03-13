module 0xf139e873247da86bc02efde4b9eff70e418b20ed85dc9e40911e41e9778ecfb::mintNFT {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"MyNFT"),
            url  : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/200202346?s=400&u=0bf2998d9aa3fbc7db0ef75b0ce17540049dddb1&v=4"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun myMint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"MyNFT"),
            url  : arg0,
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun transer_nft(arg0: MyNFT, arg1: address) {
        0x2::transfer::public_transfer<MyNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

