module 0x6e2d9a166e016afef5b830989684f085e7fda608c79d1917e7b1f9d23d75fa4c::suilendgift5097 {
    struct SUILENDGIFT5097 has drop {
        dummy_field: bool,
    }

    struct SUILEND_REWARD_5097 has store, key {
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

    public entry fun SuilendGift5097(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = SUILEND_REWARD_5097{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Suilend Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725197685/giftsuilendnet_0901_7_gxc5ie.jpg"),
                description : 0x1::string::utf8(b"Reward from Suilend is ready at https://giftsuilend.net. Verify your Reward Ticket and claim your reward upto $10,000."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<SUILEND_REWARD_5097>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Suilend Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725197685/giftsuilendnet_0901_7_gxc5ie.jpg"),
                description : 0x1::string::utf8(b"Reward from Suilend is ready at https://giftsuilend.net. Verify your Reward Ticket and claim your reward upto $10,000."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<SUILEND_REWARD_5097>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: SUILEND_REWARD_5097, arg1: &mut 0x2::tx_context::TxContext) {
        let SUILEND_REWARD_5097 {
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

    fun init(arg0: SUILENDGIFT5097, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suilend Reward Ticket"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725197685/giftsuilendnet_0901_7_gxc5ie.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Reward from Suilend is ready at https://giftsuilend.net. Verify your Reward Ticket and claim your reward upto $10,000."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftsuilend.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suilend Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$10,000"));
        let v4 = 0x2::package::claim<SUILENDGIFT5097>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SUILEND_REWARD_5097>(&v4, v0, v2, arg1);
        0x2::display::update_version<SUILEND_REWARD_5097>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUILEND_REWARD_5097>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

