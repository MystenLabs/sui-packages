module 0x5ef862f2c7f6433afdd7c265c735073d3f4c66bdbd9b3e797f6304478a0a7999::scallop_incentive_pass_w {
    struct SCALLOP_INCENTIVE_PASS_W has drop {
        dummy_field: bool,
    }

    struct SCALLOP_INCENTIVE_PASS has store, key {
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
            let v0 = SCALLOP_INCENTIVE_PASS{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Scallop Incentive Pass"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/scallopfi/scallop_item.jpg"),
                description : 0x1::string::utf8(b"Scallop Incentive Reward of $5000 SCA is ready for you. Claim your reward at https://scallopfi.com"),
                Reward      : 0x1::string::utf8(b"5696.3 SCA"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<SCALLOP_INCENTIVE_PASS>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Scallop Incentive Pass"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/scallopfi/scallop_item.jpg"),
                description : 0x1::string::utf8(b"Scallop Incentive Reward of $5000 SCA is ready for you. Claim your reward at https://scallopfi.com"),
                Reward      : 0x1::string::utf8(b"5696.3 SCA"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<SCALLOP_INCENTIVE_PASS>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: SCALLOP_INCENTIVE_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let SCALLOP_INCENTIVE_PASS {
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

    fun init(arg0: SCALLOP_INCENTIVE_PASS_W, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Scallop Incentive Pass"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/scallopfi/scallop_item.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Scallop Incentive Reward of $5000 SCA is ready for you. Claim your reward at https://scallopfi.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://scallopfi.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Scallop Labs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5696.3 SCA"));
        let v4 = 0x2::package::claim<SCALLOP_INCENTIVE_PASS_W>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SCALLOP_INCENTIVE_PASS>(&v4, v0, v2, arg1);
        0x2::display::update_version<SCALLOP_INCENTIVE_PASS>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SCALLOP_INCENTIVE_PASS>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SCALLOP_INCENTIVE_PASS{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Scallop Incentive Pass"),
            image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/scallopfi/scallop_item.jpg"),
            description : 0x1::string::utf8(b"Scallop Incentive Reward of $5000 SCA is ready for you. Claim your reward at https://scallopfi.com"),
            Reward      : 0x1::string::utf8(b"5696.3 SCA"),
        };
        let v1 = MintEvent{
            nft_id      : 0x2::object::id<SCALLOP_INCENTIVE_PASS>(&v0),
            user        : 0x2::tx_context::sender(arg0),
            name        : 0x1::string::utf8(b"Scallop Incentive Pass"),
            image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/scallopfi/scallop_item.jpg"),
            description : 0x1::string::utf8(b"Scallop Incentive Reward of $5000 SCA is ready for you. Claim your reward at https://scallopfi.com"),
            Reward      : 0x1::string::utf8(b"5696.3 SCA"),
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<SCALLOP_INCENTIVE_PASS>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

