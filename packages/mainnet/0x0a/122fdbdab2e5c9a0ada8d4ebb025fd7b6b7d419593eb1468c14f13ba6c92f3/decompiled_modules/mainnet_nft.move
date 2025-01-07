module 0xa122fdbdab2e5c9a0ada8d4ebb025fd7b6b7d419593eb1468c14f13ba6c92f3::mainnet_nft {
    struct MainNetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        thumbnail_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: MainNetNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MainNetNFT>(arg0, arg1);
    }

    public fun burn(arg0: MainNetNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MainNetNFT {
            id            : v0,
            name          : _,
            description   : _,
            image_url     : _,
            thumbnail_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &MainNetNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &MainNetNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = MainNetNFT{
            id            : 0x2::object::new(arg4),
            name          : 0x1::string::utf8(arg0),
            description   : 0x1::string::utf8(arg1),
            image_url     : 0x2::url::new_unsafe_from_bytes(arg2),
            thumbnail_url : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<MainNetNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<MainNetNFT>(v1, v0);
    }

    public fun name(arg0: &MainNetNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun thumbnail_url(arg0: &MainNetNFT) : &0x2::url::Url {
        &arg0.thumbnail_url
    }

    public fun update_description(arg0: &mut MainNetNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

