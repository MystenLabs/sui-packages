module 0x2dd00ef4bcb4889aa0c167362dffd84c8ff79d260c9dc7f481e9593b2a600cde::sui_connect_demo {
    struct GIFTDROP_NFT has store, key {
        id: 0x2::object::UID,
    }

    struct MintNftEvent has copy, drop {
        id: 0x2::object::ID,
        receiver: address,
        minter: address,
    }

    struct SUI_CONNECT_DEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_CONNECT_DEMO, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Connect Demo"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://lu.ma/suiconnecthongkong"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"data:image/png;base64,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"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftdrop.io/nft"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"1739908588084"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x2::address::to_string(0x2::tx_context::sender(arg1)));
        let v4 = 0x2::package::claim<SUI_CONNECT_DEMO>(arg0, arg1);
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

