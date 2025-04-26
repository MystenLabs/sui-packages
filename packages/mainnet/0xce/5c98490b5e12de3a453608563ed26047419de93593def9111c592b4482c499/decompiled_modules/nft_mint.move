module 0xce5c98490b5e12de3a453608563ed26047419de93593def9111c592b4482c499::nft_mint {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct NFT_MINT has drop {
        dummy_field: bool,
    }

    struct Dummy has store, key {
        id: 0x2::object::UID,
    }

    public entry fun create_dummy(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dummy{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Dummy>(v0, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: NFT_MINT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NFT_MINT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = 0x2::display::new<NFT>(arg0, arg4);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, arg1);
        0x1::vector::push_back<0x1::string::String>(v4, arg2);
        0x1::vector::push_back<0x1::string::String>(v4, arg3);
        0x2::display::add_multiple<NFT>(&mut v0, v1, v3);
        0x2::display::update_version<NFT>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v0, 0x2::tx_context::sender(arg4));
        NFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            url         : arg3,
        }
    }

    public entry fun mint_and_send(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(mint(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    public entry fun test_dummy_object(arg0: &Dummy, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

