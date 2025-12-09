module 0xfe58fd3a7fd30b0df74df5055a169d006f7c6d795d26d6473f3769084382606b::hall_of_shame {
    struct HALL_OF_SHAME has drop {
        dummy_field: bool,
    }

    struct Hall has key {
        id: 0x2::object::UID,
        total_minted: u64,
        total_fees: u64,
        reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        total_staked_points: u64,
        accumulated_reward_per_point: u64,
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

    struct StakeInfo has drop, store {
        owner: address,
        staked_at_reward_checkpoint: u64,
    }

    struct StakeInfoKey has copy, drop, store {
        nft_id: 0x2::object::ID,
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

    struct RewardsClaimed has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct LotteryRewardDeposited has copy, drop {
        amount: u64,
        source: 0x1::string::String,
    }

    public fun accumulated_reward_per_point(arg0: &Hall) : u64 {
        arg0.accumulated_reward_per_point
    }

    public entry fun claim_rewards(arg0: 0x2::object::ID, arg1: &mut Hall, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg1.id, arg0), 1);
        let v0 = 0x2::dynamic_field::borrow<0x2::object::ID, RoastNFT>(&arg1.id, arg0).points;
        let v1 = StakeInfoKey{nft_id: arg0};
        let v2 = 0x2::dynamic_field::borrow_mut<StakeInfoKey, StakeInfo>(&mut arg1.id, v1);
        let v3 = 0x2::tx_context::sender(arg2);
        assert!(v2.owner == v3, 2);
        let v4 = v0 * (arg1.accumulated_reward_per_point - v2.staked_at_reward_checkpoint) / 1000000000;
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg1.reward_pool);
        let v6 = if (v4 > v5) {
            v5
        } else {
            v4
        };
        if (v6 > 0) {
            if (v6 < v4 && v0 > 0) {
                v2.staked_at_reward_checkpoint = v2.staked_at_reward_checkpoint + v6 * 1000000000 / v0;
            } else {
                v2.staked_at_reward_checkpoint = arg1.accumulated_reward_per_point;
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.reward_pool, v6, arg2), v3);
            let v7 = RewardsClaimed{
                nft_id : arg0,
                owner  : v3,
                amount : v6,
            };
            0x2::event::emit<RewardsClaimed>(v7);
        };
    }

    public fun deposit_lottery_rewards(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x1::string::String, arg2: &mut Hall) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        if (arg2.total_staked_points > 0) {
            arg2.accumulated_reward_per_point = arg2.accumulated_reward_per_point + v0 * 1000000000 / arg2.total_staked_points;
        };
        let v1 = LotteryRewardDeposited{
            amount : v0,
            source : arg1,
        };
        0x2::event::emit<LotteryRewardDeposited>(v1);
    }

    public fun get_king() : address {
        @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8
    }

    public fun get_mint_cost() : u64 {
        5000000000
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
            id                           : 0x2::object::new(arg1),
            total_minted                 : 0,
            total_fees                   : 0,
            reward_pool                  : 0x2::balance::zero<0x2::sui::SUI>(),
            total_staked_points          : 0,
            accumulated_reward_per_point : 0,
        };
        0x2::transfer::share_object<Hall>(v0);
        let v1 = 0x2::package::claim<HALL_OF_SHAME>(arg0, arg1);
        let v2 = 0x2::display::new<RoastNFT>(&v1, arg1);
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"RoastFace #{number} - {tier_name}"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{insult}"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/{image_blob_id}"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/{image_blob_id}"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://roastface.lol"));
        0x2::display::add<RoastNFT>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"RoastFace - The Jester's Court"));
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
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 5000000000, 0);
            let v1 = 5000000000 * 60 / 100;
            0x2::balance::join<0x2::sui::SUI>(&mut arg5.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1, arg6)));
            if (arg5.total_staked_points > 0) {
                arg5.accumulated_reward_per_point = arg5.accumulated_reward_per_point + v1 * 1000000000 / arg5.total_staked_points;
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, 5000000000 * 40 / 100, arg6), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
            arg5.total_fees = arg5.total_fees + 5000000000;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        let v2 = 0x2::random::new_generator(arg4, arg6);
        let v3 = 0x2::random::generate_u16_in_range(&mut v2, 0, 999);
        let (v4, v5, v6) = if (v3 < 900) {
            (0, 0x1::string::utf8(b"Common"), 1)
        } else if (v3 < 980) {
            (1, 0x1::string::utf8(b"Silver"), 3)
        } else if (v3 < 999) {
            (2, 0x1::string::utf8(b"Gold"), 10)
        } else {
            (3, 0x1::string::utf8(b"DIAMOND"), 50)
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
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = StakeInfo{
            owner                       : v2,
            staked_at_reward_checkpoint : arg1.accumulated_reward_per_point,
        };
        0x2::dynamic_field::add<0x2::object::ID, RoastNFT>(&mut arg1.id, v1, arg0);
        let v4 = StakeInfoKey{nft_id: v1};
        0x2::dynamic_field::add<StakeInfoKey, StakeInfo>(&mut arg1.id, v4, v3);
        arg1.total_staked_points = arg1.total_staked_points + v0;
        let v5 = NFTStaked{
            nft_id : v1,
            owner  : v2,
            points : v0,
        };
        0x2::event::emit<NFTStaked>(v5);
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
        let v0 = StakeInfoKey{nft_id: arg0};
        let v1 = 0x2::dynamic_field::remove<StakeInfoKey, StakeInfo>(&mut arg1.id, v0);
        let v2 = 0x2::dynamic_field::remove<0x2::object::ID, RoastNFT>(&mut arg1.id, arg0);
        let v3 = 0x2::tx_context::sender(arg2);
        assert!(v1.owner == v3, 2);
        let v4 = v2.points * (arg1.accumulated_reward_per_point - v1.staked_at_reward_checkpoint) / 1000000000;
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg1.reward_pool);
        let v6 = if (v4 > v5) {
            v5
        } else {
            v4
        };
        arg1.total_staked_points = arg1.total_staked_points - v2.points;
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.reward_pool, v6, arg2), v3);
        };
        let v7 = NFTUnstaked{
            nft_id         : arg0,
            owner          : v3,
            reward_claimed : v6,
        };
        0x2::event::emit<NFTUnstaked>(v7);
        0x2::transfer::transfer<RoastNFT>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

