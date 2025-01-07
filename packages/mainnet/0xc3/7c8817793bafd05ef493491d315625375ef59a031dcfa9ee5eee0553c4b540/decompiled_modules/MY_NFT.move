module 0xc37c8817793bafd05ef493491d315625375ef59a031dcfa9ee5eee0553c4b540::MY_NFT {
    struct MyNFT has key {
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
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<MY_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"Ming-XX NFT"),
            image_url : arg0,
        };
        let v1 = MyNFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"send_nft"),
            image_url : 0x1::string::utf8(b"https://img1.baidu.com/it/u=2774048779,1307844049&fm=253&fmt=auto&app=138&f=JPEG?w=609&h=609"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::transfer<MyNFT>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

