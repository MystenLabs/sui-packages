module 0xd77ca45ffa684cecbea2268f319db1c638f5d865f2fde5c6e8cfee01bdcf5d88::nft_mint {
    struct NFT_MINT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        creator: address,
    }

    fun init(arg0: NFT_MINT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NFT_MINT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::display::new<NFT>(arg0, arg4);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, arg1);
        0x1::vector::push_back<0x1::string::String>(v5, arg2);
        0x1::vector::push_back<0x1::string::String>(v5, arg3);
        0x2::display::add_multiple<NFT>(&mut v1, v2, v4);
        0x2::display::update_version<NFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v1, v0);
        NFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            url         : arg3,
            creator     : v0,
        }
    }

    public entry fun mint_and_send(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<NFT>(mint(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v6
}

