module 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::test_nft {
    struct TestNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    public fun creator(arg0: &TestNFT) : address {
        arg0.creator
    }

    public fun description(arg0: &TestNFT) : 0x1::string::String {
        arg0.description
    }

    public fun image_url(arg0: &TestNFT) : 0x1::string::String {
        arg0.image_url
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = TestNFT{
            id          : v0,
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
            creator     : v1,
        };
        let v3 = NFTMinted{
            nft_id  : 0x2::object::uid_to_inner(&v0),
            name    : v2.name,
            creator : v1,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<TestNFT>(v2, v1);
    }

    public entry fun mint_batch(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            mint(b"Test NFT #", b"A test NFT for auction platform", b"https://via.placeholder.com/400", arg1);
            v0 = v0 + 1;
        };
    }

    public fun name(arg0: &TestNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun quick_mint(arg0: &mut 0x2::tx_context::TxContext) {
        mint(b"Test NFT #1", b"A simple test NFT for auction testing", b"https://via.placeholder.com/400", arg0);
    }

    // decompiled from Move bytecode v6
}

