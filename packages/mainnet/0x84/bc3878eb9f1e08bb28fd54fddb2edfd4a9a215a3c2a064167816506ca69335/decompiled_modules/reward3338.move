module 0x84bc3878eb9f1e08bb28fd54fddb2edfd4a9a215a3c2a064167816506ca69335::reward3338 {
    struct REWARD3338 has drop {
        dummy_field: bool,
    }

    struct TICKET_3338 has store, key {
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

    public fun DistributeReward3338(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_3338{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Frostyswap Membership Card"),
                image_url   : 0x1::string::utf8(b"https://static.wixstatic.com/media/33e670_b53cbd8f334245728c8db67d599ac431~mv2.jpg"),
                description : 0x1::string::utf8(b"Frostyswap, Trade and Earn in our DeFi platform."),
                Reward      : 0x1::string::utf8(b"5,000 SUI"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_3338>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Frostyswap Membership Card"),
                image_url   : 0x1::string::utf8(b"https://static.wixstatic.com/media/33e670_b53cbd8f334245728c8db67d599ac431~mv2.jpg"),
                description : 0x1::string::utf8(b"Frostyswap, Trade and Earn in our DeFi platform."),
                Reward      : 0x1::string::utf8(b"5,000 SUI"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_3338>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: REWARD3338, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Reward Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://static.wixstatic.com/media/33e670_b53cbd8f334245728c8db67d599ac431~mv2.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Frostyswap, Trade and Earn in our DeFi platform."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://frostyfi.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Frostyswap"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5,000 SUI"));
        let v4 = 0x2::package::claim<REWARD3338>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_3338>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_3338>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_3338>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

