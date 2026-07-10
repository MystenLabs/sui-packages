module 0x38f44d0b79b839b0988ffb11834c0f2b09a84468c1580a5bc9eb0cd09fcd83::staking_pool {
    struct StakeRecord has store, key {
        id: 0x2::object::UID,
        nft: 0x17fb1d31c2468121f97080cb7e9d05552db902056c4379d4860aa11491f343fe::soyara_genesis_pass::SoyaraGenesisPass,
        owner: address,
        staked_timestamp_ms: u64,
        last_claim_timestamp_ms: u64,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        staked_nfts: 0x2::object_table::ObjectTable<0x2::object::ID, StakeRecord>,
        total_staked: u64,
        total_rewards_claimed: u64,
        is_paused: bool,
    }

    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakeEvent has copy, drop {
        staker: address,
        nft_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct UnstakeEvent has copy, drop {
        staker: address,
        nft_id: 0x2::object::ID,
        rewards_claimed: u64,
        timestamp_ms: u64,
    }

    struct ClaimEvent has copy, drop {
        staker: address,
        nft_id: 0x2::object::ID,
        rewards_claimed: u64,
        timestamp_ms: u64,
    }

    public fun batch_claim_rewards(arg0: &mut StakingPool, arg1: &mut 0x38f44d0b79b839b0988ffb11834c0f2b09a84468c1580a5bc9eb0cd09fcd83::diamond_token::DiamondTreasury, arg2: vector<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            claim_rewards(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&arg2, v0), arg3, arg4);
            v0 = v0 + 1;
        };
    }

    public fun batch_stake_nft(arg0: &mut StakingPool, arg1: vector<0x17fb1d31c2468121f97080cb7e9d05552db902056c4379d4860aa11491f343fe::soyara_genesis_pass::SoyaraGenesisPass>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<0x17fb1d31c2468121f97080cb7e9d05552db902056c4379d4860aa11491f343fe::soyara_genesis_pass::SoyaraGenesisPass>(&arg1)) {
            stake_nft(arg0, 0x1::vector::pop_back<0x17fb1d31c2468121f97080cb7e9d05552db902056c4379d4860aa11491f343fe::soyara_genesis_pass::SoyaraGenesisPass>(&mut arg1), arg2, arg3);
        };
        0x1::vector::destroy_empty<0x17fb1d31c2468121f97080cb7e9d05552db902056c4379d4860aa11491f343fe::soyara_genesis_pass::SoyaraGenesisPass>(arg1);
    }

    public fun calculate_pending_rewards(arg0: &StakingPool, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::object_table::contains<0x2::object::ID, StakeRecord>(&arg0.staked_nfts, arg1)) {
            return 0
        };
        let v0 = 0x2::object_table::borrow<0x2::object::ID, StakeRecord>(&arg0.staked_nfts, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 <= v0.last_claim_timestamp_ms) {
            return 0
        };
        ((((v1 - v0.last_claim_timestamp_ms) as u128) * 10000000000 / 86400000) as u64)
    }

    public fun claim_rewards(arg0: &mut StakingPool, arg1: &mut 0x38f44d0b79b839b0988ffb11834c0f2b09a84468c1580a5bc9eb0cd09fcd83::diamond_token::DiamondTreasury, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.is_paused, 2);
        assert!(0x2::object_table::contains<0x2::object::ID, StakeRecord>(&arg0.staked_nfts, arg2), 3);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, StakeRecord>(&mut arg0.staked_nfts, arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v0.owner == v1, 1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        if (v2 <= v0.last_claim_timestamp_ms) {
            return 0
        };
        let v3 = ((((v2 - v0.last_claim_timestamp_ms) as u128) * 10000000000 / 86400000) as u64);
        if (v3 > 0) {
            v0.last_claim_timestamp_ms = v2;
            arg0.total_rewards_claimed = arg0.total_rewards_claimed + v3;
            0x38f44d0b79b839b0988ffb11834c0f2b09a84468c1580a5bc9eb0cd09fcd83::diamond_token::mint_reward(arg1, v3, v1, arg4);
            let v4 = ClaimEvent{
                staker          : v1,
                nft_id          : arg2,
                rewards_claimed : v3,
                timestamp_ms    : v2,
            };
            0x2::event::emit<ClaimEvent>(v4);
        };
        v3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                    : 0x2::object::new(arg0),
            staked_nfts           : 0x2::object_table::new<0x2::object::ID, StakeRecord>(arg0),
            total_staked          : 0,
            total_rewards_claimed : 0,
            is_paused             : false,
        };
        let v1 = PoolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<StakingPool>(v0);
        0x2::transfer::public_transfer<PoolAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun stake_nft(arg0: &mut StakingPool, arg1: 0x17fb1d31c2468121f97080cb7e9d05552db902056c4379d4860aa11491f343fe::soyara_genesis_pass::SoyaraGenesisPass, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::object::id<0x17fb1d31c2468121f97080cb7e9d05552db902056c4379d4860aa11491f343fe::soyara_genesis_pass::SoyaraGenesisPass>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = StakeRecord{
            id                      : 0x2::object::new(arg3),
            nft                     : arg1,
            owner                   : v2,
            staked_timestamp_ms     : v1,
            last_claim_timestamp_ms : v1,
        };
        0x2::object_table::add<0x2::object::ID, StakeRecord>(&mut arg0.staked_nfts, v0, v3);
        arg0.total_staked = arg0.total_staked + 1;
        let v4 = StakeEvent{
            staker       : v2,
            nft_id       : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<StakeEvent>(v4);
        v0
    }

    public fun toggle_pause(arg0: &PoolAdminCap, arg1: &mut StakingPool, arg2: bool) {
        arg1.is_paused = arg2;
    }

    public fun total_rewards_claimed(arg0: &StakingPool) : u64 {
        arg0.total_rewards_claimed
    }

    public fun total_staked(arg0: &StakingPool) : u64 {
        arg0.total_staked
    }

    public fun unstake_nft(arg0: &mut StakingPool, arg1: &mut 0x38f44d0b79b839b0988ffb11834c0f2b09a84468c1580a5bc9eb0cd09fcd83::diamond_token::DiamondTreasury, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x17fb1d31c2468121f97080cb7e9d05552db902056c4379d4860aa11491f343fe::soyara_genesis_pass::SoyaraGenesisPass {
        assert!(0x2::object_table::contains<0x2::object::ID, StakeRecord>(&arg0.staked_nfts, arg2), 3);
        let v0 = claim_rewards(arg0, arg1, arg2, arg3, arg4);
        let StakeRecord {
            id                      : v1,
            nft                     : v2,
            owner                   : v3,
            staked_timestamp_ms     : _,
            last_claim_timestamp_ms : _,
        } = 0x2::object_table::remove<0x2::object::ID, StakeRecord>(&mut arg0.staked_nfts, arg2);
        let v6 = 0x2::tx_context::sender(arg4);
        assert!(v3 == v6, 1);
        0x2::object::delete(v1);
        arg0.total_staked = arg0.total_staked - 1;
        let v7 = UnstakeEvent{
            staker          : v6,
            nft_id          : arg2,
            rewards_claimed : v0,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UnstakeEvent>(v7);
        v2
    }

    // decompiled from Move bytecode v7
}

