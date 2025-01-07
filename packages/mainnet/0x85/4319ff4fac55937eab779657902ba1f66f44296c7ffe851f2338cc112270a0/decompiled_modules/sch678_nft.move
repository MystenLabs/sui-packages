module 0x854319ff4fac55937eab779657902ba1f66f44296c7ffe851f2338cc112270a0::sch678_nft {
    struct SCH678_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMintedEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: SCH678_NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SCH678_NFT>(arg0, arg1);
    }

    public fun url(arg0: &SCH678_NFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: SCH678_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SCH678_NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SCH678_NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = SCH678_NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMintedEvent{
            object_id : 0x2::object::id<SCH678_NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMintedEvent>(v2);
        0x2::transfer::public_transfer<SCH678_NFT>(v1, v0);
    }

    public fun name(arg0: &SCH678_NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut SCH678_NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

