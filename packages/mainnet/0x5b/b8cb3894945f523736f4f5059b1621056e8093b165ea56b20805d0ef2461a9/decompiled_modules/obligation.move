module 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::obligation {
    struct Obligation<phantom T0> has store, key {
        id: 0x2::object::UID,
        lending_market_id: 0x2::object::ID,
        deposits: vector<Deposit>,
        borrows: vector<Borrow>,
        deposited_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        allowed_borrow_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        unhealthy_borrow_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        super_unhealthy_borrow_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        unweighted_borrowed_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        weighted_borrowed_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        weighted_borrowed_value_upper_bound_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        borrowing_isolated_asset: bool,
        user_reward_managers: vector<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>,
        bad_debt_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        closable: bool,
    }

    struct Deposit has store {
        coin_type: 0x1::type_name::TypeName,
        reserve_array_index: u64,
        deposited_ctoken_amount: u64,
        market_value: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        user_reward_manager_index: u64,
        attributed_borrow_value: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
    }

    struct Borrow has store {
        coin_type: 0x1::type_name::TypeName,
        reserve_array_index: u64,
        borrowed_amount: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        cumulative_borrow_rate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        market_value: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        user_reward_manager_index: u64,
    }

    struct ExistStaleOracles {
        dummy_field: bool,
    }

    struct ObligationDataEvent has copy, drop {
        lending_market_id: address,
        obligation_id: address,
        deposits: vector<DepositRecord>,
        borrows: vector<BorrowRecord>,
        deposited_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        allowed_borrow_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        unhealthy_borrow_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        super_unhealthy_borrow_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        unweighted_borrowed_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        weighted_borrowed_value_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        weighted_borrowed_value_upper_bound_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        borrowing_isolated_asset: bool,
        bad_debt_usd: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        closable: bool,
    }

    struct DepositRecord has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        reserve_array_index: u64,
        deposited_ctoken_amount: u64,
        market_value: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        user_reward_manager_index: u64,
        attributed_borrow_value: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
    }

    struct BorrowRecord has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        reserve_array_index: u64,
        borrowed_amount: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        cumulative_borrow_rate: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        market_value: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal,
        user_reward_manager_index: u64,
    }

    public(friend) fun borrow<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = find_or_add_borrow<T0>(arg0, arg1, arg2);
        assert!(0x1::vector::length<Borrow>(&arg0.borrows) <= 5, 6);
        assert!(find_deposit_index<T0>(arg0, arg1) == 0x1::vector::length<Deposit>(&arg0.deposits), 8);
        let v1 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.borrows, v0);
        v1.borrowed_amount = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(v1.borrowed_amount, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg3));
        let v2 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::market_value<T0>(arg1, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg3));
        v1.market_value = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(v1.market_value, v2);
        arg0.unweighted_borrowed_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.unweighted_borrowed_value_usd, v2);
        arg0.weighted_borrowed_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.weighted_borrowed_value_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(v2, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_weight(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1))));
        arg0.weighted_borrowed_value_upper_bound_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.weighted_borrowed_value_upper_bound_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::market_value_upper_bound<T0>(arg1, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg3)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_weight(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1))));
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::change_user_reward_manager_share(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::borrows_pool_reward_manager_mut<T0>(arg1), 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1.user_reward_manager_index), liability_shares(v1), arg2);
        assert!(is_healthy<T0>(arg0), 1);
        if (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::isolated(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1)) || arg0.borrowing_isolated_asset) {
            assert!(0x1::vector::length<Borrow>(&arg0.borrows) == 1, 4);
        };
        log_obligation_data<T0>(arg0);
    }

    public(friend) fun claim_rewards<T0, T1>(arg0: &mut Obligation<T0>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::PoolRewardManager, arg2: &0x2::clock::Clock, arg3: u64) : 0x2::balance::Balance<T1> {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::claim_rewards<T1>(arg1, 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, find_user_reward_manager_index<T0>(arg0, arg1)), arg2, arg3)
    }

    public fun allowed_borrow_value_usd<T0>(arg0: &Obligation<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.allowed_borrow_value_usd
    }

    public(friend) fun assert_no_stale_oracles(arg0: 0x1::option::Option<ExistStaleOracles>) {
        assert!(0x1::option::is_none<ExistStaleOracles>(&arg0), 9);
        0x1::option::destroy_none<ExistStaleOracles>(arg0);
    }

    public fun borrow_borrowed_amount(arg0: &Borrow) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.borrowed_amount
    }

    public fun borrow_coin_type(arg0: &Borrow) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun borrow_cumulative_borrow_rate(arg0: &Borrow) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.cumulative_borrow_rate
    }

    public fun borrow_market_value(arg0: &Borrow) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.market_value
    }

    public fun borrow_reserve_array_index(arg0: &Borrow) : u64 {
        arg0.reserve_array_index
    }

    public fun borrow_user_reward_manager_index(arg0: &Borrow) : u64 {
        arg0.user_reward_manager_index
    }

    public fun borrowed_amount<T0, T1>(arg0: &Obligation<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            let v1 = 0x1::vector::borrow<Borrow>(&arg0.borrows, v0);
            if (v1.coin_type == 0x1::type_name::get<T1>()) {
                return v1.borrowed_amount
            };
            v0 = v0 + 1;
        };
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0)
    }

    public fun borrowing_isolated_asset<T0>(arg0: &Obligation<T0>) : bool {
        arg0.borrowing_isolated_asset
    }

    public fun borrows<T0>(arg0: &Obligation<T0>) : &vector<Borrow> {
        &arg0.borrows
    }

    fun compound_debt<T0>(arg0: &mut Borrow, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>) {
        let v0 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::cumulative_borrow_rate<T0>(arg1);
        arg0.borrowed_amount = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(arg0.borrowed_amount, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(v0, arg0.cumulative_borrow_rate));
        arg0.cumulative_borrow_rate = v0;
    }

    public(friend) fun create_obligation<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Obligation<T0> {
        Obligation<T0>{
            id                                      : 0x2::object::new(arg1),
            lending_market_id                       : arg0,
            deposits                                : 0x1::vector::empty<Deposit>(),
            borrows                                 : 0x1::vector::empty<Borrow>(),
            deposited_value_usd                     : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            allowed_borrow_value_usd                : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            unhealthy_borrow_value_usd              : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            super_unhealthy_borrow_value_usd        : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            unweighted_borrowed_value_usd           : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            weighted_borrowed_value_usd             : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            weighted_borrowed_value_upper_bound_usd : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            borrowing_isolated_asset                : false,
            user_reward_managers                    : 0x1::vector::empty<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(),
            bad_debt_usd                            : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            closable                                : false,
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = find_or_add_deposit<T0>(arg0, arg1, arg2);
        assert!(0x1::vector::length<Deposit>(&arg0.deposits) <= 5, 5);
        assert!(find_borrow_index<T0>(arg0, arg1) == 0x1::vector::length<Borrow>(&arg0.borrows), 8);
        let v1 = 0x1::vector::borrow_mut<Deposit>(&mut arg0.deposits, v0);
        v1.deposited_ctoken_amount = v1.deposited_ctoken_amount + arg3;
        let v2 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::ctoken_market_value<T0>(arg1, arg3);
        v1.market_value = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(v1.market_value, v2);
        arg0.deposited_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.deposited_value_usd, v2);
        arg0.allowed_borrow_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.allowed_borrow_value_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::ctoken_market_value_lower_bound<T0>(arg1, arg3), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::open_ltv(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1))));
        arg0.unhealthy_borrow_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.unhealthy_borrow_value_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(v2, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::close_ltv(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1))));
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::change_user_reward_manager_share(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::deposits_pool_reward_manager_mut<T0>(arg1), 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1.user_reward_manager_index), v1.deposited_ctoken_amount, arg2);
        log_obligation_data<T0>(arg0);
    }

    public fun deposit_coin_type(arg0: &Deposit) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun deposit_deposited_ctoken_amount(arg0: &Deposit) : u64 {
        arg0.deposited_ctoken_amount
    }

    public fun deposit_market_value(arg0: &Deposit) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.market_value
    }

    public fun deposit_reserve_array_index(arg0: &Deposit) : u64 {
        arg0.reserve_array_index
    }

    public fun deposit_user_reward_manager_index(arg0: &Deposit) : u64 {
        arg0.user_reward_manager_index
    }

    public fun deposited_ctoken_amount<T0, T1>(arg0: &Obligation<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            let v1 = 0x1::vector::borrow<Deposit>(&arg0.deposits, v0);
            if (v1.coin_type == 0x1::type_name::get<T1>()) {
                return v1.deposited_ctoken_amount
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun deposited_value_usd<T0>(arg0: &Obligation<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.deposited_value_usd
    }

    public fun deposits<T0>(arg0: &Obligation<T0>) : &vector<Deposit> {
        &arg0.deposits
    }

    public(friend) fun find_borrow<T0>(arg0: &Obligation<T0>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>) : &Borrow {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Borrow>(&arg0.borrows), 2);
        0x1::vector::borrow<Borrow>(&arg0.borrows, v0)
    }

    fun find_borrow_index<T0>(arg0: &Obligation<T0>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            if (0x1::vector::borrow<Borrow>(&arg0.borrows, v0).reserve_array_index == 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::array_index<T0>(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    public(friend) fun find_deposit<T0>(arg0: &Obligation<T0>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>) : &Deposit {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit>(&arg0.deposits), 3);
        0x1::vector::borrow<Deposit>(&arg0.deposits, v0)
    }

    fun find_deposit_index<T0>(arg0: &Obligation<T0>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            if (0x1::vector::borrow<Deposit>(&arg0.deposits, v0).reserve_array_index == 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::array_index<T0>(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_deposit_index_by_reserve_array_index<T0>(arg0: &Obligation<T0>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            if (0x1::vector::borrow<Deposit>(&arg0.deposits, v0).reserve_array_index == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_or_add_borrow<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            return v0
        };
        let v1 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::borrows_pool_reward_manager_mut<T0>(arg1);
        let (v2, _) = find_or_add_user_reward_manager<T0>(arg0, v1, arg2);
        let v4 = Borrow{
            coin_type                 : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::coin_type<T0>(arg1),
            reserve_array_index       : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::array_index<T0>(arg1),
            borrowed_amount           : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            cumulative_borrow_rate    : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::cumulative_borrow_rate<T0>(arg1),
            market_value              : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            user_reward_manager_index : v2,
        };
        0x1::vector::push_back<Borrow>(&mut arg0.borrows, v4);
        0x1::vector::length<Borrow>(&arg0.borrows) - 1
    }

    fun find_or_add_deposit<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            return v0
        };
        let v1 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::deposits_pool_reward_manager_mut<T0>(arg1);
        let (v2, _) = find_or_add_user_reward_manager<T0>(arg0, v1, arg2);
        let v4 = Deposit{
            coin_type                 : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::coin_type<T0>(arg1),
            reserve_array_index       : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::array_index<T0>(arg1),
            deposited_ctoken_amount   : 0,
            market_value              : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
            user_reward_manager_index : v2,
            attributed_borrow_value   : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0),
        };
        0x1::vector::push_back<Deposit>(&mut arg0.deposits, v4);
        0x1::vector::length<Deposit>(&arg0.deposits) - 1
    }

    fun find_or_add_user_reward_manager<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::PoolRewardManager, arg2: &0x2::clock::Clock) : (u64, &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager) {
        let v0 = find_user_reward_manager_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&arg0.user_reward_managers)) {
            return (v0, 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v0))
        };
        0x1::vector::push_back<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::new_user_reward_manager(arg1, arg2));
        let v1 = 0x1::vector::length<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&arg0.user_reward_managers);
        (v1 - 1, 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1 - 1))
    }

    public(friend) fun find_user_reward_manager_index<T0>(arg0: &Obligation<T0>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::PoolRewardManager) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&arg0.user_reward_managers)) {
            if (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::pool_reward_manager_id(0x1::vector::borrow<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&arg0.user_reward_managers, v0)) == 0x2::object::id<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::PoolRewardManager>(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    public(friend) fun forgive<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        assert!(is_forgivable<T0>(arg0), 7);
        repay<T0>(arg0, arg1, arg2, arg3)
    }

    public fun is_forgivable<T0>(arg0: &Obligation<T0>) : bool {
        0x1::vector::length<Deposit>(&arg0.deposits) == 0
    }

    public fun is_healthy<T0>(arg0: &Obligation<T0>) : bool {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::le(arg0.weighted_borrowed_value_upper_bound_usd, arg0.allowed_borrow_value_usd)
    }

    public fun is_liquidatable<T0>(arg0: &Obligation<T0>) : bool {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::gt(arg0.weighted_borrowed_value_usd, arg0.unhealthy_borrow_value_usd)
    }

    public(friend) fun is_looped<T0>(arg0: &Obligation<T0>) : bool {
        let v0 = vector[1, 2, 5, 7, 19, 20, 3, 9];
        let v1 = vector[vector[2, 5, 7, 19, 20], vector[1, 5, 7, 19, 20], vector[1, 2, 7, 19, 20], vector[1, 2, 5, 19, 20], vector[1, 2, 5, 7, 20], vector[1, 2, 5, 7, 19], vector[9], vector[3]];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            let v3 = 0x1::vector::borrow<Borrow>(&arg0.borrows, v2);
            if (find_deposit_index_by_reserve_array_index<T0>(arg0, v3.reserve_array_index) < 0x1::vector::length<Deposit>(&arg0.deposits)) {
                return true
            };
            let (v4, v5) = 0x1::vector::index_of<u64>(&v0, &v3.reserve_array_index);
            if (v4) {
                let v6 = 0x1::vector::borrow<vector<u64>>(&v1, v5);
                let v7 = 0;
                while (v7 < 0x1::vector::length<u64>(v6)) {
                    if (find_deposit_index_by_reserve_array_index<T0>(arg0, *0x1::vector::borrow<u64>(v6, v7)) < 0x1::vector::length<Deposit>(&arg0.deposits)) {
                        return true
                    };
                    v7 = v7 + 1;
                };
            };
            v2 = v2 + 1;
        };
        false
    }

    fun liability_shares(arg0: &Borrow) : u64 {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(arg0.borrowed_amount, arg0.cumulative_borrow_rate))
    }

    public(friend) fun liquidate<T0>(arg0: &mut Obligation<T0>, arg1: &mut vector<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64) : (u64, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) {
        assert!(is_liquidatable<T0>(arg0), 0);
        let v0 = 0x1::vector::borrow<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(arg1, arg2);
        let v1 = 0x1::vector::borrow<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(arg1, arg3);
        let v2 = find_borrow<T0>(arg0, v0);
        let v3 = find_deposit<T0>(arg0, v1);
        let v4 = if (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::le(v2.market_value, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(1))) {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::min(v2.borrowed_amount, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg5))
        } else {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::min(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::min(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(arg0.weighted_borrowed_value_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from_percent(20)), v2.market_value), v2.market_value), v2.borrowed_amount), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg5))
        };
        let v5 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::market_value<T0>(v0, v4), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(1), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::liquidation_bonus(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(v1)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::protocol_liquidation_fee(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(v1)))));
        let (v6, v7) = if (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::lt(v3.market_value, v5)) {
            (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(v4, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(v3.market_value, v5)), v3.deposited_ctoken_amount)
        } else {
            (v4, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(v3.deposited_ctoken_amount), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(v5, v3.market_value))))
        };
        let v8 = 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(arg1, arg2);
        repay<T0>(arg0, v8, arg4, v6);
        let v9 = 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(arg1, arg3);
        withdraw_unchecked<T0>(arg0, v9, arg4, v7);
        log_obligation_data<T0>(arg0);
        (v7, v6)
    }

    fun log_obligation_data<T0>(arg0: &Obligation<T0>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<DepositRecord>();
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            let v2 = 0x1::vector::borrow<Deposit>(&arg0.deposits, v0);
            let v3 = DepositRecord{
                coin_type                 : v2.coin_type,
                reserve_array_index       : v2.reserve_array_index,
                deposited_ctoken_amount   : v2.deposited_ctoken_amount,
                market_value              : v2.market_value,
                user_reward_manager_index : v2.user_reward_manager_index,
                attributed_borrow_value   : v2.attributed_borrow_value,
            };
            0x1::vector::push_back<DepositRecord>(&mut v1, v3);
            v0 = v0 + 1;
        };
        let v4 = 0;
        let v5 = 0x1::vector::empty<BorrowRecord>();
        while (v4 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            let v6 = 0x1::vector::borrow<Borrow>(&arg0.borrows, v4);
            let v7 = BorrowRecord{
                coin_type                 : v6.coin_type,
                reserve_array_index       : v6.reserve_array_index,
                borrowed_amount           : v6.borrowed_amount,
                cumulative_borrow_rate    : v6.cumulative_borrow_rate,
                market_value              : v6.market_value,
                user_reward_manager_index : v6.user_reward_manager_index,
            };
            0x1::vector::push_back<BorrowRecord>(&mut v5, v7);
            v4 = v4 + 1;
        };
        let v8 = ObligationDataEvent{
            lending_market_id                       : 0x2::object::id_to_address(&arg0.lending_market_id),
            obligation_id                           : 0x2::object::uid_to_address(&arg0.id),
            deposits                                : v1,
            borrows                                 : v5,
            deposited_value_usd                     : arg0.deposited_value_usd,
            allowed_borrow_value_usd                : arg0.allowed_borrow_value_usd,
            unhealthy_borrow_value_usd              : arg0.unhealthy_borrow_value_usd,
            super_unhealthy_borrow_value_usd        : arg0.super_unhealthy_borrow_value_usd,
            unweighted_borrowed_value_usd           : arg0.unweighted_borrowed_value_usd,
            weighted_borrowed_value_usd             : arg0.weighted_borrowed_value_usd,
            weighted_borrowed_value_upper_bound_usd : arg0.weighted_borrowed_value_upper_bound_usd,
            borrowing_isolated_asset                : arg0.borrowing_isolated_asset,
            bad_debt_usd                            : arg0.bad_debt_usd,
            closable                                : arg0.closable,
        };
        0x2::event::emit<ObligationDataEvent>(v8);
    }

    public(friend) fun max_borrow_amount<T0>(arg0: &Obligation<T0>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>) : u64 {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::usd_to_token_amount_lower_bound<T0>(arg1, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(arg0.allowed_borrow_value_usd, arg0.weighted_borrowed_value_upper_bound_usd), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_weight(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1)))))
    }

    public(friend) fun max_withdraw_amount<T0>(arg0: &Obligation<T0>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>) : u64 {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit>(&arg0.deposits), 3);
        if (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::open_ltv(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1)) == 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0) || 0x1::vector::length<Borrow>(&arg0.borrows) == 0) {
            return 0x1::vector::borrow<Deposit>(&arg0.deposits, v0).deposited_ctoken_amount
        };
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::min(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x1::vector::borrow<Deposit>(&arg0.deposits, v0).deposited_ctoken_amount), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::usd_to_token_amount_upper_bound<T0>(arg1, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(arg0.allowed_borrow_value_usd, arg0.weighted_borrowed_value_upper_bound_usd), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::open_ltv(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1)))), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::ctoken_ratio<T0>(arg1))))
    }

    public(friend) fun refresh<T0>(arg0: &mut Obligation<T0>, arg1: &mut vector<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>, arg2: &0x2::clock::Clock) : 0x1::option::Option<ExistStaleOracles> {
        let v0 = false;
        let v1 = 0;
        let v2 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0);
        let v3 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0);
        let v4 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0);
        while (v1 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            let v5 = 0x1::vector::borrow_mut<Deposit>(&mut arg0.deposits, v1);
            let v6 = 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(arg1, v5.reserve_array_index);
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::compound_interest<T0>(v6, arg2);
            if (!0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::is_price_fresh<T0>(v6, arg2)) {
                v0 = true;
            };
            let v7 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::ctoken_market_value<T0>(v6, v5.deposited_ctoken_amount);
            v5.market_value = v7;
            v2 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(v2, v7);
            v3 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(v3, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::ctoken_market_value_lower_bound<T0>(v6, v5.deposited_ctoken_amount), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::open_ltv(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(v6))));
            v4 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(v4, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(v7, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::close_ltv(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(v6))));
            v1 = v1 + 1;
        };
        arg0.deposited_value_usd = v2;
        arg0.allowed_borrow_value_usd = v3;
        arg0.unhealthy_borrow_value_usd = v4;
        let v8 = 0;
        let v9 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0);
        let v10 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0);
        let v11 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0);
        let v12 = false;
        while (v8 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            let v13 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.borrows, v8);
            let v14 = 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(arg1, v13.reserve_array_index);
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::compound_interest<T0>(v14, arg2);
            if (!0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::is_price_fresh<T0>(v14, arg2)) {
                v0 = true;
            };
            compound_debt<T0>(v13, v14);
            let v15 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::market_value<T0>(v14, v13.borrowed_amount);
            v13.market_value = v15;
            v9 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(v9, v15);
            v10 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(v10, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(v15, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_weight(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(v14))));
            v11 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(v11, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::market_value_upper_bound<T0>(v14, v13.borrowed_amount), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_weight(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(v14))));
            if (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::isolated(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(v14))) {
                v12 = true;
            };
            v8 = v8 + 1;
        };
        arg0.unweighted_borrowed_value_usd = v9;
        arg0.weighted_borrowed_value_usd = v10;
        arg0.weighted_borrowed_value_upper_bound_usd = v11;
        arg0.borrowing_isolated_asset = v12;
        if (v0) {
            let v16 = ExistStaleOracles{dummy_field: false};
            return 0x1::option::some<ExistStaleOracles>(v16)
        };
        0x1::option::none<ExistStaleOracles>()
    }

    public(friend) fun repay<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Borrow>(&arg0.borrows), 2);
        let v1 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.borrows, v0);
        let v2 = v1.borrowed_amount;
        compound_debt<T0>(v1, arg1);
        let v3 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::min(arg3, v1.borrowed_amount);
        let v4 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(v1.borrowed_amount, v2);
        v1.borrowed_amount = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(v1.borrowed_amount, v3);
        if (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::le(v4, v3)) {
            let v5 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(v3, v4);
            let v6 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::market_value<T0>(arg1, v5);
            v1.market_value = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(v1.market_value, v6);
            arg0.unweighted_borrowed_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(arg0.unweighted_borrowed_value_usd, v6);
            arg0.weighted_borrowed_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(arg0.weighted_borrowed_value_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(v6, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_weight(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1))));
            arg0.weighted_borrowed_value_upper_bound_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(arg0.weighted_borrowed_value_upper_bound_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::market_value_upper_bound<T0>(arg1, v5), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_weight(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1))));
        } else {
            let v7 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::saturating_sub(v4, v3);
            let v8 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::market_value<T0>(arg1, v7);
            v1.market_value = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(v1.market_value, v8);
            arg0.unweighted_borrowed_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.unweighted_borrowed_value_usd, v8);
            arg0.weighted_borrowed_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.weighted_borrowed_value_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(v8, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_weight(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1))));
            arg0.weighted_borrowed_value_upper_bound_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(arg0.weighted_borrowed_value_upper_bound_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::market_value_upper_bound<T0>(arg1, v7), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::borrow_weight(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1))));
        };
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::change_user_reward_manager_share(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::borrows_pool_reward_manager_mut<T0>(arg1), 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1.user_reward_manager_index), liability_shares(v1), arg2);
        if (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::eq(v1.borrowed_amount, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0))) {
            let Borrow {
                coin_type                 : _,
                reserve_array_index       : _,
                borrowed_amount           : _,
                cumulative_borrow_rate    : _,
                market_value              : _,
                user_reward_manager_index : _,
            } = 0x1::vector::remove<Borrow>(&mut arg0.borrows, v0);
        };
        log_obligation_data<T0>(arg0);
        v3
    }

    public fun unhealthy_borrow_value_usd<T0>(arg0: &Obligation<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.unhealthy_borrow_value_usd
    }

    public fun unweighted_borrowed_value_usd<T0>(arg0: &Obligation<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.unweighted_borrowed_value_usd
    }

    public fun user_reward_managers<T0>(arg0: &Obligation<T0>) : &vector<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager> {
        &arg0.user_reward_managers
    }

    public fun weighted_borrowed_value_upper_bound_usd<T0>(arg0: &Obligation<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.weighted_borrowed_value_upper_bound_usd
    }

    public fun weighted_borrowed_value_usd<T0>(arg0: &Obligation<T0>) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        arg0.weighted_borrowed_value_usd
    }

    public(friend) fun withdraw<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<ExistStaleOracles>) {
        if (0x1::option::is_some<ExistStaleOracles>(&arg4) && 0x1::vector::is_empty<Borrow>(&arg0.borrows)) {
            let ExistStaleOracles {  } = 0x1::option::destroy_some<ExistStaleOracles>(arg4);
        } else {
            assert_no_stale_oracles(arg4);
        };
        withdraw_unchecked<T0>(arg0, arg1, arg2, arg3);
        assert!(is_healthy<T0>(arg0), 1);
        log_obligation_data<T0>(arg0);
    }

    fun withdraw_unchecked<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit>(&arg0.deposits), 3);
        let v1 = 0x1::vector::borrow_mut<Deposit>(&mut arg0.deposits, v0);
        let v2 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::ctoken_market_value<T0>(arg1, arg3);
        v1.market_value = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(v1.market_value, v2);
        v1.deposited_ctoken_amount = v1.deposited_ctoken_amount - arg3;
        arg0.deposited_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(arg0.deposited_value_usd, v2);
        arg0.allowed_borrow_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(arg0.allowed_borrow_value_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::ctoken_market_value_lower_bound<T0>(arg1, arg3), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::open_ltv(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1))));
        arg0.unhealthy_borrow_value_usd = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(arg0.unhealthy_borrow_value_usd, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(v2, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve_config::close_ltv(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::config<T0>(arg1))));
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::change_user_reward_manager_share(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::deposits_pool_reward_manager_mut<T0>(arg1), 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1.user_reward_manager_index), v1.deposited_ctoken_amount, arg2);
        if (v1.deposited_ctoken_amount == 0) {
            let Deposit {
                coin_type                 : _,
                reserve_array_index       : _,
                deposited_ctoken_amount   : _,
                market_value              : _,
                user_reward_manager_index : _,
                attributed_borrow_value   : _,
            } = 0x1::vector::remove<Deposit>(&mut arg0.deposits, v0);
        };
    }

    fun zero_out_rewards<T0>(arg0: &mut Obligation<T0>, arg1: &mut vector<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            let v1 = 0x1::vector::borrow<Deposit>(&arg0.deposits, v0);
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::change_user_reward_manager_share(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::deposits_pool_reward_manager_mut<T0>(0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(arg1, v1.reserve_array_index)), 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1.user_reward_manager_index), 0, arg2);
            v0 = v0 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            let v3 = 0x1::vector::borrow<Borrow>(&arg0.borrows, v2);
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::change_user_reward_manager_share(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::borrows_pool_reward_manager_mut<T0>(0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(arg1, v3.reserve_array_index)), 0x1::vector::borrow_mut<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v3.user_reward_manager_index), 0, arg2);
            v2 = v2 + 1;
        };
    }

    public(friend) fun zero_out_rewards_if_looped<T0>(arg0: &mut Obligation<T0>, arg1: &mut vector<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>, arg2: &0x2::clock::Clock) {
        if (is_looped<T0>(arg0)) {
            zero_out_rewards<T0>(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

