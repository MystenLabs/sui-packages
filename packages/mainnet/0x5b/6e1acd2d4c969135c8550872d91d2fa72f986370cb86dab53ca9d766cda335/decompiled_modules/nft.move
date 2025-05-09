module 0x5b6e1acd2d4c969135c8550872d91d2fa72f986370cb86dab53ca9d766cda335::nft {
    struct NFT has store, key {
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

    public fun transfer(arg0: NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(arg0, arg1);
    }

    public fun url(arg0: &NFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut vector<0x5b6e1acd2d4c969135c8550872d91d2fa72f986370cb86dab53ca9d766cda335::locker::Locker<T0>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = NFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = 2500;
        assert!(0x5b6e1acd2d4c969135c8550872d91d2fa72f986370cb86dab53ca9d766cda335::locker::get_scores<T0>(arg3) >= v2, 0);
        0x5b6e1acd2d4c969135c8550872d91d2fa72f986370cb86dab53ca9d766cda335::locker::consume_score<T0>(arg3, v2);
        let v3 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<NFT>(v1, v0);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

