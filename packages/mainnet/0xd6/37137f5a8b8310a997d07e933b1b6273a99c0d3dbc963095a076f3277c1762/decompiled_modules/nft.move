module 0xd637137f5a8b8310a997d07e933b1b6273a99c0d3dbc963095a076f3277c1762::nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct MyNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: MyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MyNFT>(arg0, arg1);
    }

    public fun url(arg0: &MyNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public fun burn(arg0: MyNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MyNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &MyNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == @0xd1627eef097a008aa76333f30e3b846f3f32a0167eec0083c93af8fee9733e63, 0);
        let v1 = MyNFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_url   : 0x2::url::new_unsafe(arg2),
        };
        let v2 = MyNFTMinted{
            object_id : 0x2::object::id<MyNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<MyNFTMinted>(v2);
        0x2::transfer::public_transfer<MyNFT>(v1, arg3);
    }

    public fun name(arg0: &MyNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

