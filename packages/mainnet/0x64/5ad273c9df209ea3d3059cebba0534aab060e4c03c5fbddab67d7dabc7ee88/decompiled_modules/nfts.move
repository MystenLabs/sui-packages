module 0x645ad273c9df209ea3d3059cebba0534aab060e4c03c5fbddab67d7dabc7ee88::nfts {
    struct NFTS has drop {
        dummy_field: bool,
    }

    struct Owner has key {
        id: 0x2::object::UID,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Owner{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<Owner>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{img_url}"));
        let v5 = 0x2::package::claim<NFTS>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &Owner, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x1::string::utf8(arg3),
        };
        0x2::transfer::transfer<NFT>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

