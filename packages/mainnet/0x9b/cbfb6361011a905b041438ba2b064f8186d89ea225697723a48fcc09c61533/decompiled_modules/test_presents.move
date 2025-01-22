module 0x9bcbfb6361011a905b041438ba2b064f8186d89ea225697723a48fcc09c61533::test_presents {
    struct GIFTDROP_NFT has store, key {
        id: 0x2::object::UID,
    }

    struct MintNftEvent has copy, drop {
        id: 0x2::object::ID,
        receiver: address,
        minter: address,
    }

    struct TEST_PRESENTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_PRESENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"created_at"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"test Presents"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Tests"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/bafkreif6hq4on2t5yhfyvg3kbgxtk5qp5d7m3nlftsl3iyndqwweurnyxq"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftdrop.io/nft"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"1737572884277"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x2::address::to_string(0x2::tx_context::sender(arg1)));
        let v4 = 0x2::package::claim<TEST_PRESENTS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GIFTDROP_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<GIFTDROP_NFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<GIFTDROP_NFT>>(v5, v6);
        internal_mint_nft(v6, arg1);
    }

    fun internal_mint_nft(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GIFTDROP_NFT{id: 0x2::object::new(arg1)};
        let v1 = MintNftEvent{
            id       : 0x2::object::id<GIFTDROP_NFT>(&v0),
            receiver : arg0,
            minter   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<MintNftEvent>(v1);
        0x2::transfer::public_transfer<GIFTDROP_NFT>(v0, arg0);
    }

    public fun mint_nft(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(@0x4fb6bb32eb3f5e495430e00233d3f21354088eee6e2b2e0c25c11815f90eea53 == 0x2::tx_context::sender(arg1), 0);
        internal_mint_nft(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

