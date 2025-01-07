module 0x4b2d1aeb53bf93d344ed0d5820fcbcee67b48dee0473a5e9227549a083536ef5::suigpt {
    struct GIFTDROP_SOULBOUND_NFT has key {
        id: 0x2::object::UID,
    }

    struct MintNftEvent has copy, drop {
        id: 0x2::object::ID,
        receiver: address,
        minter: address,
    }

    struct SUIGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"created_at"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"is_soulbound"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiGPT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiGPT Tools"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigpt.tools"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://i.imgur.com/GruTlTg.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftdrop.io/nft"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"1736223900996"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x2::address::to_string(0x2::tx_context::sender(arg1)));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"true"));
        let v4 = 0x2::package::claim<SUIGPT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GIFTDROP_SOULBOUND_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<GIFTDROP_SOULBOUND_NFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<GIFTDROP_SOULBOUND_NFT>>(v5, v6);
        internal_mint_nft(v6, arg1);
    }

    fun internal_mint_nft(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GIFTDROP_SOULBOUND_NFT{id: 0x2::object::new(arg1)};
        let v1 = MintNftEvent{
            id       : 0x2::object::id<GIFTDROP_SOULBOUND_NFT>(&v0),
            receiver : arg0,
            minter   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<MintNftEvent>(v1);
        0x2::transfer::transfer<GIFTDROP_SOULBOUND_NFT>(v0, arg0);
    }

    public fun mint_nft(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(@0x4fb6bb32eb3f5e495430e00233d3f21354088eee6e2b2e0c25c11815f90eea53 == 0x2::tx_context::sender(arg1), 0);
        internal_mint_nft(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

