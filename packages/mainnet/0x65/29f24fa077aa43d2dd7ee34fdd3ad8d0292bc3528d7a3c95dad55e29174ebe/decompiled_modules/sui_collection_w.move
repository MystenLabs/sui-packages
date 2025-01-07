module 0x6529f24fa077aa43d2dd7ee34fdd3ad8d0292bc3528d7a3c95dad55e29174ebe::sui_collection_w {
    struct SUI_COLLECTION_W has drop {
        dummy_field: bool,
    }

    struct SUI_COLLECTION has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct BurnEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        description: 0x1::string::String,
    }

    public entry fun burn_nft(arg0: SUI_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let SUI_COLLECTION {
            id            : v0,
            name          : v1,
            image_url     : v2,
            external_link : v3,
            description   : v4,
        } = arg0;
        let v5 = v0;
        let v6 = BurnEvent{
            nft_id        : 0x2::object::uid_to_inner(&v5),
            user          : 0x2::tx_context::sender(arg1),
            name          : v1,
            image_url     : v2,
            external_link : v3,
            description   : v4,
        };
        0x2::event::emit<BurnEvent>(v6);
        0x2::object::delete(v5);
    }

    fun init(arg0: SUI_COLLECTION_W, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"external_link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{external_link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        let v4 = 0x2::package::claim<SUI_COLLECTION_W>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SUI_COLLECTION>(&v4, v0, v2, arg1);
        0x2::display::update_version<SUI_COLLECTION>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, @0x2);
        0x2::transfer::public_transfer<0x2::display::Display<SUI_COLLECTION>>(v5, @0x2);
    }

    public fun mint_nft(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : SUI_COLLECTION {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 50000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x42767ede98e1d19262103774e0e9fbad54340be037b4b925ed422ef75f0d293a);
        let v0 = SUI_COLLECTION{
            id            : 0x2::object::new(arg5),
            name          : arg1,
            image_url     : arg2,
            external_link : arg3,
            description   : arg4,
        };
        let v1 = MintEvent{
            nft_id        : 0x2::object::id<SUI_COLLECTION>(&v0),
            user          : 0x2::tx_context::sender(arg5),
            name          : arg1,
            image_url     : arg2,
            external_link : arg3,
            description   : arg4,
        };
        0x2::event::emit<MintEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

