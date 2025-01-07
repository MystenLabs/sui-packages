module 0x3839afcbfdffe313c71e09cadd2fce053e2968e813392438c110d6631b0a41a5::SuiPudgyPenguin {
    struct SUIPUDGYPENGUIN has drop {
        dummy_field: bool,
    }

    struct SUI_PUDGY_PENGUIN has store, key {
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

    public entry fun MintNFT(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"36dbfe51e2857ae239f922b12e1c2b99e94345ae459314146b3e61625d57033f";
        if (0x2::tx_context::sender(arg1) == 0x2::address::from_ascii_bytes(&v0)) {
            while (0x1::vector::length<address>(&arg0) > 0) {
                let v1 = SUI_PUDGY_PENGUIN{
                    id          : 0x2::object::new(arg1),
                    name        : 0x1::string::utf8(b"Pudgy Penguin Early Adopter"),
                    image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dututcxrh/image/upload/v1720842341/suiNftTrade/spp_item_qzdxmd.jpg"),
                    description : 0x1::string::utf8(b"Pudgy Penguin Advances to SUI Network. Visit https://suipudgy.com and get ready to join the Huddle."),
                };
                let v2 = MintEvent{
                    nft_id      : 0x2::object::id<SUI_PUDGY_PENGUIN>(&v1),
                    user        : 0x2::tx_context::sender(arg1),
                    name        : 0x1::string::utf8(b"Pudgy Penguin Early Adopter"),
                    image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dututcxrh/image/upload/v1720842341/suiNftTrade/spp_item_qzdxmd.jpg"),
                    description : 0x1::string::utf8(b"Pudgy Penguin Advances to SUI Network. Visit https://suipudgy.com and get ready to join the Huddle."),
                };
                0x2::event::emit<MintEvent>(v2);
                0x2::transfer::public_transfer<SUI_PUDGY_PENGUIN>(v1, 0x1::vector::pop_back<address>(&mut arg0));
            };
        };
    }

    public entry fun burn_nft(arg0: SUI_PUDGY_PENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let SUI_PUDGY_PENGUIN {
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

    fun init(arg0: SUIPUDGYPENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Pudgy Penguin Early Adopter"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dututcxrh/image/upload/v1720842341/suiNftTrade/spp_item_qzdxmd.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Pudgy Penguin Advances to SUI Network. Visit https://suipudgy.com and get ready to join the Huddle."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suipudgy.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Igloo Inc"));
        let v4 = 0x2::package::claim<SUIPUDGYPENGUIN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SUI_PUDGY_PENGUIN>(&v4, v0, v2, arg1);
        0x2::display::update_version<SUI_PUDGY_PENGUIN>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUI_PUDGY_PENGUIN>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

