module 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::strategy {
    public(friend) fun assert_suilend_coin_type<T0>(arg0: &0x2::object::UID) {
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, 0x1::type_name::TypeName>(arg0, b"al_strategy_suilend_coin_type"), 7001);
        assert!(*0x2::dynamic_field::borrow<vector<u8>, 0x1::type_name::TypeName>(arg0, b"al_strategy_suilend_coin_type") == 0x1::type_name::with_defining_ids<T0>(), 7011);
    }

    fun assert_suilend_market<T0>(arg0: &0x2::object::UID, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_market_id"), 7001);
        assert!(*0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_market_id") == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1), 7007);
    }

    fun assert_suilend_not_sui<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 7006);
    }

    fun assert_suilend_reserve_index<T0, T1>(arg0: &0x2::object::UID, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        assert!(suilend_reserve_index(arg0) == 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg1), 7012);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1);
    }

    public(friend) fun assert_valid_strategy(arg0: u8) {
        assert!(is_valid_strategy(arg0), 7000);
    }

    fun borrow_obligation<T0>(arg0: &0x2::object::UID, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, *0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_obligation_id"))
    }

    fun borrow_obligation_cap<T0>(arg0: &0x2::object::UID) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg0, b"al_strategy_suilend_obligation_cap"), 7008);
        0x2::dynamic_field::borrow<vector<u8>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg0, b"al_strategy_suilend_obligation_cap")
    }

    public(friend) fun claim_suilend_reward<T0, T1, T2>(arg0: &0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_suilend_market<T0>(arg0, arg1);
        assert!(has_suilend_obligation(arg0), 7008);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T2>(arg1, borrow_obligation_cap<T0>(arg0), arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg1), arg3, arg4, arg5)
    }

    public(friend) fun clear_suilend_state<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert_suilend_not_sui<T1>();
        assert_suilend_market<T0>(arg0, arg1);
        assert_suilend_coin_type<T1>(arg0);
        let v0 = 0x2::balance::zero<T1>();
        let v1 = drain_suilend_obligation<T0, T1>(arg0, arg1, arg2, arg3);
        if (0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v1) > 0) {
            0x2::balance::join<T1>(&mut v0, 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, *0x2::dynamic_field::borrow<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx"), arg2, 0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v1, arg3), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg3)));
        } else {
            0x2::balance::destroy_zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v1);
        };
        remove_suilend_commitments(arg0);
        v0
    }

    public(friend) fun clear_suilend_state_sui<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_suilend_market<T0>(arg0, arg1);
        assert_suilend_coin_type<0x2::sui::SUI>(arg0);
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = drain_suilend_obligation<T0, 0x2::sui::SUI>(arg0, arg1, arg3, arg4);
        if (0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(&v1) > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v0, redeem_suilend_ctokens_sui<T0>(arg1, arg2, *0x2::dynamic_field::borrow<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx"), arg3, v1, arg4));
        } else {
            0x2::balance::destroy_zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(v1);
        };
        remove_suilend_commitments(arg0);
        v0
    }

    fun committed_coin_type_is<T0>(arg0: &0x2::object::UID) : bool {
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, 0x1::type_name::TypeName>(arg0, b"al_strategy_suilend_coin_type")) {
            return false
        };
        *0x2::dynamic_field::borrow<vector<u8>, 0x1::type_name::TypeName>(arg0, b"al_strategy_suilend_coin_type") == 0x1::type_name::with_defining_ids<T0>()
    }

    fun drain_suilend_obligation<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        let v0 = 0x2::balance::zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>();
        if (!has_suilend_obligation(arg0)) {
            return v0
        };
        let v1 = obligation_ctoken_amount<T0, T1>(arg0, arg1);
        if (v1 > 0) {
            let v2 = withdraw_obligation_ctokens<T0, T1>(arg0, arg1, arg2, *0x2::dynamic_field::borrow<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx"), v1, arg3);
            0x2::balance::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut v0, 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v2));
        };
        assert!(0x1::vector::is_empty<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(borrow_obligation<T0>(arg0, arg1))), 7010);
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(0x2::dynamic_field::remove<vector<u8>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg0, b"al_strategy_suilend_obligation_cap"), @0x0);
        0x2::dynamic_field::remove<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_obligation_id");
        v0
    }

    public(friend) fun get_suilend_supplied_value<T0, T1>(arg0: &0x2::object::UID, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : u64 {
        if (!has_suilend_obligation(arg0)) {
            return 0
        };
        assert_suilend_market<T0>(arg0, arg1);
        assert_suilend_coin_type<T1>(arg0);
        let v0 = obligation_ctoken_amount<T0, T1>(arg0, arg1);
        if (v0 == 0) {
            return 0
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1), arg2)))
    }

    public(friend) fun has_suilend_obligation(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_obligation_id")
    }

    fun has_suilend_state(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx")
    }

    public(friend) fun init_suilend_state<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64) {
        assert!(!0x2::dynamic_field::exists_with_type<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx"), 7003);
        0x2::dynamic_field::add<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx", arg2);
        0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_market_id", 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1));
        0x2::dynamic_field::add<vector<u8>, 0x1::type_name::TypeName>(arg0, b"al_strategy_suilend_coin_type", 0x1::type_name::with_defining_ids<T1>());
    }

    public fun is_valid_strategy(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    fun obligation_ctoken_amount<T0, T1>(arg0: &0x2::object::UID, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        if (!has_suilend_obligation(arg0)) {
            return 0
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, *0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_obligation_id")))
    }

    public(friend) fun open_suilend_obligation<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_suilend_state(arg0), 7001);
        assert_suilend_market<T0>(arg0, arg1);
        assert_suilend_coin_type<T1>(arg0);
        assert_suilend_reserve_index<T0, T1>(arg0, arg1);
        assert!(!has_suilend_obligation(arg0), 7009);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg1, arg2);
        0x2::dynamic_field::add<vector<u8>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg0, b"al_strategy_suilend_obligation_cap", v0);
        0x2::dynamic_field::add<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_obligation_id", 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v0));
    }

    fun pull_secondary_ctokens<T0, T1>(arg0: &0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>) {
        assert!(has_suilend_obligation(arg0), 7008);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(borrow_obligation<T0>(arg0, arg1));
        assert!(v0 > 0, 7002);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg1);
        (v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, v1, borrow_obligation_cap<T0>(arg0), arg2, v0, arg3))
    }

    fun redeem_suilend_ctokens_sui<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg2, arg3, 0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(arg4, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, arg2, &v0, arg1, arg5);
        0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg2, v0, arg5))
    }

    fun remove_suilend_commitments(arg0: &mut 0x2::object::UID) {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx")) {
            0x2::dynamic_field::remove<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx");
        };
        if (0x2::dynamic_field::exists_with_type<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_market_id")) {
            0x2::dynamic_field::remove<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_market_id");
        };
        if (0x2::dynamic_field::exists_with_type<vector<u8>, 0x1::type_name::TypeName>(arg0, b"al_strategy_suilend_coin_type")) {
            0x2::dynamic_field::remove<vector<u8>, 0x1::type_name::TypeName>(arg0, b"al_strategy_suilend_coin_type");
        };
    }

    public fun strategy_none() : u8 {
        0
    }

    public fun strategy_suilend() : u8 {
        1
    }

    fun suilend_ctokens_for_target<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg0), arg1);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), v0));
        let v2 = v1;
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v1), v0)) < arg2) {
            v2 = v1 + 1;
        };
        v2
    }

    public(friend) fun suilend_market_id(arg0: &0x2::object::UID) : 0x2::object::ID {
        *0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_market_id")
    }

    public(friend) fun suilend_obligation_id(arg0: &0x2::object::UID) : 0x2::object::ID {
        assert!(has_suilend_obligation(arg0), 7008);
        *0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(arg0, b"al_strategy_suilend_obligation_id")
    }

    public(friend) fun suilend_reserve_index(arg0: &0x2::object::UID) : u64 {
        assert!(has_suilend_state(arg0), 7001);
        *0x2::dynamic_field::borrow<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx")
    }

    public(friend) fun supply_to_suilend<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert_suilend_market<T0>(arg0, arg1);
        assert_suilend_coin_type<T1>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0, 7002);
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx"), 7001);
        let v1 = *0x2::dynamic_field::borrow<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx");
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, v1, borrow_obligation_cap<T0>(arg0), arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, v1, arg2, arg3, arg4), arg4);
        v0
    }

    public(friend) fun withdraw_from_suilend<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert_suilend_not_sui<T1>();
        assert_suilend_market<T0>(arg0, arg1);
        assert_suilend_coin_type<T1>(arg0);
        assert!(arg3 > 0, 7002);
        assert!(has_suilend_state(arg0), 7001);
        assert!(has_suilend_obligation(arg0), 7008);
        let v0 = *0x2::dynamic_field::borrow<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx");
        let v1 = suilend_ctokens_for_target<T0, T1>(arg1, arg2, arg3);
        let v2 = withdraw_obligation_ctokens<T0, T1>(arg0, arg1, arg2, v0, v1, arg4);
        let v3 = 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, v0, arg2, v2, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg4));
        assert!(0x2::balance::value<T1>(&v3) >= arg3, 7004);
        v3
    }

    public(friend) fun withdraw_from_suilend_sui<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_suilend_market<T0>(arg0, arg1);
        assert_suilend_coin_type<0x2::sui::SUI>(arg0);
        assert!(arg4 > 0, 7002);
        assert!(has_suilend_state(arg0), 7001);
        assert!(has_suilend_obligation(arg0), 7008);
        let v0 = *0x2::dynamic_field::borrow<vector<u8>, u64>(arg0, b"al_strategy_suilend_reserve_idx");
        let v1 = suilend_ctokens_for_target<T0, 0x2::sui::SUI>(arg1, arg3, arg4);
        let v2 = withdraw_obligation_ctokens<T0, 0x2::sui::SUI>(arg0, arg1, arg3, v0, v1, arg5);
        let v3 = redeem_suilend_ctokens_sui<T0>(arg1, arg2, v0, arg3, 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(v2), arg5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v3) >= arg4, 7004);
        v3
    }

    fun withdraw_obligation_ctokens<T0, T1>(arg0: &0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        assert!(arg4 <= obligation_ctoken_amount<T0, T1>(arg0, arg1), 7005);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg3, borrow_obligation_cap<T0>(arg0), arg2, arg4, arg5)
    }

    public(friend) fun withdraw_secondary_collateral<T0, T1>(arg0: &0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_suilend_market<T0>(arg0, arg1);
        assert!(!committed_coin_type_is<T1>(arg0), 7013);
        assert_suilend_not_sui<T1>();
        let (v0, v1) = pull_secondary_ctokens<T0, T1>(arg0, arg1, arg2, arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, v0, arg2, v1, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg3)
    }

    public(friend) fun withdraw_secondary_collateral_sui<T0>(arg0: &0x2::object::UID, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_suilend_market<T0>(arg0, arg1);
        assert!(!committed_coin_type_is<0x2::sui::SUI>(arg0), 7013);
        let (v0, v1) = pull_secondary_ctokens<T0, 0x2::sui::SUI>(arg0, arg1, arg3, arg4);
        let v2 = redeem_suilend_ctokens_sui<T0>(arg1, arg2, v0, arg3, 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(v1), arg4);
        0x2::coin::from_balance<0x2::sui::SUI>(v2, arg4)
    }

    // decompiled from Move bytecode v7
}

