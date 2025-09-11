module 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v3 {
    struct Incentive has store, key {
        id: 0x2::object::UID,
        version: u64,
        pools: 0x2::vec_map::VecMap<0x1::ascii::String, AssetPool>,
        borrow_fee_rate: u64,
        fee_balance: 0x2::bag::Bag,
    }

    struct AssetPool has store, key {
        id: 0x2::object::UID,
        asset: u8,
        asset_coin_type: 0x1::ascii::String,
        rules: 0x2::vec_map::VecMap<address, Rule>,
    }

    struct Rule has store, key {
        id: 0x2::object::UID,
        option: u8,
        enable: bool,
        reward_coin_type: 0x1::ascii::String,
        rate: u256,
        max_rate: u256,
        last_update_at: u64,
        global_index: u256,
        user_index: 0x2::table::Table<address, u256>,
        user_total_rewards: 0x2::table::Table<address, u256>,
        user_rewards_claimed: 0x2::table::Table<address, u256>,
    }

    struct RewardFund<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        coin_type: 0x1::ascii::String,
    }

    struct ClaimableReward has copy, drop {
        asset_coin_type: 0x1::ascii::String,
        reward_coin_type: 0x1::ascii::String,
        user_claimable_reward: u256,
        user_claimed_reward: u256,
        rule_ids: vector<address>,
    }

    struct RewardFundCreated has copy, drop {
        sender: address,
        reward_fund_id: address,
        coin_type: 0x1::ascii::String,
    }

    struct RewardFundDeposited has copy, drop {
        sender: address,
        reward_fund_id: address,
        amount: u64,
    }

    struct RewardFundWithdrawn has copy, drop {
        sender: address,
        reward_fund_id: address,
        amount: u64,
    }

    struct IncentiveCreated has copy, drop {
        sender: address,
        incentive_id: address,
    }

    struct AssetPoolCreated has copy, drop {
        sender: address,
        asset_id: u8,
        asset_coin_type: 0x1::ascii::String,
        pool_id: address,
    }

    struct RuleCreated has copy, drop {
        sender: address,
        pool: 0x1::ascii::String,
        rule_id: address,
        option: u8,
        reward_coin_type: 0x1::ascii::String,
    }

    struct BorrowFeeRateUpdated has copy, drop {
        sender: address,
        rate: u64,
    }

    struct BorrowFeeWithdrawn has copy, drop {
        sender: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct RewardStateUpdated has copy, drop {
        sender: address,
        rule_id: address,
        enable: bool,
    }

    struct MaxRewardRateUpdated has copy, drop {
        rule_id: address,
        max_total_supply: u64,
        duration_ms: u64,
    }

    struct RewardRateUpdated has copy, drop {
        sender: address,
        pool: 0x1::ascii::String,
        rule_id: address,
        rate: u256,
        total_supply: u64,
        duration_ms: u64,
        timestamp: u64,
    }

    struct RewardClaimed has copy, drop {
        user: address,
        total_claimed: u64,
        coin_type: 0x1::ascii::String,
        rule_ids: vector<address>,
        rule_indices: vector<u256>,
    }

    public fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg8);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg6, arg2, arg4, v0);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        let v1 = get_borrow_fee(arg7, arg5);
        let v2 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::borrow_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5 + v1, arg8);
        let v3 = &mut v2;
        deposit_borrow_fee<T0>(arg7, v3, v1);
        v2
    }

    fun base_claim_reward_by_rule<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg2: &mut Incentive, arg3: &mut RewardFund<T0>, arg4: 0x1::ascii::String, arg5: address, arg6: address) : (u256, 0x2::balance::Balance<T0>) {
        assert!(0x2::vec_map::contains<0x1::ascii::String, AssetPool>(&arg2.pools, &arg4), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::pool_not_found());
        let v0 = 0x2::vec_map::get_mut<0x1::ascii::String, AssetPool>(&mut arg2.pools, &arg4);
        assert!(0x2::vec_map::contains<address, Rule>(&v0.rules, &arg5), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::rule_not_found());
        let v1 = 0x2::vec_map::get_mut<address, Rule>(&mut v0.rules, &arg5);
        assert!(v1.reward_coin_type == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::invalid_coin_type());
        if (!v1.enable) {
            return (v1.global_index, 0x2::balance::zero<T0>())
        };
        update_reward_state_by_rule(arg0, arg1, v0.asset, v1, arg6);
        let v2 = *0x2::table::borrow<address, u256>(&v1.user_total_rewards, arg6);
        if (!0x2::table::contains<address, u256>(&v1.user_rewards_claimed, arg6)) {
            0x2::table::add<address, u256>(&mut v1.user_rewards_claimed, arg6, 0);
        };
        let v3 = 0x2::table::borrow_mut<address, u256>(&mut v1.user_rewards_claimed, arg6);
        let v4 = if (v2 > *v3) {
            v2 - *v3
        } else {
            0
        };
        *v3 = v2;
        if (v4 > 0) {
            return (v1.global_index, 0x2::balance::split<T0>(&mut arg3.balance, (v4 as u64)))
        };
        (v1.global_index, 0x2::balance::zero<T0>())
    }

    fun base_claim_reward_by_rules<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg2: &mut Incentive, arg3: &mut RewardFund<T0>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: address) : 0x2::balance::Balance<T0> {
        version_verification(arg2);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg4) == 0x1::vector::length<address>(&arg5), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::invalid_coin_type());
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&arg4)) {
            let (v3, v4) = base_claim_reward_by_rule<T0>(arg0, arg1, arg2, arg3, *0x1::vector::borrow<0x1::ascii::String>(&arg4, v2), *0x1::vector::borrow<address>(&arg5, v2), arg6);
            0x1::vector::push_back<u256>(&mut v1, v3);
            0x2::balance::join<T0>(&mut v0, v4);
            v2 = v2 + 1;
        };
        let v5 = RewardClaimed{
            user          : arg6,
            total_claimed : 0x2::balance::value<T0>(&v0),
            coin_type     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            rule_ids      : arg5,
            rule_indices  : v1,
        };
        0x2::event::emit<RewardClaimed>(v5);
        v0
    }

    public fun borrow_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::account::AccountCap) : 0x2::balance::Balance<T0> {
        let v0 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::account::account_owner(arg8);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg6, arg2, arg4, v0);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        let v1 = get_borrow_fee(arg7, arg5);
        let v2 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::borrow_with_account_cap<T0>(arg0, arg1, arg2, arg3, arg4, arg5 + v1, arg8);
        let v3 = &mut v2;
        deposit_borrow_fee<T0>(arg7, v3, v1);
        v2
    }

    fun calculate_global_index(arg0: &0x2::clock::Clock, arg1: &Rule, arg2: u256, arg3: u256) : u256 {
        let v0 = if (arg1.option == 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::constants::option_type_supply()) {
            arg2
        } else {
            assert!(arg1.option == 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::constants::option_type_borrow(), 0);
            arg3
        };
        let v1 = 0x2::clock::timestamp_ms(arg0) - arg1.last_update_at;
        let v2 = if (v1 == 0 || v0 == 0) {
            0
        } else {
            arg1.rate * (v1 as u256) / v0
        };
        arg1.global_index + v2
    }

    fun calculate_user_reward(arg0: &Rule, arg1: u256, arg2: address, arg3: u256, arg4: u256) : u256 {
        let v0 = if (arg0.option == 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::constants::option_type_supply()) {
            arg3
        } else {
            assert!(arg0.option == 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::constants::option_type_borrow(), 0);
            arg4
        };
        get_user_total_rewards_by_rule(arg0, arg2) + 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::ray_math::ray_mul(v0, arg1 - get_user_index_by_rule(arg0, arg2))
    }

    public fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut RewardFund<T0>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_claim_reward_by_rules<T0>(arg0, arg2, arg1, arg3, arg4, arg5, 0x2::tx_context::sender(arg6))
    }

    public entry fun claim_reward_entry<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut RewardFund<T0>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(base_claim_reward_by_rules<T0>(arg0, arg2, arg1, arg3, arg4, arg5, 0x2::tx_context::sender(arg6)), arg6), 0x2::tx_context::sender(arg6));
    }

    public fun claim_reward_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut RewardFund<T0>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_claim_reward_by_rules<T0>(arg0, arg2, arg1, arg3, arg4, arg5, 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::account::account_owner(arg6))
    }

    public fun contains_rule(arg0: &AssetPool, arg1: u8, arg2: 0x1::ascii::String) : bool {
        let v0 = 0x2::vec_map::keys<address, Rule>(&arg0.rules);
        while (0x1::vector::length<address>(&v0) > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut v0);
            let v2 = 0x2::vec_map::get<address, Rule>(&arg0.rules, &v1);
            if (v2.option == arg1 && v2.reward_coin_type == arg2) {
                return true
            };
        };
        false
    }

    public(friend) fun create_incentive_v3(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = Incentive{
            id              : v0,
            version         : 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::version::this_version(),
            pools           : 0x2::vec_map::empty<0x1::ascii::String, AssetPool>(),
            borrow_fee_rate : 0,
            fee_balance     : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Incentive>(v1);
        let v2 = IncentiveCreated{
            sender       : 0x2::tx_context::sender(arg0),
            incentive_id : 0x2::object::uid_to_address(&v0),
        };
        0x2::event::emit<IncentiveCreated>(v2);
    }

    public(friend) fun create_pool<T0>(arg0: &mut Incentive, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        version_verification(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(v0 == 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::get_coin_type(arg1, arg2), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::invalid_coin_type());
        assert!(!0x2::vec_map::contains<0x1::ascii::String, AssetPool>(&arg0.pools, &v0), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::duplicate_config());
        let v1 = 0x2::object::new(arg3);
        let v2 = AssetPool{
            id              : v1,
            asset           : arg2,
            asset_coin_type : v0,
            rules           : 0x2::vec_map::empty<address, Rule>(),
        };
        0x2::vec_map::insert<0x1::ascii::String, AssetPool>(&mut arg0.pools, v0, v2);
        let v3 = AssetPoolCreated{
            sender          : 0x2::tx_context::sender(arg3),
            asset_id        : arg2,
            asset_coin_type : v0,
            pool_id         : 0x2::object::uid_to_address(&v1),
        };
        0x2::event::emit<AssetPoolCreated>(v3);
    }

    public(friend) fun create_reward_fund<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::object::new(arg0);
        let v2 = RewardFund<T0>{
            id        : v1,
            balance   : 0x2::balance::zero<T0>(),
            coin_type : v0,
        };
        0x2::transfer::share_object<RewardFund<T0>>(v2);
        let v3 = RewardFundCreated{
            sender         : 0x2::tx_context::sender(arg0),
            reward_fund_id : 0x2::object::uid_to_address(&v1),
            coin_type      : v0,
        };
        0x2::event::emit<RewardFundCreated>(v3);
    }

    public(friend) fun create_rule<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        version_verification(arg1);
        assert!(arg2 == 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::constants::option_type_supply() || arg2 == 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::constants::option_type_borrow(), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::invalid_option());
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::vec_map::contains<0x1::ascii::String, AssetPool>(&arg1.pools, &v0), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::pool_not_found());
        let v1 = 0x2::vec_map::get_mut<0x1::ascii::String, AssetPool>(&mut arg1.pools, &v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!contains_rule(v1, arg2, v2), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::duplicate_config());
        let v3 = 0x2::object::new(arg3);
        let v4 = 0x2::object::uid_to_address(&v3);
        let v5 = Rule{
            id                   : v3,
            option               : arg2,
            enable               : true,
            reward_coin_type     : v2,
            rate                 : 0,
            max_rate             : 0,
            last_update_at       : 0x2::clock::timestamp_ms(arg0),
            global_index         : 0,
            user_index           : 0x2::table::new<address, u256>(arg3),
            user_total_rewards   : 0x2::table::new<address, u256>(arg3),
            user_rewards_claimed : 0x2::table::new<address, u256>(arg3),
        };
        0x2::vec_map::insert<address, Rule>(&mut v1.rules, v4, v5);
        let v6 = RuleCreated{
            sender           : 0x2::tx_context::sender(arg3),
            pool             : v0,
            rule_id          : v4,
            option           : arg2,
            reward_coin_type : v2,
        };
        0x2::event::emit<RuleCreated>(v6);
    }

    fun deposit_borrow_fee<T0>(arg0: &mut Incentive, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) {
        if (arg2 > 0) {
            let v0 = 0x1::type_name::get<T0>();
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_balance, v0)) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balance, v0), 0x2::balance::split<T0>(arg1, arg2));
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balance, v0, 0x2::balance::split<T0>(arg1, arg2));
            };
        };
    }

    public(friend) fun deposit_reward_fund<T0>(arg0: &mut RewardFund<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        let v0 = RewardFundDeposited{
            sender         : 0x2::tx_context::sender(arg2),
            reward_fund_id : 0x2::object::uid_to_address(&arg0.id),
            amount         : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<RewardFundDeposited>(v0);
    }

    public fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg6: &mut Incentive, arg7: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::account::AccountCap) {
        let v0 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::account::account_owner(arg7);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg5, arg1, arg3, v0);
        update_reward_state_by_asset<T0>(arg0, arg6, arg1, v0);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::deposit_with_account_cap<T0>(arg0, arg1, arg2, arg3, arg4, arg7);
    }

    public entry fun entry_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg6, arg2, arg4, v0);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        let v1 = get_borrow_fee(arg7, arg5);
        let v2 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::borrow_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5 + v1, arg8);
        let v3 = &mut v2;
        deposit_borrow_fee<T0>(arg7, v3, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg8), 0x2::tx_context::sender(arg8));
    }

    public entry fun entry_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg6, arg1, arg3, v0);
        update_reward_state_by_asset<T0>(arg0, arg7, arg1, v0);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::deposit_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8);
    }

    public entry fun entry_deposit_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: address, arg7: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg8: &mut Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg7, arg1, arg3, arg6);
        update_reward_state_by_asset<T0>(arg0, arg8, arg1, arg6);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::deposit_on_behalf_of_user<T0>(arg0, arg1, arg2, arg3, arg6, arg4, arg5, arg9);
    }

    public entry fun entry_liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: u8, arg4: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T1>, arg8: address, arg9: u64, arg10: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg11: &mut Incentive, arg12: &mut 0x2::tx_context::TxContext) {
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg10, arg2, arg6, @0x0);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg10, arg2, arg3, @0x0);
        update_reward_state_by_asset<T0>(arg0, arg11, arg2, arg8);
        update_reward_state_by_asset<T1>(arg0, arg11, arg2, arg8);
        let v0 = 0x2::tx_context::sender(arg12);
        let (v1, v2) = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::liquidation<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v3 = v2;
        let v4 = v1;
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg12), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg12), v0);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
    }

    public entry fun entry_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg8: &mut Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg7, arg2, arg4, 0x2::tx_context::sender(arg9));
        update_reward_state_by_asset<T0>(arg0, arg8, arg2, 0x2::tx_context::sender(arg9));
        let v0 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::repay_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9);
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg9), 0x2::tx_context::sender(arg9));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public fun entry_repay_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: address, arg8: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg9: &mut Incentive, arg10: &mut 0x2::tx_context::TxContext) {
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg8, arg2, arg4, arg7);
        update_reward_state_by_asset<T0>(arg0, arg9, arg2, arg7);
        let v0 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::repay_on_behalf_of_user<T0>(arg0, arg1, arg2, arg3, arg4, arg7, arg5, arg6, arg10);
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public entry fun entry_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg6, arg2, arg4, v0);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::withdraw_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8), arg8), v0);
    }

    public fun get_balance_value_by_reward_fund<T0>(arg0: &RewardFund<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun get_borrow_fee(arg0: &Incentive, arg1: u64) : u64 {
        if (arg0.borrow_fee_rate > 0) {
            arg1 * arg0.borrow_fee_rate / 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::constants::percentage_benchmark()
        } else {
            0
        }
    }

    public fun get_effective_balance(arg0: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg1: u8, arg2: address) : (u256, u256, u256, u256) {
        let (v0, v1) = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::get_user_balance(arg0, arg1, arg2);
        let (v4, v5) = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::get_index(arg0, arg1);
        let v6 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::ray_math::ray_mul(v2, v4);
        let v7 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::ray_math::ray_mul(v3, v5);
        let v8 = 0;
        if (v6 > v7) {
            v8 = v6 - v7;
        };
        let v9 = 0;
        if (v7 > v6) {
            v9 = v7 - v6;
        };
        (v8, v9, 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::ray_math::ray_mul(v0, v4), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::ray_math::ray_mul(v1, v5))
    }

    fun get_mut_rule<T0>(arg0: &mut Incentive, arg1: address) : &mut Rule {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::vec_map::contains<0x1::ascii::String, AssetPool>(&arg0.pools, &v0), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::pool_not_found());
        let v1 = 0x2::vec_map::get_mut<0x1::ascii::String, AssetPool>(&mut arg0.pools, &v0);
        assert!(0x2::vec_map::contains<address, Rule>(&v1.rules, &arg1), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::rule_not_found());
        0x2::vec_map::get_mut<address, Rule>(&mut v1.rules, &arg1)
    }

    public fun get_pool_info(arg0: &AssetPool) : (address, u8, 0x1::ascii::String, &0x2::vec_map::VecMap<address, Rule>) {
        (0x2::object::uid_to_address(&arg0.id), arg0.asset, arg0.asset_coin_type, &arg0.rules)
    }

    public fun get_rule_info(arg0: &Rule) : (address, u8, bool, 0x1::ascii::String, u256, u64, u256, &0x2::table::Table<address, u256>, &0x2::table::Table<address, u256>, &0x2::table::Table<address, u256>) {
        (0x2::object::uid_to_address(&arg0.id), arg0.option, arg0.enable, arg0.reward_coin_type, arg0.rate, arg0.last_update_at, arg0.global_index, &arg0.user_index, &arg0.user_total_rewards, &arg0.user_rewards_claimed)
    }

    public fun get_user_claimable_rewards(arg0: &0x2::clock::Clock, arg1: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg2: &Incentive, arg3: address) : vector<ClaimableReward> {
        version_verification(arg2);
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, ClaimableReward>();
        let v1 = 0x2::vec_map::keys<0x1::ascii::String, AssetPool>(&arg2.pools);
        while (0x1::vector::length<0x1::ascii::String>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v1);
            let v3 = 0x2::vec_map::get<0x1::ascii::String, AssetPool>(&arg2.pools, &v2);
            let v4 = 0x2::vec_map::keys<address, Rule>(&v3.rules);
            let (v5, v6, v7, v8) = get_effective_balance(arg1, v3.asset, arg3);
            while (0x1::vector::length<address>(&v4) > 0) {
                let v9 = 0x1::vector::pop_back<address>(&mut v4);
                let v10 = 0x2::vec_map::get<address, Rule>(&v3.rules, &v9);
                let v11 = calculate_user_reward(v10, calculate_global_index(arg0, v10, v7, v8), arg3, v5, v6);
                let v12 = get_user_rewards_claimed_by_rule(v10, arg3);
                let v13 = if (v11 > v12) {
                    v11 - v12
                } else {
                    0
                };
                let v14 = 0x1::ascii::string(0x1::ascii::into_bytes(v2));
                0x1::ascii::append(&mut v14, 0x1::ascii::string(b","));
                0x1::ascii::append(&mut v14, v10.reward_coin_type);
                if (!0x2::vec_map::contains<0x1::ascii::String, ClaimableReward>(&v0, &v14)) {
                    let v15 = ClaimableReward{
                        asset_coin_type       : v2,
                        reward_coin_type      : v10.reward_coin_type,
                        user_claimable_reward : 0,
                        user_claimed_reward   : 0,
                        rule_ids              : 0x1::vector::empty<address>(),
                    };
                    0x2::vec_map::insert<0x1::ascii::String, ClaimableReward>(&mut v0, v14, v15);
                };
                let v16 = 0x2::vec_map::get_mut<0x1::ascii::String, ClaimableReward>(&mut v0, &v14);
                v16.user_claimable_reward = v16.user_claimable_reward + v13;
                v16.user_claimed_reward = v16.user_claimed_reward + v12;
                if (v13 > 0) {
                    0x1::vector::push_back<address>(&mut v16.rule_ids, v9);
                    continue
                };
            };
        };
        let v17 = 0x1::vector::empty<ClaimableReward>();
        let v18 = 0x2::vec_map::keys<0x1::ascii::String, ClaimableReward>(&v0);
        while (0x1::vector::length<0x1::ascii::String>(&v18) > 0) {
            let v19 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v18);
            let v20 = 0x2::vec_map::get<0x1::ascii::String, ClaimableReward>(&v0, &v19);
            if (v20.user_claimable_reward > 0 || v20.user_claimed_reward > 0) {
                0x1::vector::push_back<ClaimableReward>(&mut v17, *v20);
                continue
            };
        };
        v17
    }

    public fun get_user_index_by_rule(arg0: &Rule, arg1: address) : u256 {
        if (0x2::table::contains<address, u256>(&arg0.user_index, arg1)) {
            *0x2::table::borrow<address, u256>(&arg0.user_index, arg1)
        } else {
            0
        }
    }

    public fun get_user_rewards_claimed_by_rule(arg0: &Rule, arg1: address) : u256 {
        if (0x2::table::contains<address, u256>(&arg0.user_rewards_claimed, arg1)) {
            *0x2::table::borrow<address, u256>(&arg0.user_rewards_claimed, arg1)
        } else {
            0
        }
    }

    public fun get_user_total_rewards_by_rule(arg0: &Rule, arg1: address) : u256 {
        if (0x2::table::contains<address, u256>(&arg0.user_total_rewards, arg1)) {
            *0x2::table::borrow<address, u256>(&arg0.user_total_rewards, arg1)
        } else {
            0
        }
    }

    public fun liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: u8, arg4: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T1>, arg8: address, arg9: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg10: &mut Incentive, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg9, arg2, arg6, @0x0);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg9, arg2, arg3, @0x0);
        update_reward_state_by_asset<T0>(arg0, arg10, arg2, arg8);
        update_reward_state_by_asset<T1>(arg0, arg10, arg2, arg8);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::liquidation_non_entry<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11)
    }

    public fun parse_claimable_rewards(arg0: vector<ClaimableReward>) : (vector<0x1::ascii::String>, vector<0x1::ascii::String>, vector<u256>, vector<u256>, vector<vector<address>>) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u256>();
        let v3 = 0x1::vector::empty<u256>();
        let v4 = 0x1::vector::empty<vector<address>>();
        while (0x1::vector::length<ClaimableReward>(&arg0) > 0) {
            let v5 = 0x1::vector::pop_back<ClaimableReward>(&mut arg0);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, v5.asset_coin_type);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v5.reward_coin_type);
            0x1::vector::push_back<u256>(&mut v2, v5.user_claimable_reward);
            0x1::vector::push_back<u256>(&mut v3, v5.user_claimed_reward);
            0x1::vector::push_back<vector<address>>(&mut v4, v5.rule_ids);
        };
        (v0, v1, v2, v3, v4)
    }

    public fun pools(arg0: &Incentive) : &0x2::vec_map::VecMap<0x1::ascii::String, AssetPool> {
        &arg0.pools
    }

    public fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg8: &mut Incentive, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg9);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg7, arg2, arg4, v0);
        update_reward_state_by_asset<T0>(arg0, arg8, arg2, v0);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::repay_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9)
    }

    public fun repay_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::account::AccountCap) : 0x2::balance::Balance<T0> {
        let v0 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::account::account_owner(arg8);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg6, arg2, arg4, v0);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::repay_with_account_cap<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8)
    }

    public(friend) fun set_borrow_fee_rate(arg0: &mut Incentive, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        version_verification(arg0);
        assert!(arg1 <= 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::constants::percentage_benchmark() / 10, 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::invalid_value());
        arg0.borrow_fee_rate = arg1;
        let v0 = BorrowFeeRateUpdated{
            sender : 0x2::tx_context::sender(arg2),
            rate   : arg1,
        };
        0x2::event::emit<BorrowFeeRateUpdated>(v0);
    }

    public(friend) fun set_enable_by_rule_id<T0>(arg0: &mut Incentive, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        version_verification(arg0);
        get_mut_rule<T0>(arg0, arg1).enable = arg2;
        let v0 = RewardStateUpdated{
            sender  : 0x2::tx_context::sender(arg3),
            rule_id : arg1,
            enable  : arg2,
        };
        0x2::event::emit<RewardStateUpdated>(v0);
    }

    public(friend) fun set_max_reward_rate_by_rule_id<T0>(arg0: &mut Incentive, arg1: address, arg2: u64, arg3: u64) {
        version_verification(arg0);
        get_mut_rule<T0>(arg0, arg1).max_rate = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::ray_math::ray_div((arg2 as u256), (arg3 as u256));
        let v0 = MaxRewardRateUpdated{
            rule_id          : arg1,
            max_total_supply : arg2,
            duration_ms      : arg3,
        };
        0x2::event::emit<MaxRewardRateUpdated>(v0);
    }

    public(friend) fun set_reward_rate_by_rule_id<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        version_verification(arg1);
        update_reward_state_by_asset<T0>(arg0, arg1, arg2, @0x0);
        let v0 = 0;
        if (arg5 > 0) {
            v0 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::ray_math::ray_div((arg4 as u256), (arg5 as u256));
        };
        let v1 = get_mut_rule<T0>(arg1, arg3);
        assert!(v1.max_rate == 0 || v0 <= v1.max_rate, 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::invalid_value());
        v1.rate = v0;
        v1.last_update_at = 0x2::clock::timestamp_ms(arg0);
        let v2 = RewardRateUpdated{
            sender       : 0x2::tx_context::sender(arg6),
            pool         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            rule_id      : arg3,
            rate         : v0,
            total_supply : arg4,
            duration_ms  : arg5,
            timestamp    : v1.last_update_at,
        };
        0x2::event::emit<RewardRateUpdated>(v2);
    }

    public fun update_reward_state_by_asset<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: address) {
        version_verification(arg1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::vec_map::contains<0x1::ascii::String, AssetPool>(&arg1.pools, &v0)) {
            return
        };
        let v1 = 0x2::vec_map::get_mut<0x1::ascii::String, AssetPool>(&mut arg1.pools, &v0);
        let (v2, v3, v4, v5) = get_effective_balance(arg2, v1.asset, arg3);
        let v6 = 0x2::vec_map::keys<address, Rule>(&v1.rules);
        while (0x1::vector::length<address>(&v6) > 0) {
            let v7 = 0x1::vector::pop_back<address>(&mut v6);
            let v8 = 0x2::vec_map::get_mut<address, Rule>(&mut v1.rules, &v7);
            update_reward_state_by_rule_and_balance(arg0, v8, arg3, v2, v3, v4, v5);
        };
    }

    fun update_reward_state_by_rule(arg0: &0x2::clock::Clock, arg1: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg2: u8, arg3: &mut Rule, arg4: address) {
        let (v0, v1, v2, v3) = get_effective_balance(arg1, arg2, arg4);
        update_reward_state_by_rule_and_balance(arg0, arg3, arg4, v0, v1, v2, v3);
    }

    fun update_reward_state_by_rule_and_balance(arg0: &0x2::clock::Clock, arg1: &mut Rule, arg2: address, arg3: u256, arg4: u256, arg5: u256, arg6: u256) {
        let v0 = calculate_global_index(arg0, arg1, arg5, arg6);
        if (0x2::table::contains<address, u256>(&arg1.user_index, arg2)) {
            *0x2::table::borrow_mut<address, u256>(&mut arg1.user_index, arg2) = v0;
        } else {
            0x2::table::add<address, u256>(&mut arg1.user_index, arg2, v0);
        };
        if (0x2::table::contains<address, u256>(&arg1.user_total_rewards, arg2)) {
            *0x2::table::borrow_mut<address, u256>(&mut arg1.user_total_rewards, arg2) = calculate_user_reward(arg1, v0, arg2, arg3, arg4);
        } else {
            0x2::table::add<address, u256>(&mut arg1.user_total_rewards, arg2, calculate_user_reward(arg1, v0, arg2, arg3, arg4));
        };
        arg1.last_update_at = 0x2::clock::timestamp_ms(arg0);
        arg1.global_index = v0;
    }

    public fun version(arg0: &Incentive) : u64 {
        arg0.version
    }

    public(friend) fun version_migrate(arg0: &mut Incentive, arg1: u64) {
        arg0.version = arg1;
    }

    public fun version_verification(arg0: &Incentive) {
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::version::pre_check_version(arg0.version);
    }

    public fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg8);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg6, arg2, arg4, v0);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::withdraw_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8)
    }

    public(friend) fun withdraw_borrow_fee<T0>(arg0: &mut Incentive, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        version_verification(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_balance, v0), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::error::invalid_coin_type());
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balance, v0);
        let v2 = 0x1::u64::min(arg1, 0x2::balance::value<T0>(v1));
        let v3 = BorrowFeeWithdrawn{
            sender    : 0x2::tx_context::sender(arg2),
            coin_type : 0x1::type_name::into_string(v0),
            amount    : v2,
        };
        0x2::event::emit<BorrowFeeWithdrawn>(v3);
        0x2::balance::split<T0>(v1, v2)
    }

    public(friend) fun withdraw_reward_fund<T0>(arg0: &mut RewardFund<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::u64::min(arg1, 0x2::balance::value<T0>(&arg0.balance));
        let v1 = RewardFundWithdrawn{
            sender         : 0x2::tx_context::sender(arg2),
            reward_fund_id : 0x2::object::uid_to_address(&arg0.id),
            amount         : v0,
        };
        0x2::event::emit<RewardFundWithdrawn>(v1);
        0x2::balance::split<T0>(&mut arg0.balance, v0)
    }

    public fun withdraw_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle::PriceOracle, arg2: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::storage::Storage, arg3: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::account::AccountCap) : 0x2::balance::Balance<T0> {
        let v0 = 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::account::account_owner(arg8);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::incentive_v2::update_reward_all(arg0, arg6, arg2, arg4, v0);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::lending::withdraw_with_account_cap<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8)
    }

    // decompiled from Move bytecode v6
}

