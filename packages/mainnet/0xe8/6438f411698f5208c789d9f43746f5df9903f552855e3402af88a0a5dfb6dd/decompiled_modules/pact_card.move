module 0xe86438f411698f5208c789d9f43746f5df9903f552855e3402af88a0a5dfb6dd::pact_card {
    struct PACT_CARD has drop {
        dummy_field: bool,
    }

    struct PactCard has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct PactCardMinted has copy, drop {
        object_id: 0x2::object::ID,
        name: 0x1::string::String,
        trait_count: u64,
    }

    fun init(arg0: PACT_CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PACT_CARD>(arg0, arg1);
        let v1 = 0x2::display::new<PactCard>(&v0, arg1);
        0x2::display::add<PactCard>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<PactCard>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PactCard>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<PactCard>(&mut v1, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<PactCard>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://arweave.net"));
        0x2::display::add<PactCard>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Pactify"));
        0x2::display::update_version<PactCard>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<PactCard>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0xe86438f411698f5208c789d9f43746f5df9903f552855e3402af88a0a5dfb6dd::royalty_rule::add<PactCard>(&mut v5, &v4, 200);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PactCard>>(v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<PactCard>>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<PactCard>>(v1, v6);
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4), 0);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v1)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v1)));
            v1 = v1 + 1;
        };
        let v2 = PactCard{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : v0,
        };
        let v3 = PactCardMinted{
            object_id   : 0x2::object::id<PactCard>(&v2),
            name        : v2.name,
            trait_count : 0x2::vec_map::size<0x1::string::String, 0x1::string::String>(&v2.attributes),
        };
        0x2::event::emit<PactCardMinted>(v3);
        0x2::transfer::public_transfer<PactCard>(v2, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v7
}

