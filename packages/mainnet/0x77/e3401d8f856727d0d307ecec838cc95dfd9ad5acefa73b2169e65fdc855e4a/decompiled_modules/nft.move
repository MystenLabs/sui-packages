module 0x77e3401d8f856727d0d307ecec838cc95dfd9ad5acefa73b2169e65fdc855e4a::nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        tokenId: u64,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct State has key {
        id: 0x2::object::UID,
        count: u64,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"shepherdTT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/130045049?s=400&u=6200e46930940bcf706cd7577e2302651d08fb24&v=4"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"e78cabe78cabe899ab6e6674"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = State{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::share_object<State>(v6);
    }

    public entry fun mint(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.count = arg0.count + 1;
        let v0 = MyNFT{
            id      : 0x2::object::new(arg1),
            tokenId : arg0.count,
        };
        0x2::transfer::public_transfer<MyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

