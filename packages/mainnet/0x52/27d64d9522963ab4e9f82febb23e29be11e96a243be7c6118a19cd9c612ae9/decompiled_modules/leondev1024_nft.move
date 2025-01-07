module 0x5227d64d9522963ab4e9f82febb23e29be11e96a243be7c6118a19cd9c612ae9::leondev1024_nft {
    struct LEONDEV1024_NFT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::ascii::String,
        recipient: address,
    }

    fun init(arg0: LEONDEV1024_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/16557117?v=4"));
        let v4 = 0x2::package::claim<LEONDEV1024_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to(arg0: 0x1::ascii::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg0) > 0, 1);
        let v0 = NFT{
            id   : 0x2::object::new(arg2),
            name : arg0,
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v0),
            creator   : 0x2::tx_context::sender(arg2),
            name      : v0.name,
            recipient : arg1,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<NFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

