module 0xff77c6599789ecc30642db1bdeb9e972d4cf9214570b357862ee5d28d28d5388::web3richer_nft {
    struct Web3RicherNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Web3RicherNFTMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Web3RicherNFTTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public entry fun transfer(arg0: Web3RicherNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Web3RicherNFTTransferEvent{
            object_id : 0x2::object::id<Web3RicherNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<Web3RicherNFTTransferEvent>(v0);
        0x2::transfer::public_transfer<Web3RicherNFT>(arg0, arg1);
    }

    public fun url(arg0: &Web3RicherNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: Web3RicherNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let Web3RicherNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Web3RicherNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Web3RicherNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = Web3RicherNFTMintEvent{
            object_id : 0x2::object::id<Web3RicherNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<Web3RicherNFTMintEvent>(v2);
        0x2::transfer::public_transfer<Web3RicherNFT>(v1, v0);
    }

    public fun name(arg0: &Web3RicherNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut Web3RicherNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

