module 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::burn {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct UserStats has copy, drop, store {
        sui_burned: u128,
        coins_burned: u64,
        nfts_burned: u64,
        burn_count: u64,
        contribution_points: u128,
        total_rewards_claimed: u128,
        last_burn_timestamp: u64,
        last_claim_timestamp: u64,
        reward_debt: u256,
        pending_rewards: u64,
    }

    struct BurnService has key {
        id: 0x2::object::UID,
        fee_amount: u64,
        owner_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        staking_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        total_burned_sui: u128,
        total_burned_coins: u64,
        total_burned_nfts: u64,
        burn_count: u64,
        total_contribution_points: u128,
        user_stats: 0x2::table::Table<address, UserStats>,
        staking_pool_total_contributed: u128,
        staking_pool_total_claimed: u128,
        vault_creation_fee: u64,
        acc_rewards_per_point: u256,
        burned_sui_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        garbage_collector: 0x2::bag::Bag,
        ash_treasury: 0x1::option::Option<0x2::coin::TreasuryCap<0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::ash::ASH>>,
        ash_multiplier: u64,
    }

    struct BurnEvent has copy, drop {
        burner: address,
        amount_burned: u64,
        points_earned: u128,
        fee_paid: u64,
        timestamp_ms: u64,
    }

    struct ClaimEvent has copy, drop {
        claimer: address,
        reward_amount: u64,
        points_spent: u128,
        timestamp_ms: u64,
    }

    struct EarlyClaimPenaltyEvent has copy, drop {
        timestamp_ms: u64,
    }

    struct StakersClaimEvent has copy, drop {
        claimer: address,
        reward_amount: u64,
        user_points: u128,
    }

    struct FeeUpdateEvent has copy, drop {
        old_fee: u64,
        new_fee: u64,
        timestamp_ms: u64,
    }

    struct AssetBurnEvent has copy, drop {
        burner: address,
        asset_type: vector<u8>,
        amount_or_count: u64,
        points_earned: u128,
        fee_paid: u64,
        timestamp_ms: u64,
    }

    public fun burn_coin<T0>(arg0: &mut BurnService, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _) = burn_coin_internal<T0>(arg0, arg1, arg2, 0x1::option::none<address>(), arg3);
    }

    fun burn_coin_internal<T0>(arg0: &mut BurnService, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.fee_amount, 0);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = calculate_deflationary_points(arg0.burn_count, arg0.fee_amount);
        assert!(arg0.total_contribution_points <= 330000000000000000000000000000000000000 - v2, 5);
        let v3 = arg0.fee_amount * 10 / 100;
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.owner_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v3));
        let v5 = if (0x1::option::is_some<address>(&arg3)) {
            let v6 = arg0.fee_amount * 10 / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, v6), arg4), 0x1::option::destroy_some<address>(arg3));
            arg0.fee_amount - v3 - v6
        } else {
            arg0.fee_amount - v3
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.staking_pool, v4);
        update_pool(arg0, v5);
        arg0.staking_pool_total_contributed = arg0.staking_pool_total_contributed + (v5 as u128);
        let v7 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.garbage_collector, v7)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.garbage_collector, v7, 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.garbage_collector, v7), 0x2::coin::into_balance<T0>(arg1));
        };
        arg0.total_burned_coins = arg0.total_burned_coins + 1;
        arg0.burn_count = arg0.burn_count + 1;
        arg0.total_contribution_points = arg0.total_contribution_points + v2;
        let v8 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        mint_ash(arg0, v2, arg4);
        if (0x2::table::contains<address, UserStats>(&arg0.user_stats, v0)) {
            let v9 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.user_stats, v0);
            v9.pending_rewards = v9.pending_rewards + (((v9.contribution_points as u256) * arg0.acc_rewards_per_point / 1000000000000000000000 - v9.reward_debt) as u64);
            v9.coins_burned = v9.coins_burned + 1;
            v9.burn_count = v9.burn_count + 1;
            v9.contribution_points = v9.contribution_points + v2;
            v9.last_burn_timestamp = v8;
            v9.reward_debt = (v9.contribution_points as u256) * arg0.acc_rewards_per_point / 1000000000000000000000;
        } else {
            let v10 = UserStats{
                sui_burned            : 0,
                coins_burned          : 1,
                nfts_burned           : 0,
                burn_count            : 1,
                contribution_points   : v2,
                total_rewards_claimed : 0,
                last_burn_timestamp   : v8,
                last_claim_timestamp  : 0,
                reward_debt           : (v2 as u256) * arg0.acc_rewards_per_point / 1000000000000000000000,
                pending_rewards       : 0,
            };
            0x2::table::add<address, UserStats>(&mut arg0.user_stats, v0, v10);
        };
        let v11 = AssetBurnEvent{
            burner          : v0,
            asset_type      : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            amount_or_count : v1,
            points_earned   : v2,
            fee_paid        : arg0.fee_amount,
            timestamp_ms    : v8,
        };
        0x2::event::emit<AssetBurnEvent>(v11);
        (v1, v8)
    }

    public fun burn_coin_with_airdrop<T0, T1>(arg0: &mut BurnService, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::AirdropVault<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = burn_coin_internal<T0>(arg0, arg1, arg2, 0x1::option::some<address>(0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::get_vault_owner<T1>(arg3)), arg4);
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::process_airdrop<T1>(arg3, v0, arg0.burn_count, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), arg4);
    }

    public fun burn_nft<T0: store + key>(arg0: &mut BurnService, arg1: T0, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        burn_nft_internal<T0>(arg0, arg1, arg2, 0x1::option::none<address>(), arg3);
    }

    fun burn_nft_internal<T0: store + key>(arg0: &mut BurnService, arg1: T0, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.fee_amount, 0);
        let v1 = calculate_deflationary_points(arg0.burn_count, arg0.fee_amount);
        assert!(arg0.total_contribution_points <= 330000000000000000000000000000000000000 - v1, 5);
        let v2 = arg0.fee_amount * 10 / 100;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.owner_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v2));
        let v4 = if (0x1::option::is_some<address>(&arg3)) {
            let v5 = arg0.fee_amount * 10 / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v5), arg4), 0x1::option::destroy_some<address>(arg3));
            arg0.fee_amount - v2 - v5
        } else {
            arg0.fee_amount - v2
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.staking_pool, v3);
        update_pool(arg0, v4);
        arg0.staking_pool_total_contributed = arg0.staking_pool_total_contributed + (v4 as u128);
        0x2::transfer::public_transfer<T0>(arg1, @0x0);
        arg0.total_burned_nfts = arg0.total_burned_nfts + 1;
        arg0.burn_count = arg0.burn_count + 1;
        arg0.total_contribution_points = arg0.total_contribution_points + v1;
        let v6 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        mint_ash(arg0, v1, arg4);
        if (0x2::table::contains<address, UserStats>(&arg0.user_stats, v0)) {
            let v7 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.user_stats, v0);
            v7.pending_rewards = v7.pending_rewards + (((v7.contribution_points as u256) * arg0.acc_rewards_per_point / 1000000000000000000000 - v7.reward_debt) as u64);
            v7.nfts_burned = v7.nfts_burned + 1;
            v7.burn_count = v7.burn_count + 1;
            v7.contribution_points = v7.contribution_points + v1;
            v7.last_burn_timestamp = v6;
            v7.reward_debt = (v7.contribution_points as u256) * arg0.acc_rewards_per_point / 1000000000000000000000;
        } else {
            let v8 = UserStats{
                sui_burned            : 0,
                coins_burned          : 0,
                nfts_burned           : 1,
                burn_count            : 1,
                contribution_points   : v1,
                total_rewards_claimed : 0,
                last_burn_timestamp   : v6,
                last_claim_timestamp  : 0,
                reward_debt           : (v1 as u256) * arg0.acc_rewards_per_point / 1000000000000000000000,
                pending_rewards       : 0,
            };
            0x2::table::add<address, UserStats>(&mut arg0.user_stats, v0, v8);
        };
        let v9 = AssetBurnEvent{
            burner          : v0,
            asset_type      : b"NFT",
            amount_or_count : 1,
            points_earned   : v1,
            fee_paid        : arg0.fee_amount,
            timestamp_ms    : v6,
        };
        0x2::event::emit<AssetBurnEvent>(v9);
        v6
    }

    public fun burn_nft_with_airdrop<T0: store + key, T1>(arg0: &mut BurnService, arg1: T0, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::AirdropVault<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        burn_nft_internal<T0>(arg0, arg1, arg2, 0x1::option::some<address>(0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::get_vault_owner<T1>(arg3)), arg4);
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::process_airdrop<T1>(arg3, 1, arg0.burn_count, 0x1::string::utf8(b"NFT"), arg4);
    }

    public fun burn_tokens(arg0: &mut BurnService, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _) = burn_tokens_internal(arg0, arg1, 0x1::option::none<address>(), arg2);
    }

    fun burn_tokens_internal(arg0: &mut BurnService, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.fee_amount, 0);
        let v2 = v1 - arg0.fee_amount;
        let v3 = (v2 as u128);
        assert!(arg0.total_burned_sui <= 330000000000000000000000000000000000000 - v3, 5);
        let v4 = calculate_deflationary_points(arg0.burn_count, arg0.fee_amount);
        assert!(arg0.total_contribution_points <= 330000000000000000000000000000000000000 - v4, 5);
        let v5 = arg0.fee_amount * 10 / 100;
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.fee_amount, arg3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.owner_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v5));
        let v7 = if (0x1::option::is_some<address>(&arg2)) {
            let v8 = arg0.fee_amount * 10 / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v6, v8), arg3), 0x1::option::destroy_some<address>(arg2));
            arg0.fee_amount - v5 - v8
        } else {
            arg0.fee_amount - v5
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.staking_pool, v6);
        update_pool(arg0, v7);
        arg0.staking_pool_total_contributed = arg0.staking_pool_total_contributed + (v7 as u128);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.burned_sui_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_burned_sui = arg0.total_burned_sui + v3;
        arg0.burn_count = arg0.burn_count + 1;
        arg0.total_contribution_points = arg0.total_contribution_points + v4;
        let v9 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        mint_ash(arg0, v4, arg3);
        if (0x2::table::contains<address, UserStats>(&arg0.user_stats, v0)) {
            let v10 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.user_stats, v0);
            v10.pending_rewards = v10.pending_rewards + (((v10.contribution_points as u256) * arg0.acc_rewards_per_point / 1000000000000000000000 - v10.reward_debt) as u64);
            v10.sui_burned = v10.sui_burned + v3;
            v10.burn_count = v10.burn_count + 1;
            v10.contribution_points = v10.contribution_points + v4;
            v10.last_burn_timestamp = v9;
            v10.reward_debt = (v10.contribution_points as u256) * arg0.acc_rewards_per_point / 1000000000000000000000;
        } else {
            let v11 = UserStats{
                sui_burned            : v3,
                coins_burned          : 0,
                nfts_burned           : 0,
                burn_count            : 1,
                contribution_points   : v4,
                total_rewards_claimed : 0,
                last_burn_timestamp   : v9,
                last_claim_timestamp  : 0,
                reward_debt           : (v4 as u256) * arg0.acc_rewards_per_point / 1000000000000000000000,
                pending_rewards       : 0,
            };
            0x2::table::add<address, UserStats>(&mut arg0.user_stats, v0, v11);
        };
        let v12 = BurnEvent{
            burner        : v0,
            amount_burned : v2,
            points_earned : v4,
            fee_paid      : arg0.fee_amount,
            timestamp_ms  : v9,
        };
        0x2::event::emit<BurnEvent>(v12);
        let v13 = AssetBurnEvent{
            burner          : v0,
            asset_type      : b"SUI",
            amount_or_count : v2,
            points_earned   : v4,
            fee_paid        : arg0.fee_amount,
            timestamp_ms    : v9,
        };
        0x2::event::emit<AssetBurnEvent>(v13);
        (v2, v9)
    }

    public fun burn_tokens_with_airdrop<T0>(arg0: &mut BurnService, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::AirdropVault<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = burn_tokens_internal(arg0, arg1, 0x1::option::some<address>(0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::get_vault_owner<T0>(arg2)), arg3);
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::process_airdrop<T0>(arg2, v0, arg0.burn_count, 0x1::string::utf8(b"0x2::sui::SUI"), arg3);
    }

    fun calculate_deflationary_points(arg0: u64, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = arg0 / 50000;
        let v1 = if (v0 > 100) {
            100
        } else {
            v0
        };
        (arg1 as u128) * 80 / 100 * ((10000 - v1 * 50) as u128) / 10000
    }

    public fun calculate_pending_reward(arg0: &BurnService, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserStats>(&arg0.user_stats, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, UserStats>(&arg0.user_stats, arg1);
        let v1 = v0.reward_debt;
        let v2 = (v0.contribution_points as u256) * arg0.acc_rewards_per_point / 1000000000000000000000;
        let v3 = if (v2 > v1) {
            ((v2 - v1) as u64)
        } else {
            0
        };
        v0.pending_rewards + v3
    }

    public fun calculate_staker_share(arg0: &BurnService, arg1: address) : u64 {
        0
    }

    public fun claim_rewards(arg0: &mut BurnService, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        assert!(0x2::table::contains<address, UserStats>(&arg0.user_stats, v0), 2);
        let v2 = 0x2::table::borrow<address, UserStats>(&arg0.user_stats, v0);
        let v3 = v2.contribution_points;
        let v4 = v2.last_burn_timestamp;
        let v5 = v2.reward_debt;
        let v6 = v2.pending_rewards;
        let v7 = (v3 as u256) * arg0.acc_rewards_per_point / 1000000000000000000000;
        let v8 = if (v7 > v5) {
            ((v7 - v5) as u64)
        } else {
            0
        };
        let v9 = v6 + v8;
        assert!(v9 > 0, 2);
        let v10 = 0x2::balance::zero<0x2::sui::SUI>();
        if (v9 > 0) {
            let v11 = 0x2::balance::value<0x2::sui::SUI>(&arg0.staking_pool);
            let v12 = if (v9 > v11) {
                v11
            } else {
                v9
            };
            if (v12 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut v10, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.staking_pool, v12));
            };
        };
        let v13 = 0x2::balance::value<0x2::sui::SUI>(&v10);
        let (_, v15) = 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::staking::calculate_claim_penalty(v4, v1, v13);
        let (_, v17) = 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::staking::calculate_points_penalty(v4, v1, v3);
        if (v15 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.staking_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v10, v15));
            update_pool(arg0, v15);
            arg0.staking_pool_total_contributed = arg0.staking_pool_total_contributed + (v15 as u128);
        };
        let v18 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.user_stats, v0);
        v18.contribution_points = 0;
        v18.pending_rewards = 0;
        v18.last_claim_timestamp = v1;
        v18.total_rewards_claimed = v18.total_rewards_claimed + ((v13 - v15) as u128);
        v18.reward_debt = 0;
        let v19 = v3 + v17;
        if (arg0.total_contribution_points >= v19) {
            arg0.total_contribution_points = arg0.total_contribution_points - v19;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v10, arg1), v0);
        let v20 = ClaimEvent{
            claimer       : v0,
            reward_amount : v13 - v15,
            points_spent  : v3,
            timestamp_ms  : v1,
        };
        0x2::event::emit<ClaimEvent>(v20);
    }

    public fun claim_staking_rewards(arg0: &mut BurnService, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        assert!(0x2::table::contains<address, UserStats>(&arg0.user_stats, v0), 2);
        let v2 = 0x2::table::borrow<address, UserStats>(&arg0.user_stats, v0);
        let v3 = v2.contribution_points;
        let v4 = v2.last_burn_timestamp;
        let v5 = v2.reward_debt;
        let v6 = v2.pending_rewards;
        let v7 = (v3 as u256) * arg0.acc_rewards_per_point / 1000000000000000000000;
        let v8 = if (v7 > v5) {
            ((v7 - v5) as u64)
        } else {
            0
        };
        let v9 = v6 + v8;
        assert!(v9 > 0, 2);
        let v10 = 0x2::balance::zero<0x2::sui::SUI>();
        if (v9 > 0) {
            let v11 = 0x2::balance::value<0x2::sui::SUI>(&arg0.staking_pool);
            let v12 = if (v9 > v11) {
                v11
            } else {
                v9
            };
            if (v12 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut v10, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.staking_pool, v12));
            };
        };
        let v13 = 0x2::balance::value<0x2::sui::SUI>(&v10);
        let (_, v15) = 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::staking::calculate_claim_penalty(v4, v1, v13);
        let (v16, v17) = 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::staking::calculate_points_penalty(v4, v1, v3);
        if (v15 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.staking_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v10, v15));
            update_pool(arg0, v15);
            arg0.staking_pool_total_contributed = arg0.staking_pool_total_contributed + (v15 as u128);
        };
        let v18 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.user_stats, v0);
        v18.contribution_points = v16;
        v18.pending_rewards = 0;
        v18.last_claim_timestamp = v1;
        v18.total_rewards_claimed = v18.total_rewards_claimed + ((v13 - v15) as u128);
        v18.reward_debt = (v16 as u256) * arg0.acc_rewards_per_point / 1000000000000000000000;
        if (v17 > 0 && arg0.total_contribution_points >= v17) {
            arg0.total_contribution_points = arg0.total_contribution_points - v17;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v10, arg1), v0);
        let v19 = ClaimEvent{
            claimer       : v0,
            reward_amount : v13 - v15,
            points_spent  : 0,
            timestamp_ms  : v1,
        };
        0x2::event::emit<ClaimEvent>(v19);
    }

    public fun close_vault<T0>(arg0: &mut 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::AirdropVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::close_vault<T0>(arg0, arg1);
    }

    public fun create_vault<T0>(arg0: &mut BurnService, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: 0x1::option::Option<0x1::string::String>, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 1, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.vault_creation_fee, 0);
        let v0 = arg0.vault_creation_fee * 10 / 100;
        let v1 = arg0.vault_creation_fee - v0;
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.vault_creation_fee, arg9));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.owner_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v0));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.staking_pool, v2);
        update_pool(arg0, v1);
        arg0.staking_pool_total_contributed = arg0.staking_pool_total_contributed + (v1 as u128);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::create_vault<T0>(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun create_vault_sui(arg0: &mut BurnService, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: 0x1::option::Option<0x1::string::String>, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > arg0.vault_creation_fee, 0);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.vault_creation_fee, arg8));
        let v1 = arg0.vault_creation_fee * 10 / 100;
        let v2 = arg0.vault_creation_fee - v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.owner_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v0, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.staking_pool, v0);
        update_pool(arg0, v2);
        arg0.staking_pool_total_contributed = arg0.staking_pool_total_contributed + (v2 as u128);
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::create_vault<0x2::sui::SUI>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun get_fee(arg0: &BurnService) : u64 {
        arg0.fee_amount
    }

    public fun get_global_stats(arg0: &BurnService) : (u128, u64, u64, u64, u128, u64, u64) {
        (arg0.total_burned_sui, arg0.total_burned_coins, arg0.total_burned_nfts, arg0.burn_count, arg0.total_contribution_points, get_staking_pool_balance(arg0), arg0.ash_multiplier)
    }

    public fun get_owner_fees_balance(arg0: &BurnService) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.owner_fees)
    }

    public fun get_staking_pool_balance(arg0: &BurnService) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.staking_pool)
    }

    public fun get_staking_pool_stats(arg0: &BurnService) : (u64, u128, u128) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.staking_pool), arg0.staking_pool_total_contributed, arg0.staking_pool_total_claimed)
    }

    public fun get_total_users(arg0: &BurnService) : u64 {
        0x2::table::length<address, UserStats>(&arg0.user_stats)
    }

    public fun get_user_pool_percentage(arg0: &BurnService, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserStats>(&arg0.user_stats, arg1) || arg0.total_contribution_points == 0) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, UserStats>(&arg0.user_stats, arg1).contribution_points * 10000 / arg0.total_contribution_points;
        if (v0 > 10000) {
            return 10000
        };
        (v0 as u64)
    }

    public fun get_user_stats(arg0: &BurnService, arg1: address) : 0x1::option::Option<UserStats> {
        if (0x2::table::contains<address, UserStats>(&arg0.user_stats, arg1)) {
            0x1::option::some<UserStats>(*0x2::table::borrow<address, UserStats>(&arg0.user_stats, arg1))
        } else {
            0x1::option::none<UserStats>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        let v1 = BurnService{
            id                             : 0x2::object::new(arg0),
            fee_amount                     : 20000000,
            owner_fees                     : 0x2::balance::zero<0x2::sui::SUI>(),
            staking_pool                   : 0x2::balance::zero<0x2::sui::SUI>(),
            total_burned_sui               : 0,
            total_burned_coins             : 0,
            total_burned_nfts              : 0,
            burn_count                     : 0,
            total_contribution_points      : 0,
            user_stats                     : 0x2::table::new<address, UserStats>(arg0),
            staking_pool_total_contributed : 0,
            staking_pool_total_claimed     : 0,
            vault_creation_fee             : 100000000,
            acc_rewards_per_point          : 0,
            burned_sui_pool                : 0x2::balance::zero<0x2::sui::SUI>(),
            garbage_collector              : 0x2::bag::new(arg0),
            ash_treasury                   : 0x1::option::none<0x2::coin::TreasuryCap<0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::ash::ASH>>(),
            ash_multiplier                 : 100000,
        };
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<BurnService>(v1);
    }

    fun mint_ash(arg0: &mut BurnService, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::TreasuryCap<0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::ash::ASH>>(&arg0.ash_treasury)) {
            let v0 = 0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::ash::ASH>>(&mut arg0.ash_treasury);
            let v1 = arg1 * (arg0.ash_multiplier as u128);
            let v2 = if (v1 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v1 as u64)
            };
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::ash::ASH>>(0x2::coin::mint<0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::ash::ASH>(v0, v2, arg2), 0x2::tx_context::sender(arg2));
            };
        };
    }

    public fun reclaim_storage_rebate<T0>(arg0: &mut BurnService, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == 0, 0);
        0x2::coin::destroy_zero<T0>(arg1);
        arg0.burn_count = arg0.burn_count + 1;
        let v0 = AssetBurnEvent{
            burner          : 0x2::tx_context::sender(arg2),
            asset_type      : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            amount_or_count : 0,
            points_earned   : 0,
            fee_paid        : 0,
            timestamp_ms    : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<AssetBurnEvent>(v0);
    }

    public fun reinvest_owner_fees(arg0: &OwnerCap, arg1: &mut BurnService, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.owner_fees);
        assert!(v0 > 0, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.staking_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.owner_fees, v0));
        update_pool(arg1, v0);
        arg1.staking_pool_total_contributed = arg1.staking_pool_total_contributed + (v0 as u128);
    }

    public fun seed_staking_pool(arg0: &OwnerCap, arg1: &mut BurnService, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= arg3, 0);
        let v1 = if (v0 == arg3) {
            arg2
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
            0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3, arg4)
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.staking_pool, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        update_pool(arg1, arg3);
        arg1.staking_pool_total_contributed = arg1.staking_pool_total_contributed + (arg3 as u128);
    }

    public fun set_ash_treasury(arg0: &OwnerCap, arg1: &mut BurnService, arg2: 0x2::coin::TreasuryCap<0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::ash::ASH>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::TreasuryCap<0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::ash::ASH>>(&arg1.ash_treasury)) {
            abort 999
        };
        0x1::option::fill<0x2::coin::TreasuryCap<0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::ash::ASH>>(&mut arg1.ash_treasury, arg2);
    }

    public fun top_up_vault<T0>(arg0: &mut 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::AirdropVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault::top_up_vault<T0>(arg0, arg1);
    }

    public fun update_ash_multiplier(arg0: &OwnerCap, arg1: &mut BurnService, arg2: &0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version::Version, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version::assert_current_version(arg2);
        assert!(arg3 >= 100000, 4);
        assert!(arg3 <= 300000, 4);
        arg1.ash_multiplier = arg3;
    }

    public fun update_fee(arg0: &OwnerCap, arg1: &mut BurnService, arg2: &0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version::Version, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version::assert_current_version(arg2);
        assert!(arg3 > 0, 4);
        assert!(arg3 <= 100000000, 4);
        arg1.fee_amount = arg3;
        let v0 = FeeUpdateEvent{
            old_fee      : arg1.fee_amount,
            new_fee      : arg3,
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<FeeUpdateEvent>(v0);
    }

    fun update_pool(arg0: &mut BurnService, arg1: u64) {
        if (arg0.total_contribution_points > 0) {
            arg0.acc_rewards_per_point = arg0.acc_rewards_per_point + (arg1 as u256) * 1000000000000000000000 / (arg0.total_contribution_points as u256);
        };
    }

    public fun update_vault_creation_fee(arg0: &OwnerCap, arg1: &mut BurnService, arg2: &0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version::Version, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version::assert_current_version(arg2);
        assert!(arg3 > 0, 4);
        assert!(arg3 <= 500000000, 4);
        arg1.vault_creation_fee = arg3;
        let v0 = FeeUpdateEvent{
            old_fee      : arg1.vault_creation_fee,
            new_fee      : arg3,
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<FeeUpdateEvent>(v0);
    }

    public fun user_exists(arg0: &BurnService, arg1: address) : bool {
        0x2::table::contains<address, UserStats>(&arg0.user_stats, arg1)
    }

    public fun withdraw_owner_fees(arg0: &OwnerCap, arg1: &mut BurnService, arg2: &0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version::assert_current_version(arg2);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.owner_fees);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.owner_fees, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_owner_fees_partial(arg0: &OwnerCap, arg1: &mut BurnService, arg2: &0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version::Version, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::version::assert_current_version(arg2);
        assert!(arg3 > 0, 0);
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.owner_fees), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.owner_fees, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

