module 0xac9826a6f7056a72b60cc11c05639fa3160759a05a3fe3bd719ceaae68694794::my_nft {
    struct LittleMoreInterestingNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LittleMoreInterestingNFT{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"LittleMoreInteresting NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/12570729?v=4"),
        };
        0x2::transfer::public_transfer<LittleMoreInterestingNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_and_transfer(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LittleMoreInterestingNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"LittleMoreInteresting NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/12570729?v=4"),
        };
        0x2::transfer::public_transfer<LittleMoreInterestingNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

