module 0xc05ff2bc765795884b339c92dae47fa04838c8a1f714ff312f58a6237e086667::sui_collection_w {
    struct SUI_COLLECTION_W has drop {
        dummy_field: bool,
    }

    struct SUI_COLLECTION has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct BurnEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    public entry fun burn_nft(arg0: SUI_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let SUI_COLLECTION {
            id          : v0,
            name        : v1,
            image_url   : v2,
            description : v3,
        } = arg0;
        let v4 = v0;
        let v5 = BurnEvent{
            nft_id      : 0x2::object::uid_to_inner(&v4),
            user        : 0x2::tx_context::sender(arg1),
            name        : v1,
            image_url   : v2,
            description : v3,
        };
        0x2::event::emit<BurnEvent>(v5);
        0x2::object::delete(v4);
    }

    fun init(arg0: SUI_COLLECTION_W, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://testdomain.xyz"));
        let v4 = 0x2::package::claim<SUI_COLLECTION_W>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SUI_COLLECTION>(&v4, v0, v2, arg1);
        0x2::display::update_version<SUI_COLLECTION>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUI_COLLECTION>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SUI_COLLECTION{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            image_url   : arg1,
            description : arg3,
        };
        let v1 = MintEvent{
            nft_id      : 0x2::object::id<SUI_COLLECTION>(&v0),
            user        : 0x2::tx_context::sender(arg4),
            name        : arg0,
            image_url   : arg1,
            description : arg3,
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<SUI_COLLECTION>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

