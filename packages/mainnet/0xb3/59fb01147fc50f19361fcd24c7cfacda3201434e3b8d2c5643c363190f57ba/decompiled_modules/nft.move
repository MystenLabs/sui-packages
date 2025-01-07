module 0xb359fb01147fc50f19361fcd24c7cfacda3201434e3b8d2c5643c363190f57ba::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct NewNFT has copy, drop {
        minter: address,
        id: 0x2::object::ID,
    }

    struct NFTObject has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFTObject>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFTObject>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFTObject>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = NFTObject{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(arg0),
            image_url : 0x1::string::utf8(arg1),
        };
        let v2 = NewNFT{
            minter : v0,
            id     : 0x2::object::id<NFTObject>(&v1),
        };
        0x2::event::emit<NewNFT>(v2);
        0x2::transfer::public_transfer<NFTObject>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

