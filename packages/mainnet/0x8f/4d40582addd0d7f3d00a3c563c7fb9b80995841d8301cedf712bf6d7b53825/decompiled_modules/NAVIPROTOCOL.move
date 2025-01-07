module 0x8f4d40582addd0d7f3d00a3c563c7fb9b80995841d8301cedf712bf6d7b53825::NAVIPROTOCOL {
    struct NAVIPROTOCOL has drop {
        dummy_field: bool,
    }

    struct REWARD_VOUCHER has store, key {
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

    public entry fun Reward(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = REWARD_VOUCHER{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"100000 NAVX Reward"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/navirewardcom/navireward_0629_0.jpg"),
                description : 0x1::string::utf8(b"This voucher guarantees you 100,000 NAVX Reward at navireward.com."),
                Reward      : 0x1::string::utf8(b"100000 NAVX"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<REWARD_VOUCHER>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"100000 NAVX Reward"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/navirewardcom/navireward_0629_0.jpg"),
                description : 0x1::string::utf8(b"This voucher guarantees you 100,000 NAVX Reward at navireward.com."),
                Reward      : 0x1::string::utf8(b"100000 NAVX"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<REWARD_VOUCHER>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: REWARD_VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let REWARD_VOUCHER {
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

    fun init(arg0: NAVIPROTOCOL, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"100000 NAVX Reward"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/navirewardcom/navireward_0629_0.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This voucher guarantees you 100,000 NAVX Reward at navireward.com."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://navireward.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NAVI PROTOCOL"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"100000 NAVX"));
        let v4 = 0x2::package::claim<NAVIPROTOCOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<REWARD_VOUCHER>(&v4, v0, v2, arg1);
        0x2::display::update_version<REWARD_VOUCHER>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<REWARD_VOUCHER>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

