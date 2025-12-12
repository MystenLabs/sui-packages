module 0xf83e7ec4ef9ac2dce4ed211cf6a931a5019eadbca075f43e6f36073d68ef3b7f::my_nft {
    struct MY_NFT has drop {
        dummy_field: bool,
    }

    struct MyNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    entry fun createimg(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"imagem_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        let v4 = 0x2::display::new_with_fields<MyNft>(arg0, v0, v2, arg1);
        0x2::display::update_version<MyNft>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<MyNft>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: MY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MY_NFT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNft{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x1::string::utf8(arg2),
        };
        0x2::transfer::public_transfer<MyNft>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

