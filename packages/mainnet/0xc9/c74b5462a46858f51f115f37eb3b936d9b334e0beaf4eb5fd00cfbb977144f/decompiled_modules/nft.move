module 0xc9c74b5462a46858f51f115f37eb3b936d9b334e0beaf4eb5fd00cfbb977144f::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct RewardNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: address,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun batch_mint(arg0: vector<address>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v1 = RewardNFT{
                id          : 0x2::object::new(arg4),
                name        : 0x1::string::utf8(arg1),
                description : 0x1::string::utf8(arg2),
                image_url   : 0x1::string::utf8(arg3),
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
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &RewardNFT) : 0x1::string::String {
        arg0.description
    }

    public fun image_url(arg0: &RewardNFT) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiscan.xyz"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RewardNFT>>(0x2::display::new_with_fields<RewardNFT>(&v4, v0, v2, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = RewardNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
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
            image_url   : 0x1::string::utf8(arg3),
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

