module 0xc16a46a42ffe2db3996a402dd0bb247d91e090738227c89a19a9e78c6feffed1::nft_minter {
    struct NFT_MINTER has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Minted has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    fun init(arg0: NFT_MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT_MINTER>(arg0, arg1);
        let v1 = 0x2::display::new<NFT>(&v0, arg1);
        0x2::display::add<NFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<NFT>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<NFT>>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
        };
        let v2 = Minted{
            object_id : 0x2::object::id<NFT>(&v1),
            owner     : v0,
            name      : v1.name,
        };
        0x2::event::emit<Minted>(v2);
        0x2::transfer::public_transfer<NFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

