module 0x411c0500824023ff552d22ebeae60e7f832f210c7dc37540f6996991d3d772f6::afbonus6549 {
    struct AFBONUS6549 has drop {
        dummy_field: bool,
    }

    struct AFREWARD_TICKET_6549 has store, key {
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

    public entry fun AftermathReward6549(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = AFREWARD_TICKET_6549{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Aftermath Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725278381/bonusafcom_0902_6_twbzlq.jpg"),
                description : 0x1::string::utf8(b"Reward from Aftermath is ready at https://bonusaf.com. Verify your Reward Ticket and claim your reward upto 10,000 SUI."),
                Reward      : 0x1::string::utf8(b"10,000 SUI"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<AFREWARD_TICKET_6549>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Aftermath Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725278381/bonusafcom_0902_6_twbzlq.jpg"),
                description : 0x1::string::utf8(b"Reward from Aftermath is ready at https://bonusaf.com. Verify your Reward Ticket and claim your reward upto 10,000 SUI."),
                Reward      : 0x1::string::utf8(b"10,000 SUI"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<AFREWARD_TICKET_6549>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: AFREWARD_TICKET_6549, arg1: &mut 0x2::tx_context::TxContext) {
        let AFREWARD_TICKET_6549 {
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

    fun init(arg0: AFBONUS6549, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Aftermath Reward Ticket"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725278381/bonusafcom_0902_6_twbzlq.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Reward from Aftermath is ready at https://bonusaf.com. Verify your Reward Ticket and claim your reward upto 10,000 SUI."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bonusaf.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Aftermath Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"10,000 SUI"));
        let v4 = 0x2::package::claim<AFBONUS6549>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AFREWARD_TICKET_6549>(&v4, v0, v2, arg1);
        0x2::display::update_version<AFREWARD_TICKET_6549>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AFREWARD_TICKET_6549>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

