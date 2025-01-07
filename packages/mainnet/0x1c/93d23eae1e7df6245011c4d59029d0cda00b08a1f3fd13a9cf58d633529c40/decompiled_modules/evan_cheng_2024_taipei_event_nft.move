module 0x1c93d23eae1e7df6245011c4d59029d0cda00b08a1f3fd13a9cf58d633529c40::evan_cheng_2024_taipei_event_nft {
    struct GIFTDROP_SOULBOUND_NFT has key {
        id: 0x2::object::UID,
        created_at: u64,
    }

    struct MintNftEvent has copy, drop {
        id: 0x2::object::ID,
        receiver: address,
        minter: address,
    }

    struct EVAN_CHENG_2024_TAIPEI_EVENT_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN_CHENG_2024_TAIPEI_EVENT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"is_soulbound"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Evan Cheng 2024 Taipei Event NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"436f6d6d656d6f726174697665204e465420666f72204d797374656e204c61627320436f2d666f756e646572204576616e204368656e672773204576656e7420696e205461697065692e20e88081e984ade795b6e5aeb62332e28094e280944d797374656e204c616273e589b5e8bea6e4baba4576616e204368656e67e59ca8e58fb0e58c97e6b4bbe58b95e7b480e5bfb5204e4654"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://lu.ma/agrbx3xi"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://i.imgur.com/BveLn3N.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftdrop.io/nft"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x2::address::to_string(0x2::tx_context::sender(arg1)));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"true"));
        let v4 = 0x2::package::claim<EVAN_CHENG_2024_TAIPEI_EVENT_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GIFTDROP_SOULBOUND_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<GIFTDROP_SOULBOUND_NFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<GIFTDROP_SOULBOUND_NFT>>(v5, v6);
    }

    public fun mint_nft(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x4fb6bb32eb3f5e495430e00233d3f21354088eee6e2b2e0c25c11815f90eea53 == 0x2::tx_context::sender(arg2), 0);
        let v0 = GIFTDROP_SOULBOUND_NFT{
            id         : 0x2::object::new(arg2),
            created_at : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = MintNftEvent{
            id       : 0x2::object::id<GIFTDROP_SOULBOUND_NFT>(&v0),
            receiver : arg0,
            minter   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MintNftEvent>(v1);
        0x2::transfer::transfer<GIFTDROP_SOULBOUND_NFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

