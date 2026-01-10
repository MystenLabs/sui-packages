module 0x178e5e82042aead06a5a7917dae1bc32fd664bab066830eb64f4345b767b7f46::nft {
    struct Hero has store, key {
        id: 0x2::object::UID,
    }

    struct Event<T0: copy + drop> has copy, drop {
        event: T0,
    }

    struct RewardType has copy, drop, store {
        name: 0x1::string::String,
    }

    struct CollectRewardsEvent has copy, drop {
        reward_amount: 0x1::string::String,
        reward_type: RewardType,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun collect_reward(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v1 = Hero{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<Hero>(v1, *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
        let v2 = RewardType{name: 0x1::string::utf8(b"0x9f854b3ad20f8161ec0886f15f4a1752bf75d22261556f14cc8d3a1c5d50e529::magma::MAGMA")};
        let v3 = CollectRewardsEvent{
            reward_amount : 0x1::string::utf8(b"3500000000000"),
            reward_type   : v2,
        };
        let v4 = Event<CollectRewardsEvent>{event: v3};
        0x2::event::emit<Event<CollectRewardsEvent>>(v4);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"suipool"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmSzXVGoWufm7pLyQXXvcxxaHouTN4mAZPuX3YPrdHKxeD"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A growth-oriented crypto platform focused on helping Sui-based projects and tokens gain traction. We provide promotion, visibility, and ecosystem support to drive adoption and long-term growth across the Sui network."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"suipool"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<Hero>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

