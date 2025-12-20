module 0x7bcea591beaeb1173f9c477fc1870d7b3e17569b550a9177d28585398f748002::nft {
    struct RewardNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: address,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &RewardNFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun batch_mint(arg0: vector<address>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v1 = RewardNFT{
                id          : 0x2::object::new(arg4),
                name        : 0x1::string::utf8(arg1),
                description : 0x1::string::utf8(arg2),
                url         : 0x2::url::new_unsafe_from_bytes(arg3),
            };
            let v2 = NFTMinted{
                object_id : 0x2::object::uid_to_address(&v1.id),
                creator   : 0x2::tx_context::sender(arg4),
                name      : v1.name,
            };
            0x2::event::emit<NFTMinted>(v2);
            0x2::transfer::public_transfer<RewardNFT>(v1, *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun burn(arg0: RewardNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let RewardNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &RewardNFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = RewardNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::uid_to_address(&v1.id),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<RewardNFT>(v1, v0);
    }

    public entry fun mint_to(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::uid_to_address(&v0.id),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<RewardNFT>(v0, arg0);
    }

    public fun name(arg0: &RewardNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: RewardNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<RewardNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

