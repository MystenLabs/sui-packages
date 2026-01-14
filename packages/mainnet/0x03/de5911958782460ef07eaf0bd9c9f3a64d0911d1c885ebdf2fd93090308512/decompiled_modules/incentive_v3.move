module 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v3 {
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

    struct AssetBorrowFeeRateUpdated has copy, drop {
        sender: address,
        asset_id: u8,
        user: address,
        rate: u64,
    }

    struct AssetBorrowFeeRateRemoved has copy, drop {
        sender: address,
        asset_id: u8,
        user: address,
    }

    struct BorrowFeeDeposited has copy, drop {
        sender: address,
        coin_type: 0x1::ascii::String,
        fee: u64,
    }

    struct ASSET_BORROW_FEES_KEY has copy, drop, store {
        dummy_field: bool,
    }

    struct USER_BORROW_FEES_KEY has copy, drop, store {
        dummy_field: bool,
    }

    struct MARKET_ID_KEY has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg8);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        let v1 = get_borrow_fee_v2(arg7, v0, arg4, arg5);
        let v2 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::borrow_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5 + v1, arg8);
        let v3 = &mut v2;
        deposit_borrow_fee<T0>(arg7, v3, v1, v0);
        v2
    }

    fun base_claim_reward_by_rule<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut Incentive, arg3: &mut RewardFund<T0>, arg4: 0x1::ascii::String, arg5: address, arg6: address) : (u256, 0x2::balance::Balance<T0>) {
        assert!(0x2::vec_map::contains<0x1::ascii::String, AssetPool>(&arg2.pools, &arg4), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::pool_not_found());
        let v0 = 0x2::vec_map::get_mut<0x1::ascii::String, AssetPool>(&mut arg2.pools, &arg4);
        assert!(0x2::vec_map::contains<address, Rule>(&v0.rules, &arg5), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::rule_not_found());
        let v1 = 0x2::vec_map::get_mut<address, Rule>(&mut v0.rules, &arg5);
        assert!(v1.reward_coin_type == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::invalid_coin_type());
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

    fun base_claim_reward_by_rules<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut Incentive, arg3: &mut RewardFund<T0>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: address) : 0x2::balance::Balance<T0> {
        version_verification(arg2);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg4) == 0x1::vector::length<address>(&arg5), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::invalid_coin_type());
        verify_market_storage_incentive(arg1, arg2);
        verify_market_incentive_funds<T0>(arg2, arg3);
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&arg4)) {
            let (v3, v4) = base_claim_reward_by_rule<T0>(arg0, arg1, arg2, arg3, *0x1::vector::borrow<0x1::ascii::String>(&arg4, v2), *0x1::vector::borrow<address>(&arg5, v2), arg6);
            0x1::vector::push_back<u256>(&mut v1, v3);
            0x2::balance::join<T0>(&mut v0, v4);
            v2 = v2 + 1;
        };
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_reward_claimed(arg6, 0x2::balance::value<T0>(&v0), 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg5, v1, get_market_id(arg2));
        v0
    }

    public fun borrow_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg9);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        let v1 = get_borrow_fee_v2(arg7, v0, arg4, arg5);
        let v2 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::borrow_coin_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5 + v1, arg8, arg9);
        let v3 = &mut v2;
        deposit_borrow_fee<T0>(arg7, v3, v1, v0);
        v2
    }

    public fun borrow_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) : 0x2::balance::Balance<T0> {
        let v0 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg8);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        let v1 = get_borrow_fee_v2(arg7, v0, arg4, arg5);
        let v2 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::borrow_with_account_cap<T0>(arg0, arg1, arg2, arg3, arg4, arg5 + v1, arg8);
        let v3 = &mut v2;
        deposit_borrow_fee<T0>(arg7, v3, v1, v0);
        v2
    }

    public fun borrow_with_account_cap_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg8);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        let v1 = get_borrow_fee_v2(arg7, v0, arg4, arg5);
        let v2 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::borrow_with_account_cap_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5 + v1, arg8, arg9, arg10);
        let v3 = &mut v2;
        deposit_borrow_fee<T0>(arg7, v3, v1, v0);
        v2
    }

    fun calculate_global_index(arg0: &0x2::clock::Clock, arg1: &Rule, arg2: u256, arg3: u256) : u256 {
        let v0 = if (arg1.option == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::option_type_supply()) {
            arg2
        } else {
            assert!(arg1.option == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::option_type_borrow(), 0);
            arg3
        };
        let v1 = v0;
        let v2 = 0x2::clock::timestamp_ms(arg0) - arg1.last_update_at;
        let v3 = if (v2 == 0 || v1 == 0) {
            0
        } else {
            arg1.rate * (v2 as u256) / v1
        };
        let v4 = v3;
        let v5 = 555;
        0x1::debug::print<u64>(&v5);
        0x1::debug::print<u256>(&v1);
        0x1::debug::print<u64>(&v2);
        0x1::debug::print<u256>(&v4);
        arg1.global_index + v4
    }

    fun calculate_user_reward(arg0: &Rule, arg1: u256, arg2: address, arg3: u256, arg4: u256) : u256 {
        let v0 = if (arg0.option == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::option_type_supply()) {
            arg3
        } else {
            assert!(arg0.option == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::option_type_borrow(), 0);
            arg4
        };
        let v1 = v0;
        let v2 = arg1 - get_user_index_by_rule(arg0, arg2);
        let v3 = 444;
        0x1::debug::print<u64>(&v3);
        0x1::debug::print<address>(&arg2);
        0x1::debug::print<u256>(&arg1);
        0x1::debug::print<u256>(&v1);
        let v4 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::ray_math::ray_mul(v1, v2);
        0x1::debug::print<u256>(&v4);
        get_user_total_rewards_by_rule(arg0, arg2) + 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::ray_math::ray_mul(v1, v2)
    }

    public fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut RewardFund<T0>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_claim_reward_by_rules<T0>(arg0, arg2, arg1, arg3, arg4, arg5, 0x2::tx_context::sender(arg6))
    }

    public entry fun claim_reward_entry<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut RewardFund<T0>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(base_claim_reward_by_rules<T0>(arg0, arg2, arg1, arg3, arg4, arg5, 0x2::tx_context::sender(arg6)), arg6), 0x2::tx_context::sender(arg6));
    }

    public fun claim_reward_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut RewardFund<T0>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_claim_reward_by_rules<T0>(arg0, arg2, arg1, arg3, arg4, arg5, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg6))
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
        abort 0
    }

    public(friend) fun create_incentive_v3_with_market_id(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _) = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_storage_market_info(arg0);
        let v3 = 0x2::object::new(arg1);
        let v4 = Incentive{
            id              : v3,
            version         : 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::version::this_version(),
            pools           : 0x2::vec_map::empty<0x1::ascii::String, AssetPool>(),
            borrow_fee_rate : 0,
            fee_balance     : 0x2::bag::new(arg1),
        };
        let v5 = &mut v4;
        init_borrow_fee_fields(v5, arg1);
        let v6 = MARKET_ID_KEY{dummy_field: false};
        0x2::dynamic_field::add<MARKET_ID_KEY, u64>(&mut v4.id, v6, v0);
        0x2::transfer::share_object<Incentive>(v4);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_incentive_created(0x2::tx_context::sender(arg1), 0x2::object::uid_to_address(&v3), v0);
    }

    public(friend) fun create_pool<T0>(arg0: &mut Incentive, arg1: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        version_verification(arg0);
        verify_market_storage_incentive(arg1, arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(v0 == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_coin_type(arg1, arg2), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::invalid_coin_type());
        assert!(!0x2::vec_map::contains<0x1::ascii::String, AssetPool>(&arg0.pools, &v0), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::duplicate_config());
        let v1 = 0x2::object::new(arg3);
        let v2 = AssetPool{
            id              : v1,
            asset           : arg2,
            asset_coin_type : v0,
            rules           : 0x2::vec_map::empty<address, Rule>(),
        };
        0x2::vec_map::insert<0x1::ascii::String, AssetPool>(&mut arg0.pools, v0, v2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_asset_pool_created(0x2::tx_context::sender(arg3), arg2, v0, 0x2::object::uid_to_address(&v1), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg1));
    }

    public(friend) fun create_reward_fund<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun create_reward_fund_with_market_id<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _) = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_storage_market_info(arg0);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v4 = 0x2::object::new(arg1);
        let v5 = RewardFund<T0>{
            id        : v4,
            balance   : 0x2::balance::zero<T0>(),
            coin_type : v3,
        };
        let v6 = MARKET_ID_KEY{dummy_field: false};
        0x2::dynamic_field::add<MARKET_ID_KEY, u64>(&mut v5.id, v6, v0);
        0x2::transfer::share_object<RewardFund<T0>>(v5);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_reward_fund_created(0x2::tx_context::sender(arg1), 0x2::object::uid_to_address(&v4), v3, v0);
    }

    public(friend) fun create_rule<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        version_verification(arg1);
        assert!(arg2 == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::option_type_supply() || arg2 == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::option_type_borrow(), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::invalid_option());
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::vec_map::contains<0x1::ascii::String, AssetPool>(&arg1.pools, &v0), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::pool_not_found());
        let v1 = 0x2::vec_map::get_mut<0x1::ascii::String, AssetPool>(&mut arg1.pools, &v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!contains_rule(v1, arg2, v2), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::duplicate_config());
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
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_rule_created(0x2::tx_context::sender(arg3), v0, v4, arg2, v2, get_market_id(arg1));
    }

    fun deposit_borrow_fee<T0>(arg0: &mut Incentive, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: address) {
        if (arg2 > 0) {
            let v0 = 0x1::type_name::get<T0>();
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_balance, v0)) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balance, v0), 0x2::balance::split<T0>(arg1, arg2));
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balance, v0, 0x2::balance::split<T0>(arg1, arg2));
            };
            0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_borrow_fee_deposited(arg3, 0x1::type_name::into_string(v0), arg2, get_market_id(arg0));
        };
    }

    public(friend) fun deposit_reward_fund<T0>(arg0: &mut RewardFund<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_reward_fund_deposited(0x2::tx_context::sender(arg2), 0x2::object::uid_to_address(&arg0.id), 0x2::balance::value<T0>(&arg1), get_fund_market_id<T0>(arg0));
    }

    public fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg6: &mut Incentive, arg7: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) {
        update_reward_state_by_asset<T0>(arg0, arg6, arg1, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg7));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::deposit_with_account_cap<T0>(arg0, arg1, arg2, arg3, arg4, arg7);
    }

    public entry fun entry_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        let v1 = get_borrow_fee_v2(arg7, v0, arg4, arg5);
        let v2 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::borrow_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5 + v1, arg8);
        let v3 = &mut v2;
        deposit_borrow_fee<T0>(arg7, v3, v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg8), 0x2::tx_context::sender(arg8));
    }

    public entry fun entry_borrow_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        let v1 = get_borrow_fee_v2(arg7, v0, arg4, arg5);
        let v2 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::borrow_coin_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5 + v1, arg8, arg9);
        let v3 = &mut v2;
        deposit_borrow_fee<T0>(arg7, v3, v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun entry_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        update_reward_state_by_asset<T0>(arg0, arg7, arg1, 0x2::tx_context::sender(arg8));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::deposit_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8);
    }

    public entry fun entry_deposit_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: address, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg8: &mut Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        update_reward_state_by_asset<T0>(arg0, arg8, arg1, arg6);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::deposit_on_behalf_of_user<T0>(arg0, arg1, arg2, arg3, arg6, arg4, arg5, arg9);
    }

    public entry fun entry_liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg8: address, arg9: u64, arg10: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg11: &mut Incentive, arg12: &mut 0x2::tx_context::TxContext) {
        update_reward_state_by_asset<T0>(arg0, arg11, arg2, arg8);
        update_reward_state_by_asset<T1>(arg0, arg11, arg2, arg8);
        let v0 = 0x2::tx_context::sender(arg12);
        let (v1, v2) = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::liquidation<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
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

    public entry fun entry_liquidation_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg8: address, arg9: u64, arg10: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg11: &mut Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &mut 0x2::tx_context::TxContext) {
        update_reward_state_by_asset<T0>(arg0, arg11, arg2, arg8);
        update_reward_state_by_asset<T1>(arg0, arg11, arg2, arg8);
        let v0 = 0x2::tx_context::sender(arg13);
        let (v1, v2) = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::liquidation_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
        let v3 = v2;
        let v4 = v1;
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg13), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg13), v0);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
    }

    public entry fun entry_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg8: &mut Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        update_reward_state_by_asset<T0>(arg0, arg8, arg2, 0x2::tx_context::sender(arg9));
        let v0 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::repay_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9);
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg9), 0x2::tx_context::sender(arg9));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public fun entry_repay_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: address, arg8: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg9: &mut Incentive, arg10: &mut 0x2::tx_context::TxContext) {
        update_reward_state_by_asset<T0>(arg0, arg9, arg2, arg7);
        let v0 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::repay_on_behalf_of_user<T0>(arg0, arg1, arg2, arg3, arg4, arg7, arg5, arg6, arg10);
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public entry fun entry_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::withdraw_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8), arg8), v0);
    }

    public entry fun entry_withdraw_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::withdraw_coin_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9), arg9), v0);
    }

    public fun get_balance_value_by_reward_fund<T0>(arg0: &RewardFund<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun get_borrow_fee(arg0: &Incentive, arg1: u64) : u64 {
        if (arg0.borrow_fee_rate > 0) {
            arg1 * arg0.borrow_fee_rate / 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::percentage_benchmark()
        } else {
            0
        }
    }

    public fun get_borrow_fee_v2(arg0: &Incentive, arg1: address, arg2: u8, arg3: u64) : u64 {
        let v0 = ASSET_BORROW_FEES_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<ASSET_BORROW_FEES_KEY, 0x2::table::Table<u8, u64>>(&arg0.id, v0);
        let v2 = arg0.borrow_fee_rate;
        if (0x2::table::contains<u8, u64>(v1, arg2)) {
            v2 = *0x2::table::borrow<u8, u64>(v1, arg2);
        };
        let v3 = USER_BORROW_FEES_KEY{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow<USER_BORROW_FEES_KEY, 0x2::table::Table<address, 0x2::table::Table<u8, u64>>>(&arg0.id, v3);
        if (0x2::table::contains<address, 0x2::table::Table<u8, u64>>(v4, arg1) && 0x2::table::contains<u8, u64>(0x2::table::borrow<address, 0x2::table::Table<u8, u64>>(v4, arg1), arg2)) {
            v2 = *0x2::table::borrow<u8, u64>(0x2::table::borrow<address, 0x2::table::Table<u8, u64>>(v4, arg1), arg2);
        };
        if (v2 > 0) {
            arg3 * v2 / 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::percentage_benchmark()
        } else {
            0
        }
    }

    public fun get_effective_balance(arg0: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg1: u8, arg2: address) : (u256, u256, u256, u256) {
        let (v0, v1) = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_user_balance(arg0, arg1, arg2);
        let (v4, v5) = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_index(arg0, arg1);
        let v6 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::ray_math::ray_mul(v2, v4);
        let v7 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::ray_math::ray_mul(v3, v5);
        let v8 = 0;
        if (v6 > v7) {
            v8 = v6 - v7;
        };
        let v9 = 0;
        if (v7 > v6) {
            v9 = v7 - v6;
        };
        (v8, v9, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::ray_math::ray_mul(v0, v4), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::ray_math::ray_mul(v1, v5))
    }

    public fun get_fund_market_id<T0>(arg0: &RewardFund<T0>) : u64 {
        let v0 = MARKET_ID_KEY{dummy_field: false};
        *0x2::dynamic_field::borrow<MARKET_ID_KEY, u64>(&arg0.id, v0)
    }

    public fun get_market_id(arg0: &Incentive) : u64 {
        let v0 = MARKET_ID_KEY{dummy_field: false};
        *0x2::dynamic_field::borrow<MARKET_ID_KEY, u64>(&arg0.id, v0)
    }

    fun get_mut_rule<T0>(arg0: &mut Incentive, arg1: address) : &mut Rule {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::vec_map::contains<0x1::ascii::String, AssetPool>(&arg0.pools, &v0), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::pool_not_found());
        let v1 = 0x2::vec_map::get_mut<0x1::ascii::String, AssetPool>(&mut arg0.pools, &v0);
        assert!(0x2::vec_map::contains<address, Rule>(&v1.rules, &arg1), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::rule_not_found());
        0x2::vec_map::get_mut<address, Rule>(&mut v1.rules, &arg1)
    }

    public fun get_pool_info(arg0: &AssetPool) : (address, u8, 0x1::ascii::String, &0x2::vec_map::VecMap<address, Rule>) {
        (0x2::object::uid_to_address(&arg0.id), arg0.asset, arg0.asset_coin_type, &arg0.rules)
    }

    public fun get_rule_info(arg0: &Rule) : (address, u8, bool, 0x1::ascii::String, u256, u64, u256, &0x2::table::Table<address, u256>, &0x2::table::Table<address, u256>, &0x2::table::Table<address, u256>) {
        (0x2::object::uid_to_address(&arg0.id), arg0.option, arg0.enable, arg0.reward_coin_type, arg0.rate, arg0.last_update_at, arg0.global_index, &arg0.user_index, &arg0.user_total_rewards, &arg0.user_rewards_claimed)
    }

    public fun get_user_claimable_rewards(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &Incentive, arg3: address) : vector<ClaimableReward> {
        version_verification(arg2);
        verify_market_storage_incentive(arg1, arg2);
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

    public(friend) fun init_borrow_fee_fields(arg0: &mut Incentive, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ASSET_BORROW_FEES_KEY{dummy_field: false};
        0x2::dynamic_field::add<ASSET_BORROW_FEES_KEY, 0x2::table::Table<u8, u64>>(&mut arg0.id, v0, 0x2::table::new<u8, u64>(arg1));
        let v1 = USER_BORROW_FEES_KEY{dummy_field: false};
        0x2::dynamic_field::add<USER_BORROW_FEES_KEY, 0x2::table::Table<address, 0x2::table::Table<u8, u64>>>(&mut arg0.id, v1, 0x2::table::new<address, 0x2::table::Table<u8, u64>>(arg1));
    }

    public fun init_for_main_market(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::StorageAdminCap, arg1: &mut Incentive) {
        let v0 = MARKET_ID_KEY{dummy_field: false};
        0x2::dynamic_field::add<MARKET_ID_KEY, u64>(&mut arg1.id, v0, 0);
    }

    public fun init_fund_for_market<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::StorageAdminCap, arg1: &mut RewardFund<T0>) {
        let v0 = MARKET_ID_KEY{dummy_field: false};
        0x2::dynamic_field::add<MARKET_ID_KEY, u64>(&mut arg1.id, v0, 0);
    }

    public fun liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg8: address, arg9: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg10: &mut Incentive, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        update_reward_state_by_asset<T0>(arg0, arg10, arg2, arg8);
        update_reward_state_by_asset<T1>(arg0, arg10, arg2, arg8);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::liquidation_non_entry<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11)
    }

    public fun liquidation_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg8: address, arg9: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg10: &mut Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        update_reward_state_by_asset<T0>(arg0, arg10, arg2, arg8);
        update_reward_state_by_asset<T1>(arg0, arg10, arg2, arg8);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::liquidation_non_entry_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12)
    }

    fun manual_calculate_global_index(arg0: u64, arg1: &Rule, arg2: u256, arg3: u256) : u256 {
        let v0 = if (arg1.option == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::option_type_supply()) {
            arg2
        } else {
            assert!(arg1.option == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::option_type_borrow(), 0);
            arg3
        };
        let v1 = if (arg0 == 0 || v0 == 0) {
            0
        } else {
            arg1.rate * (arg0 as u256) / v0
        };
        arg1.global_index + v1
    }

    public fun manual_update_reward_state_by_asset<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::StorageAdminCap, arg1: u64, arg2: &mut Incentive, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg4: address) {
        version_verification(arg2);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::vec_map::contains<0x1::ascii::String, AssetPool>(&arg2.pools, &v0)) {
            return
        };
        let v1 = 0x2::vec_map::get_mut<0x1::ascii::String, AssetPool>(&mut arg2.pools, &v0);
        let (v2, v3, v4, v5) = get_effective_balance(arg3, v1.asset, arg4);
        let v6 = 0x2::vec_map::keys<address, Rule>(&v1.rules);
        while (0x1::vector::length<address>(&v6) > 0) {
            let v7 = 0x1::vector::pop_back<address>(&mut v6);
            let v8 = 0x2::vec_map::get_mut<address, Rule>(&mut v1.rules, &v7);
            manual_update_reward_state_by_rule_and_balance(arg1, v8, arg4, v2, v3, v4, v5);
        };
    }

    fun manual_update_reward_state_by_rule_and_balance(arg0: u64, arg1: &mut Rule, arg2: address, arg3: u256, arg4: u256, arg5: u256, arg6: u256) {
        let v0 = manual_calculate_global_index(arg0, arg1, arg5, arg6);
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
        arg1.global_index = v0;
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

    public(friend) fun remove_asset_borrow_fee_rate(arg0: &mut Incentive, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        version_verification(arg0);
        let v0 = ASSET_BORROW_FEES_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ASSET_BORROW_FEES_KEY, 0x2::table::Table<u8, u64>>(&mut arg0.id, v0);
        if (0x2::table::contains<u8, u64>(v1, arg1)) {
            0x2::table::remove<u8, u64>(v1, arg1);
        };
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_asset_borrow_fee_rate_removed(0x2::tx_context::sender(arg2), arg1, @0x0, get_market_id(arg0));
    }

    public(friend) fun remove_user_borrow_fee_rate(arg0: &mut Incentive, arg1: address, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        version_verification(arg0);
        let v0 = USER_BORROW_FEES_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<USER_BORROW_FEES_KEY, 0x2::table::Table<address, 0x2::table::Table<u8, u64>>>(&mut arg0.id, v0);
        if (0x2::table::contains<address, 0x2::table::Table<u8, u64>>(v1, arg1)) {
            let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<u8, u64>>(v1, arg1);
            if (0x2::table::contains<u8, u64>(v2, arg2)) {
                0x2::table::remove<u8, u64>(v2, arg2);
            };
        };
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_asset_borrow_fee_rate_removed(0x2::tx_context::sender(arg3), arg2, arg1, get_market_id(arg0));
    }

    public fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg8: &mut Incentive, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        update_reward_state_by_asset<T0>(arg0, arg8, arg2, 0x2::tx_context::sender(arg9));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::repay_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9)
    }

    public fun repay_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) : 0x2::balance::Balance<T0> {
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg8));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::repay_with_account_cap<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8)
    }

    public(friend) fun set_asset_borrow_fee_rate(arg0: &mut Incentive, arg1: u8, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        version_verification(arg0);
        assert!(arg2 <= 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::percentage_benchmark() / 10, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::invalid_value());
        let v0 = ASSET_BORROW_FEES_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ASSET_BORROW_FEES_KEY, 0x2::table::Table<u8, u64>>(&mut arg0.id, v0);
        if (!0x2::table::contains<u8, u64>(v1, arg1)) {
            0x2::table::add<u8, u64>(v1, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<u8, u64>(v1, arg1) = arg2;
        };
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_asset_borrow_fee_rate_updated(0x2::tx_context::sender(arg3), arg1, @0x0, arg2, get_market_id(arg0));
    }

    public(friend) fun set_borrow_fee_rate(arg0: &mut Incentive, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        version_verification(arg0);
        assert!(arg1 <= 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::percentage_benchmark() / 10, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::invalid_value());
        arg0.borrow_fee_rate = arg1;
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_borrow_fee_rate_updated(0x2::tx_context::sender(arg2), arg1, get_market_id(arg0));
    }

    public(friend) fun set_enable_by_rule_id<T0>(arg0: &mut Incentive, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        version_verification(arg0);
        let v0 = get_mut_rule<T0>(arg0, arg1);
        v0.enable = arg2;
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_reward_state_updated(0x2::tx_context::sender(arg3), arg1, arg2, get_market_id(arg0));
    }

    public(friend) fun set_max_reward_rate_by_rule_id<T0>(arg0: &mut Incentive, arg1: address, arg2: u64, arg3: u64) {
        version_verification(arg0);
        let v0 = get_mut_rule<T0>(arg0, arg1);
        v0.max_rate = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::ray_math::ray_div((arg2 as u256), (arg3 as u256));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_max_reward_rate_updated(arg1, arg2, arg3, get_market_id(arg0));
    }

    public(friend) fun set_reward_rate_by_rule_id<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        version_verification(arg1);
        update_reward_state_by_asset<T0>(arg0, arg1, arg2, @0x0);
        verify_market_storage_incentive(arg2, arg1);
        let v0 = get_market_id(arg1);
        let v1 = 0;
        if (arg5 > 0) {
            v1 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::ray_math::ray_div((arg4 as u256), (arg5 as u256));
        };
        let v2 = get_mut_rule<T0>(arg1, arg3);
        assert!(v2.max_rate == 0 || v1 <= v2.max_rate, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::invalid_value());
        v2.rate = v1;
        v2.last_update_at = 0x2::clock::timestamp_ms(arg0);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_reward_rate_updated(0x2::tx_context::sender(arg6), 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg3, v1, arg4, arg5, v2.last_update_at, v0);
    }

    public(friend) fun set_user_borrow_fee_rate(arg0: &mut Incentive, arg1: address, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        version_verification(arg0);
        assert!(arg3 <= 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::percentage_benchmark() / 10, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::invalid_value());
        let v0 = USER_BORROW_FEES_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<USER_BORROW_FEES_KEY, 0x2::table::Table<address, 0x2::table::Table<u8, u64>>>(&mut arg0.id, v0);
        if (!0x2::table::contains<address, 0x2::table::Table<u8, u64>>(v1, arg1)) {
            0x2::table::add<address, 0x2::table::Table<u8, u64>>(v1, arg1, 0x2::table::new<u8, u64>(arg4));
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<u8, u64>>(v1, arg1);
        if (!0x2::table::contains<u8, u64>(v2, arg2)) {
            0x2::table::add<u8, u64>(v2, arg2, arg3);
        } else {
            *0x2::table::borrow_mut<u8, u64>(v2, arg2) = arg3;
        };
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_asset_borrow_fee_rate_updated(0x2::tx_context::sender(arg4), arg2, arg1, arg3, get_market_id(arg0));
    }

    public fun update_reward_state_by_asset<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: address) {
        version_verification(arg1);
        verify_market_storage_incentive(arg2, arg1);
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

    fun update_reward_state_by_rule(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: u8, arg3: &mut Rule, arg4: address) {
        let (v0, v1, v2, v3) = get_effective_balance(arg1, arg2, arg4);
        update_reward_state_by_rule_and_balance(arg0, arg3, arg4, v0, v1, v2, v3);
    }

    fun update_reward_state_by_rule_and_balance(arg0: &0x2::clock::Clock, arg1: &mut Rule, arg2: address, arg3: u256, arg4: u256, arg5: u256, arg6: u256) {
        let v0 = calculate_global_index(arg0, arg1, arg5, arg6);
        let v1 = calculate_user_reward(arg1, v0, arg2, arg3, arg4);
        if (v1 != 0) {
            let v2 = 666;
            0x1::debug::print<u64>(&v2);
            0x1::debug::print<u256>(&v1);
        };
        if (0x2::table::contains<address, u256>(&arg1.user_index, arg2)) {
            *0x2::table::borrow_mut<address, u256>(&mut arg1.user_index, arg2) = v0;
        } else {
            0x2::table::add<address, u256>(&mut arg1.user_index, arg2, v0);
        };
        if (0x2::table::contains<address, u256>(&arg1.user_total_rewards, arg2)) {
            *0x2::table::borrow_mut<address, u256>(&mut arg1.user_total_rewards, arg2) = v1;
        } else {
            0x2::table::add<address, u256>(&mut arg1.user_total_rewards, arg2, v1);
        };
        arg1.last_update_at = 0x2::clock::timestamp_ms(arg0);
        arg1.global_index = v0;
    }

    public fun verify_market_incentive_funds<T0>(arg0: &Incentive, arg1: &RewardFund<T0>) {
        assert!(get_market_id(arg0) == get_fund_market_id<T0>(arg1), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::unmatched_market_id());
    }

    public fun verify_market_storage_incentive(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg1: &Incentive) {
        assert!(0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg0) == get_market_id(arg1), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::unmatched_market_id());
    }

    public fun version(arg0: &Incentive) : u64 {
        arg0.version
    }

    public(friend) fun version_migrate(arg0: &mut Incentive, arg1: u64) {
        arg0.version = arg1;
    }

    public fun version_verification(arg0: &Incentive) {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::version::pre_check_version(arg0.version);
    }

    public fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, 0x2::tx_context::sender(arg8));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::withdraw_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8)
    }

    public(friend) fun withdraw_borrow_fee<T0>(arg0: &mut Incentive, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        version_verification(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_balance, v0), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::invalid_coin_type());
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balance, v0);
        let v2 = 0x1::u64::min(arg1, 0x2::balance::value<T0>(v1));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_borrow_fee_withdrawn(0x2::tx_context::sender(arg2), 0x1::type_name::into_string(v0), v2, get_market_id(arg0));
        0x2::balance::split<T0>(v1, v2)
    }

    public(friend) fun withdraw_reward_fund<T0>(arg0: &mut RewardFund<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::u64::min(arg1, 0x2::balance::value<T0>(&arg0.balance));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_reward_fund_withdrawn(0x2::tx_context::sender(arg2), 0x2::object::uid_to_address(&arg0.id), v0, get_fund_market_id<T0>(arg0));
        0x2::balance::split<T0>(&mut arg0.balance, v0)
    }

    public fun withdraw_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, 0x2::tx_context::sender(arg9));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::withdraw_coin_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9)
    }

    public fun withdraw_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) : 0x2::balance::Balance<T0> {
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg8));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::withdraw_with_account_cap<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8)
    }

    public fun withdraw_with_account_cap_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        update_reward_state_by_asset<T0>(arg0, arg7, arg2, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg8));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending::withdraw_with_account_cap_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9, arg10)
    }

    // decompiled from Move bytecode v6
}

