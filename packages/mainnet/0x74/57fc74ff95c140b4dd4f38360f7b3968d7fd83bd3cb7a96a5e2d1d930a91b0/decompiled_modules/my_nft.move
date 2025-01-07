module 0x7457fc74ff95c140b4dd4f38360f7b3968d7fd83bd3cb7a96a5e2d1d930a91b0::my_nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"suiceber NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/182899206?v=4&size=64"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_and_transfer_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg2),
            name      : arg1,
            image_url : arg0,
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

