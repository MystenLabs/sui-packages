module 0x126377d1dee14627d19bea75ee8eed5633cbc5a4e0038bcdd3ee4369a2262b8f::my_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MY_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io/hero/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"tyasrioChao's first NFT!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/tyasrioChao"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"tyasrioChao"));
        let v4 = 0x2::package::claim<MY_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : NFT {
        NFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        }
    }

    public entry fun mint_and_transfer(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"tyasrioChao NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/19268838?s=400&u=ff7faa3dca89a24680e28a78d6562b2d69cf7246&v=4"),
        };
        0x2::transfer::transfer<NFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

