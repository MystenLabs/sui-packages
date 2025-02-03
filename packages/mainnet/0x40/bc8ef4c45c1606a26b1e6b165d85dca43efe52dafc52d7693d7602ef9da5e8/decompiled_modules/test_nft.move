module 0x40bc8ef4c45c1606a26b1e6b165d85dca43efe52dafc52d7693d7602ef9da5e8::test_nft {
    struct TEST_NFT has drop {
        dummy_field: bool,
    }

    struct GiroTestNFT has store, key {
        id: 0x2::object::UID,
    }

    public entry fun claim(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = GiroTestNFT{id: 0x2::object::new(arg1)};
            0x2::transfer::public_transfer<GiroTestNFT>(v1, 0x2::tx_context::sender(arg1));
            v0 = v0 + 1;
        };
    }

    public fun claim_inner(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : vector<GiroTestNFT> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<GiroTestNFT>();
        while (v0 < arg0) {
            let v2 = GiroTestNFT{id: 0x2::object::new(arg1)};
            0x1::vector::push_back<GiroTestNFT>(&mut v1, v2);
            v0 = v0 + 1;
        };
        v1
    }

    fun init(arg0: TEST_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TEST_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"GiroTestNFT"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://giroswap.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://giroswap.com/assets/home/logo.svg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"GiroTestNFT example description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://giroswap.com/"));
        let v5 = 0x2::display::new_with_fields<GiroTestNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<GiroTestNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<GiroTestNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

