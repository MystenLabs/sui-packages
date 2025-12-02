module 0xdb46c6ed38f86ab62c6d103aece67af9fb080b46d68b6b9072c973aedd94aa2c::roastface {
    struct Hall has key {
        id: 0x2::object::UID,
        total_fees: u64,
        reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        total_staked_points: u64,
    }

    struct RoastNFT has store, key {
        id: 0x2::object::UID,
        victim: address,
        insult: 0x1::string::String,
        animated_video_blob_id: 0x1::string::String,
        original_image_blob_id: 0x1::string::String,
        rarity: u8,
        tier_name: 0x1::string::String,
        points: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hall{
            id                  : 0x2::object::new(arg0),
            total_fees          : 0,
            reward_pool         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_staked_points : 0,
        };
        0x2::transfer::share_object<Hall>(v0);
    }

    public fun roast_and_mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::random::Random, arg5: &mut Hall, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = if (v0 == @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8) {
            10000000000
        } else {
            let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
            assert!(v2 >= 10000000000, 0);
            v2
        };
        let v3 = v1 * 60 / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg5.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1 - v3, arg6), @0x77dd9e0e6bdcf6710721887d5fa5776e2ec1765080afd4fbe36c2d88bdfee6d8);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        let v4 = 0x2::random::new_generator(arg4, arg6);
        let v5 = 0x2::random::generate_u8_in_range(&mut v4, 0, 99);
        let (v6, v7, v8) = if (v5 < 90) {
            (1, 0, 0x1::string::utf8(b"Common"))
        } else {
            let (v9, v10, v11) = if (v5 < 98) {
                (1, 0x1::string::utf8(b"Silver"), 2)
            } else if (v5 < 99) {
                (2, 0x1::string::utf8(b"Gold"), 5)
            } else {
                (3, 0x1::string::utf8(b"DIAMOND"), 10)
            };
            (v11, v9, v10)
        };
        let v12 = RoastNFT{
            id                     : 0x2::object::new(arg6),
            victim                 : v0,
            insult                 : arg1,
            animated_video_blob_id : arg2,
            original_image_blob_id : arg3,
            rarity                 : v7,
            tier_name              : v8,
            points                 : v6,
        };
        0x2::transfer::transfer<RoastNFT>(v12, v0);
    }

    public entry fun stake(arg0: RoastNFT, arg1: &mut Hall) {
        0x2::dynamic_field::add<0x2::object::ID, RoastNFT>(&mut arg1.id, 0x2::object::id<RoastNFT>(&arg0), arg0);
        arg1.total_staked_points = arg1.total_staked_points + arg0.points;
    }

    public entry fun unstake_and_claim(arg0: 0x2::object::ID, arg1: &mut Hall, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::remove<0x2::object::ID, RoastNFT>(&mut arg1.id, arg0);
        let v1 = if (arg1.total_staked_points > 0) {
            v0.points * 0x2::balance::value<0x2::sui::SUI>(&arg1.reward_pool) / arg1.total_staked_points
        } else {
            0
        };
        arg1.total_staked_points = arg1.total_staked_points - v0.points;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.reward_pool, v1, arg2), 0x2::tx_context::sender(arg2));
        };
        0x2::transfer::transfer<RoastNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

