module 0x1c0ce5438a6797bd9cbdda86bfcc1bc8ecabd2103c5ac953ab3898cb38828b89::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        uri: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            uri         : 0x1::string::utf8(arg2),
        };
        0x2::transfer::transfer<NFT>(v1, v0);
        let v2 = NFTMinted{
            nft_id : 0x2::object::id<NFT>(&v1),
            owner  : v0,
            name   : 0x1::string::utf8(arg0),
        };
        0x2::event::emit<NFTMinted>(v2);
    }

    // decompiled from Move bytecode v6
}

