module 0xe2ef49267647fa49d006634df5d3821b62ade08a66a30b34f9fc54aaf78286a0::mmaa666_nft {
    struct MMAA666NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MMAA666NFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"MMVV666 NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/183964006?s=400&u=77deb2250e988591d6f9c62bb4d6c2045fa63b8d&v=4"),
        };
        0x2::transfer::transfer<MMAA666NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MMAA666NFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"MMVV666 NFT"),
            image_url : arg0,
        };
        0x2::transfer::transfer<MMAA666NFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_nft(arg0: MMAA666NFT, arg1: address) {
        0x2::transfer::transfer<MMAA666NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

