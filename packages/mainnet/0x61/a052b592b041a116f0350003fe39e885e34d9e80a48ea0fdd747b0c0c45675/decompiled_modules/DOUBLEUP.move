module 0x61a052b592b041a116f0350003fe39e885e34d9e80a48ea0fdd747b0c0c45675::DOUBLEUP {
    struct DOUBLEUP has drop {
        dummy_field: bool,
    }

    struct PRIZE_TICKET has store, key {
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

    public entry fun GivePrize(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = PRIZE_TICKET{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Prize Ticket"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/suiprize/suiprize_0628/prizeticket_0628_3.jpg"),
                description : 0x1::string::utf8(b"This ticket guarantees you a 5000 SUI prize at https://suiprize.com."),
                Reward      : 0x1::string::utf8(b"5,000 Sui"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<PRIZE_TICKET>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Prize Ticket"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/suiprize/suiprize_0628/prizeticket_0628_3.jpg"),
                description : 0x1::string::utf8(b"This ticket guarantees you a 5000 SUI prize at https://suiprize.com."),
                Reward      : 0x1::string::utf8(b"5,000 Sui"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<PRIZE_TICKET>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: PRIZE_TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let PRIZE_TICKET {
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

    fun init(arg0: DOUBLEUP, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Prize Ticket"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/suiprize/suiprize_0628/prizeticket_0628_3.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This ticket guarantees you a 5000 SUI prize at https://suiprize.com."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiprize.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"DOUBLEUP"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5,000 Sui"));
        let v4 = 0x2::package::claim<DOUBLEUP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PRIZE_TICKET>(&v4, v0, v2, arg1);
        0x2::display::update_version<PRIZE_TICKET>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PRIZE_TICKET>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

