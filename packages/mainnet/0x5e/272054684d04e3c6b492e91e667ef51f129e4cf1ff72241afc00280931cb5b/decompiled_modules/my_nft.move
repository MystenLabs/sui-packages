module 0x5e272054684d04e3c6b492e91e667ef51f129e4cf1ff72241afc00280931cb5b::my_nft {
    struct MY_NFT has drop {
        dummy_field: bool,
    }

    struct Attribute has store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: vector<Attribute>,
    }

    fun init(arg0: MY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MY_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<MyNFT>(&v0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x2::display::add_multiple<MyNFT>(&mut v1, v2, v4);
        0x2::transfer::public_share_object<0x2::display::Display<MyNFT>>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) : MyNFT {
        let v0 = 0x1::vector::empty<Attribute>();
        let v1 = 0;
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4), 0);
        while (v1 < 0x1::vector::length<vector<u8>>(&arg3)) {
            let v2 = Attribute{
                key   : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v1)),
                value : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v1)),
            };
            0x1::vector::push_back<Attribute>(&mut v0, v2);
            v1 = v1 + 1;
        };
        MyNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : v0,
        }
    }

    // decompiled from Move bytecode v6
}

