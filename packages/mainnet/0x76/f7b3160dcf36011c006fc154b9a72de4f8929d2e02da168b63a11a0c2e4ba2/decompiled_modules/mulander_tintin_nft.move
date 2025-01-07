module 0x76f7b3160dcf36011c006fc154b9a72de4f8929d2e02da168b63a11a0c2e4ba2::mulander_tintin_nft {
    struct MULANDER_TINTIN_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct EventNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        owner: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: MULANDER_TINTIN_NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MULANDER_TINTIN_NFT>(arg0, arg1);
    }

    public fun url(arg0: &MULANDER_TINTIN_NFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: MULANDER_TINTIN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MULANDER_TINTIN_NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &MULANDER_TINTIN_NFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MULANDER_TINTIN_NFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = EventNFTMinted{
            object_id : 0x2::object::id<MULANDER_TINTIN_NFT>(&v0),
            creator   : 0x2::tx_context::sender(arg4),
            owner     : arg3,
            name      : v0.name,
        };
        0x2::event::emit<EventNFTMinted>(v1);
        0x2::transfer::public_transfer<MULANDER_TINTIN_NFT>(v0, arg3);
    }

    public fun name(arg0: &MULANDER_TINTIN_NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut MULANDER_TINTIN_NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

