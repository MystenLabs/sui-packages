module 0xb22bf4e97936ef2d1243268143d6593fa5a27805d0e69cf29c4dde3eb6a71af1::hall_of_shame {
    struct HALL_OF_SHAME has drop {
        dummy_field: bool,
    }

    struct Hall has key {
        id: 0x2::object::UID,
        total_minted: u64,
        total_fees: u64,
        reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        total_staked_points: u64,
    }

    struct RoastNFT has store, key {
        id: 0x2::object::UID,
        number: u64,
        victim: address,
        insult: 0x1::string::String,
        image_blob_id: 0x1::string::String,
        original_image_blob_id: 0x1::string::String,
        rarity: u8,
        tier_name: 0x1::string::String,
        points: u64,
    }

    struct RoastMinted has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        victim: address,
        rarity: u8,
        tier_name: 0x1::string::String,
        insult: 0x1::string::String,
        image_blob_id: 0x1::string::String,
    }

    struct NFTStaked has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        points: u64,
    }

    struct NFTUnstaked has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        reward_claimed: u64,
    }

    public fun get_number(arg0: &RoastNFT) : u64 {
        arg0.number
    }

    public fun get_points(arg0: &RoastNFT) : u64 {
        arg0.points
    }

    public fun get_rarity(arg0: &RoastNFT) : u8 {
        arg0.rarity
    }

    fun init(arg0: HALL_OF_SHAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Hall{
            id                  : 0x2::object::new(arg1),
            total_minted        : 0,
            total_fees          : 0,
            reward_pool         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_staked_points : 0,
        };
        0x2::transfer::share_object<Hall>(v0);
        let v1 = 0x2::package::claim<HALL_OF_SHAME>(arg0, arg1);
        let v2 = 0x2::display::new<RoastNFT>(&v1, arg1);
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"RoastFace #{number} - {tier_name}"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Brutal roast: {insult}"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://walrus.site/{image_blob_id}"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"https://walrus.site/{image_blob_id}"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://roastface.sui"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"RoastFace"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{tier_name}"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"points"), 0x1::string::utf8(b"{points}"));
        0x2::display::update_version<RoastNFT>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RoastNFT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun is_diamond(arg0: &RoastNFT) : bool {
        arg0.rarity == 3
    }

    public fun reward_pool_balance(arg0: &Hall) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool)
    }

    public fun roast_and_mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::random::Random, arg5: &mut Hall, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        if (v0 != @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 10000000000, 0);
            let v1 = 10000000000 * 60 / 100;
            0x2::balance::join<0x2::sui::SUI>(&mut arg5.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1, arg6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, 10000000000 - v1, arg6), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
            arg5.total_fees = arg5.total_fees + 10000000000;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        let v2 = 0x2::random::new_generator(arg4, arg6);
        let v3 = 0x2::random::generate_u8_in_range(&mut v2, 0, 99);
        let (v4, v5, v6) = if (v3 < 90) {
            (0, 0x1::string::utf8(b"Common"), 1)
        } else if (v3 < 98) {
            (1, 0x1::string::utf8(b"Silver"), 2)
        } else if (v3 < 99) {
            (2, 0x1::string::utf8(b"Gold"), 5)
        } else {
            (3, 0x1::string::utf8(b"DIAMOND"), 10)
        };
        arg5.total_minted = arg5.total_minted + 1;
        let v7 = arg5.total_minted;
        let v8 = RoastNFT{
            id                     : 0x2::object::new(arg6),
            number                 : v7,
            victim                 : v0,
            insult                 : arg1,
            image_blob_id          : arg2,
            original_image_blob_id : arg3,
            rarity                 : v4,
            tier_name              : v5,
            points                 : v6,
        };
        let v9 = RoastMinted{
            nft_id        : 0x2::object::id<RoastNFT>(&v8),
            number        : v7,
            victim        : v0,
            rarity        : v4,
            tier_name     : v8.tier_name,
            insult        : v8.insult,
            image_blob_id : v8.image_blob_id,
        };
        0x2::event::emit<RoastMinted>(v9);
        0x2::transfer::transfer<RoastNFT>(v8, v0);
    }

    public entry fun stake(arg0: RoastNFT, arg1: &mut Hall, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.points;
        let v1 = 0x2::object::id<RoastNFT>(&arg0);
        0x2::dynamic_field::add<0x2::object::ID, RoastNFT>(&mut arg1.id, v1, arg0);
        arg1.total_staked_points = arg1.total_staked_points + v0;
        let v2 = NFTStaked{
            nft_id : v1,
            owner  : 0x2::tx_context::sender(arg2),
            points : v0,
        };
        0x2::event::emit<NFTStaked>(v2);
    }

    public fun total_fees(arg0: &Hall) : u64 {
        arg0.total_fees
    }

    public fun total_minted(arg0: &Hall) : u64 {
        arg0.total_minted
    }

    public fun total_staked_points(arg0: &Hall) : u64 {
        arg0.total_staked_points
    }

    public entry fun unstake_and_claim(arg0: 0x2::object::ID, arg1: &mut Hall, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg1.id, arg0), 1);
        let v0 = 0x2::dynamic_field::remove<0x2::object::ID, RoastNFT>(&mut arg1.id, arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = if (arg1.total_staked_points > 0) {
            v0.points * 0x2::balance::value<0x2::sui::SUI>(&arg1.reward_pool) / arg1.total_staked_points
        } else {
            0
        };
        arg1.total_staked_points = arg1.total_staked_points - v0.points;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.reward_pool, v2, arg2), v1);
        };
        let v3 = NFTUnstaked{
            nft_id         : arg0,
            owner          : v1,
            reward_claimed : v2,
        };
        0x2::event::emit<NFTUnstaked>(v3);
        0x2::transfer::transfer<RoastNFT>(v0, v1);
    }

    // decompiled from Move bytecode v6
}

