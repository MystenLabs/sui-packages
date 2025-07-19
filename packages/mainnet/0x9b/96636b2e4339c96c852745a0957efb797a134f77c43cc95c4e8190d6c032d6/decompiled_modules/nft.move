module 0x9b96636b2e4339c96c852745a0957efb797a134f77c43cc95c4e8190d6c032d6::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        object_id: address,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun burn_nft(arg0: NFT) {
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_nft_info(arg0: &NFT) : (0x1::string::String, 0x1::string::String, 0x2::url::Url, address) {
        (arg0.name, arg0.description, arg0.url, arg0.creator)
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            creator     : v0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id_address<NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<NFT>(v1, v0);
    }

    public entry fun transfer_nft(arg0: NFT, arg1: address) {
        0x2::transfer::public_transfer<NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

