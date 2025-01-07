module 0xca848e93c091f6439839ea3ca4ec2498b8dc82112be2c732368eddbce597c7d4::my_nft {
    struct MyImageNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        creator: address,
    }

    struct MY_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MY_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"my github nft"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/76994469?s=400&u=9641179f93e7b3fefcc20a58d0b724e74dc3b4af&v=4"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<MyImageNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<MyImageNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<MyImageNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MyImageNFT{
            id      : 0x2::object::new(arg2),
            name    : arg0,
            creator : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::public_transfer<MyImageNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

