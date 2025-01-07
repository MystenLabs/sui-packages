module 0xef249db66e187f4ed0800b633cf5ea1ab12ea79466b0ab97eea69b767e2be7b3::lifejwang11_nft {
    struct Lifejwang11_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun mint_NFT(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Lifejwang11_NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"lifejwang11_NFT"),
            description : 0x1::string::utf8(b"lifejwang11's NFT"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/42738764?v=4"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<Lifejwang11_NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<Lifejwang11_NFT>(v1, v0);
    }

    public entry fun transferNFT(arg0: Lifejwang11_NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Lifejwang11_NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

