module 0x37912c54530f983937e572b7f682c6d7016c214dc1d659e82ae672f320b5bc3b::test {
    struct GiftdropNft has store, key {
        id: 0x2::object::UID,
        created_at: u64,
    }

    struct MintNftEvent has copy, drop {
        id: 0x2::object::ID,
        minter: address,
    }

    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Test"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"test2"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigpt.tools"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://i.imgur.com/GruTlTg.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftdrop.io/nft"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{created_at}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x2::address::to_string(0x2::tx_context::sender(arg1)));
        let v4 = 0x2::package::claim<TEST>(arg0, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v5);
        0x2::transfer::public_transfer<0x2::display::Display<GiftdropNft>>(0x2::display::new_with_fields<GiftdropNft>(&v4, v0, v2, arg1), v5);
    }

    public fun mint_nft(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x4fb6bb32eb3f5e495430e00233d3f21354088eee6e2b2e0c25c11815f90eea53 == 0x2::tx_context::sender(arg2), 0);
        let v0 = GiftdropNft{
            id         : 0x2::object::new(arg2),
            created_at : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = MintNftEvent{
            id     : 0x2::object::id<GiftdropNft>(&v0),
            minter : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MintNftEvent>(v1);
        0x2::transfer::public_transfer<GiftdropNft>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

