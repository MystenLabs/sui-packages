module 0xdc0bf756f2249201807c08e9e54b2a2252a197ef0cf5e3d84ee4bfcde8101e41::nfttest {
    struct NFTtest has store, key {
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

    public fun transfer(arg0: NFTtest, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFTtest>(arg0, arg1);
    }

    public fun url(arg0: &NFTtest) : &0x2::url::Url {
        &arg0.url
    }

    public fun description(arg0: &NFTtest) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = NFTtest{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<NFTtest>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<NFTtest>(v1, v0);
    }

    public fun name(arg0: &NFTtest) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

