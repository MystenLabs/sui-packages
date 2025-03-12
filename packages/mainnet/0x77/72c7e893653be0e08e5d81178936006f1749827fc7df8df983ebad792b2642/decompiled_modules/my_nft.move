module 0x7772c7e893653be0e08e5d81178936006f1749827fc7df8df983ebad792b2642::my_nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: MyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MyNFT>(arg0, arg1);
    }

    public fun burn(arg0: MyNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MyNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &MyNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = MyNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"MUET NFT"),
            description : 0x1::string::utf8(b"This is my first NFT!"),
            url         : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/195670331?v=4"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<MyNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<MyNFT>(v1, v0);
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = MyNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"MUET NFT"),
            description : 0x1::string::utf8(b"This is my first NFT!"),
            url         : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/195670331?v=4"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<MyNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<MyNFT>(v1, v0);
    }

    public fun name(arg0: &MyNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut MyNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun url(arg0: &MyNFT) : &0x1::string::String {
        &arg0.url
    }

    // decompiled from Move bytecode v6
}

