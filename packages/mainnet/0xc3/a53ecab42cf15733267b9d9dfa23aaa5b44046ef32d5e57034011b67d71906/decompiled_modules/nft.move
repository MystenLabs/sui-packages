module 0xc3a53ecab42cf15733267b9d9dfa23aaa5b44046ef32d5e57034011b67d71906::nft {
    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: Nft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Nft>(arg0, arg1);
    }

    public fun url(arg0: &Nft) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: Nft, arg1: &mut 0x2::tx_context::TxContext) {
        let Nft {
            id          : v0,
            name        : _,
            description : _,
            creator     : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun creator(arg0: &Nft) : &address {
        &arg0.creator
    }

    public fun description(arg0: &Nft) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Nft{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            creator     : v0,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<Nft>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<Nft>(v1, v0);
    }

    public fun name(arg0: &Nft) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut Nft, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

