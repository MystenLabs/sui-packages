module 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::obligation {
    struct Obligation<phantom T0> has store, key {
        id: 0x2::object::UID,
        deposits: vector<Deposit>,
        borrows: vector<Borrow>,
        deposited_value_usd: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        allowed_borrow_value_usd: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        unhealthy_borrow_value_usd: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        super_unhealthy_borrow_value_usd: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        unweighted_borrowed_value_usd: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        weighted_borrowed_value_usd: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        weighted_borrowed_value_upper_bound_usd: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        borrowing_isolated_asset: bool,
        user_reward_managers: vector<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>,
        bad_debt_usd: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        closable: bool,
    }

    struct Deposit has store {
        coin_type: 0x1::type_name::TypeName,
        reserve_array_index: u64,
        deposited_ctoken_amount: u64,
        market_value: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        user_reward_manager_index: u64,
        attributed_borrow_value: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
    }

    struct Borrow has store {
        coin_type: 0x1::type_name::TypeName,
        reserve_array_index: u64,
        borrowed_amount: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        cumulative_borrow_rate: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        market_value: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal,
        user_reward_manager_index: u64,
    }

    public(friend) fun borrow<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = find_or_add_borrow<T0>(arg0, arg1, arg2);
        let v1 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.borrows, v0);
        v1.borrowed_amount = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(v1.borrowed_amount, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(arg3));
        let v2 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::market_value<T0>(arg1, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(arg3));
        v1.market_value = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(v1.market_value, v2);
        arg0.unweighted_borrowed_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(arg0.unweighted_borrowed_value_usd, v2);
        arg0.weighted_borrowed_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(arg0.weighted_borrowed_value_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(v2, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::borrow_weight(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1))));
        arg0.weighted_borrowed_value_upper_bound_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(arg0.weighted_borrowed_value_upper_bound_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::market_value_upper_bound<T0>(arg1, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(arg3)), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::borrow_weight(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1))));
        0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::change_user_reward_manager_share(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::borrows_pool_reward_manager_mut<T0>(arg1), 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1.user_reward_manager_index), liability_shares(v1), arg2);
        assert!(is_healthy<T0>(arg0), 1);
        if (0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::isolated(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1)) || arg0.borrowing_isolated_asset) {
            assert!(0x1::vector::length<Borrow>(&arg0.borrows) == 1, 4);
        };
    }

    public(friend) fun claim_rewards<T0, T1>(arg0: &mut Obligation<T0>, arg1: &mut 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::PoolRewardManager, arg2: &0x2::clock::Clock, arg3: u64) : 0x2::balance::Balance<T1> {
        0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::claim_rewards<T1>(arg1, 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, find_user_reward_manager_index<T0>(arg0, arg1)), arg2, arg3)
    }

    public fun borrowed_amount<T0, T1>(arg0: &Obligation<T0>) : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            let v1 = 0x1::vector::borrow<Borrow>(&arg0.borrows, v0);
            if (v1.coin_type == 0x1::type_name::get<T1>()) {
                return v1.borrowed_amount
            };
            v0 = v0 + 1;
        };
        0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0)
    }

    fun compound_debt<T0>(arg0: &mut Borrow, arg1: &0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>) {
        let v0 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::cumulative_borrow_rate<T0>(arg1);
        arg0.borrowed_amount = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(arg0.borrowed_amount, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::div(v0, arg0.cumulative_borrow_rate));
        arg0.cumulative_borrow_rate = v0;
    }

    public(friend) fun create_obligation<T0>(arg0: &mut 0x2::tx_context::TxContext) : Obligation<T0> {
        Obligation<T0>{
            id                                      : 0x2::object::new(arg0),
            deposits                                : 0x1::vector::empty<Deposit>(),
            borrows                                 : 0x1::vector::empty<Borrow>(),
            deposited_value_usd                     : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            allowed_borrow_value_usd                : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            unhealthy_borrow_value_usd              : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            super_unhealthy_borrow_value_usd        : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            unweighted_borrowed_value_usd           : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            weighted_borrowed_value_usd             : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            weighted_borrowed_value_upper_bound_usd : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            borrowing_isolated_asset                : false,
            user_reward_managers                    : 0x1::vector::empty<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(),
            bad_debt_usd                            : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            closable                                : false,
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = find_or_add_deposit<T0>(arg0, arg1, arg2);
        let v1 = 0x1::vector::borrow_mut<Deposit>(&mut arg0.deposits, v0);
        v1.deposited_ctoken_amount = v1.deposited_ctoken_amount + arg3;
        let v2 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::ctoken_market_value<T0>(arg1, arg3);
        v1.market_value = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(v1.market_value, v2);
        arg0.deposited_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(arg0.deposited_value_usd, v2);
        arg0.allowed_borrow_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(arg0.allowed_borrow_value_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::ctoken_market_value_lower_bound<T0>(arg1, arg3), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::open_ltv(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1))));
        arg0.unhealthy_borrow_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(arg0.unhealthy_borrow_value_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(v2, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::close_ltv(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1))));
        0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::change_user_reward_manager_share(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::deposits_pool_reward_manager_mut<T0>(arg1), 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1.user_reward_manager_index), v1.deposited_ctoken_amount, arg2);
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

    fun find_borrow<T0>(arg0: &Obligation<T0>, arg1: &0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>) : &Borrow {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Borrow>(&arg0.borrows), 2);
        0x1::vector::borrow<Borrow>(&arg0.borrows, v0)
    }

    fun find_borrow_index<T0>(arg0: &Obligation<T0>, arg1: &0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            if (0x1::vector::borrow<Borrow>(&arg0.borrows, v0).reserve_array_index == 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::array_index<T0>(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_deposit<T0>(arg0: &Obligation<T0>, arg1: &0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>) : &Deposit {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit>(&arg0.deposits), 3);
        0x1::vector::borrow<Deposit>(&arg0.deposits, v0)
    }

    fun find_deposit_index<T0>(arg0: &Obligation<T0>, arg1: &0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            if (0x1::vector::borrow<Deposit>(&arg0.deposits, v0).reserve_array_index == 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::array_index<T0>(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_or_add_borrow<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            return v0
        };
        let v1 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::borrows_pool_reward_manager_mut<T0>(arg1);
        let (v2, _) = find_or_add_user_reward_manager<T0>(arg0, v1, arg2);
        let v4 = Borrow{
            coin_type                 : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::coin_type<T0>(arg1),
            reserve_array_index       : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::array_index<T0>(arg1),
            borrowed_amount           : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            cumulative_borrow_rate    : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::cumulative_borrow_rate<T0>(arg1),
            market_value              : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            user_reward_manager_index : v2,
        };
        0x1::vector::push_back<Borrow>(&mut arg0.borrows, v4);
        0x1::vector::length<Borrow>(&arg0.borrows) - 1
    }

    fun find_or_add_deposit<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            return v0
        };
        let v1 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::deposits_pool_reward_manager_mut<T0>(arg1);
        let (v2, _) = find_or_add_user_reward_manager<T0>(arg0, v1, arg2);
        let v4 = Deposit{
            coin_type                 : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::coin_type<T0>(arg1),
            reserve_array_index       : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::array_index<T0>(arg1),
            deposited_ctoken_amount   : 0,
            market_value              : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
            user_reward_manager_index : v2,
            attributed_borrow_value   : 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0),
        };
        0x1::vector::push_back<Deposit>(&mut arg0.deposits, v4);
        0x1::vector::length<Deposit>(&arg0.deposits) - 1
    }

    fun find_or_add_user_reward_manager<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::PoolRewardManager, arg2: &0x2::clock::Clock) : (u64, &mut 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager) {
        let v0 = find_user_reward_manager_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&arg0.user_reward_managers)) {
            return (v0, 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v0))
        };
        0x1::vector::push_back<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::new_user_reward_manager(arg1, arg2));
        let v1 = 0x1::vector::length<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&arg0.user_reward_managers);
        (v1 - 1, 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1 - 1))
    }

    fun find_user_reward_manager_index<T0>(arg0: &Obligation<T0>, arg1: &0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::PoolRewardManager) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&arg0.user_reward_managers)) {
            if (0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::pool_reward_manager_id(0x1::vector::borrow<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&arg0.user_reward_managers, v0)) == 0x2::object::id<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::PoolRewardManager>(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    public fun is_healthy<T0>(arg0: &Obligation<T0>) : bool {
        0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::le(arg0.weighted_borrowed_value_upper_bound_usd, arg0.allowed_borrow_value_usd)
    }

    public fun is_liquidatable<T0>(arg0: &Obligation<T0>) : bool {
        0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::gt(arg0.weighted_borrowed_value_usd, arg0.unhealthy_borrow_value_usd)
    }

    fun liability_shares(arg0: &Borrow) : u64 {
        0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::floor(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::div(arg0.borrowed_amount, arg0.cumulative_borrow_rate))
    }

    public(friend) fun liquidate<T0>(arg0: &mut Obligation<T0>, arg1: &mut vector<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64) : (u64, u64) {
        assert!(is_liquidatable<T0>(arg0), 0);
        let v0 = 0x1::vector::borrow<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>>(arg1, arg2);
        let v1 = 0x1::vector::borrow<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>>(arg1, arg3);
        let v2 = find_borrow<T0>(arg0, v0);
        let v3 = find_deposit<T0>(arg0, v1);
        let v4 = if (0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::le(v2.market_value, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(1))) {
            v2.borrowed_amount
        } else {
            0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::min(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::div(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::min(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(arg0.weighted_borrowed_value_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from_percent(20)), v2.market_value), v2.market_value), v2.borrowed_amount), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(arg5))
        };
        let v5 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::market_value<T0>(v0, v4), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(1), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::liquidation_bonus(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(v1)), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::protocol_liquidation_fee(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(v1)))));
        let (v6, v7, v8) = if (0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::lt(v3.market_value, v5)) {
            let v9 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(v4, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::div(v3.market_value, v5));
            (0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::ceil(v9), v9, v3.deposited_ctoken_amount)
        } else {
            (0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::ceil(v4), v4, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::floor(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(v3.deposited_ctoken_amount), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::div(v5, v3.market_value))))
        };
        let v10 = 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>>(arg1, arg2);
        repay<T0>(arg0, v10, arg4, v7);
        let v11 = 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>>(arg1, arg3);
        withdraw_unchecked<T0>(arg0, v11, arg4, v8);
        (v8, v6)
    }

    public(friend) fun refresh<T0>(arg0: &mut Obligation<T0>, arg1: &mut vector<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        let v1 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0);
        let v2 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0);
        let v3 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0);
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            let v4 = 0x1::vector::borrow_mut<Deposit>(&mut arg0.deposits, v0);
            let v5 = 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>>(arg1, v4.reserve_array_index);
            0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::compound_interest<T0>(v5, arg2);
            0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::assert_price_is_fresh<T0>(v5, arg2);
            let v6 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::ctoken_market_value<T0>(v5, v4.deposited_ctoken_amount);
            v4.market_value = v6;
            v1 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(v1, v6);
            v2 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(v2, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::ctoken_market_value_lower_bound<T0>(v5, v4.deposited_ctoken_amount), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::open_ltv(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(v5))));
            v3 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(v3, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(v6, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::close_ltv(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(v5))));
            v0 = v0 + 1;
        };
        arg0.deposited_value_usd = v1;
        arg0.allowed_borrow_value_usd = v2;
        arg0.unhealthy_borrow_value_usd = v3;
        let v7 = 0;
        let v8 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0);
        let v9 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0);
        let v10 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0);
        let v11 = false;
        while (v7 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            let v12 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.borrows, v7);
            let v13 = 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>>(arg1, v12.reserve_array_index);
            0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::compound_interest<T0>(v13, arg2);
            0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::assert_price_is_fresh<T0>(v13, arg2);
            compound_debt<T0>(v12, v13);
            let v14 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::market_value<T0>(v13, v12.borrowed_amount);
            v12.market_value = v14;
            v8 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(v8, v14);
            v9 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(v9, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(v14, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::borrow_weight(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(v13))));
            v10 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(v10, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::market_value_upper_bound<T0>(v13, v12.borrowed_amount), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::borrow_weight(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(v13))));
            if (0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::isolated(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(v13))) {
                v11 = true;
            };
            v7 = v7 + 1;
        };
        arg0.unweighted_borrowed_value_usd = v8;
        arg0.weighted_borrowed_value_usd = v9;
        arg0.weighted_borrowed_value_upper_bound_usd = v10;
        arg0.borrowing_isolated_asset = v11;
    }

    public(friend) fun repay<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::Decimal) : u64 {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Borrow>(&arg0.borrows), 2);
        let v1 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.borrows, v0);
        let v2 = v1.borrowed_amount;
        compound_debt<T0>(v1, arg1);
        let v3 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::min(arg3, v1.borrowed_amount);
        let v4 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(v1.borrowed_amount, v2);
        v1.borrowed_amount = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(v1.borrowed_amount, v3);
        if (0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::le(v4, v3)) {
            let v5 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(v3, v4);
            let v6 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::market_value<T0>(arg1, v5);
            v1.market_value = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(v1.market_value, v6);
            arg0.unweighted_borrowed_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(arg0.unweighted_borrowed_value_usd, v6);
            arg0.weighted_borrowed_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(arg0.weighted_borrowed_value_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(v6, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::borrow_weight(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1))));
            arg0.weighted_borrowed_value_upper_bound_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(arg0.weighted_borrowed_value_upper_bound_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::market_value_upper_bound<T0>(arg1, v5), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::borrow_weight(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1))));
        } else {
            let v7 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(v4, v3);
            let v8 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::market_value<T0>(arg1, v7);
            v1.market_value = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(v1.market_value, v8);
            arg0.unweighted_borrowed_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(arg0.unweighted_borrowed_value_usd, v8);
            arg0.weighted_borrowed_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(arg0.weighted_borrowed_value_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(v8, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::borrow_weight(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1))));
            arg0.weighted_borrowed_value_upper_bound_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::add(arg0.weighted_borrowed_value_upper_bound_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::market_value_upper_bound<T0>(arg1, v7), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::borrow_weight(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1))));
        };
        0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::change_user_reward_manager_share(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::borrows_pool_reward_manager_mut<T0>(arg1), 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1.user_reward_manager_index), liability_shares(v1), arg2);
        if (0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::eq(v1.borrowed_amount, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::from(0))) {
            let Borrow {
                coin_type                 : _,
                reserve_array_index       : _,
                borrowed_amount           : _,
                cumulative_borrow_rate    : _,
                market_value              : _,
                user_reward_manager_index : _,
            } = 0x1::vector::remove<Borrow>(&mut arg0.borrows, v0);
        };
        0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::ceil(v3)
    }

    public(friend) fun withdraw<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        withdraw_unchecked<T0>(arg0, arg1, arg2, arg3);
        assert!(is_healthy<T0>(arg0), 1);
    }

    fun withdraw_unchecked<T0>(arg0: &mut Obligation<T0>, arg1: &mut 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::Reserve<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit>(&arg0.deposits), 3);
        let v1 = 0x1::vector::borrow_mut<Deposit>(&mut arg0.deposits, v0);
        let v2 = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::ctoken_market_value<T0>(arg1, arg3);
        v1.market_value = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(v1.market_value, v2);
        v1.deposited_ctoken_amount = v1.deposited_ctoken_amount - arg3;
        arg0.deposited_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(arg0.deposited_value_usd, v2);
        arg0.allowed_borrow_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(arg0.allowed_borrow_value_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::ctoken_market_value_lower_bound<T0>(arg1, arg3), 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::open_ltv(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1))));
        arg0.unhealthy_borrow_value_usd = 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::sub(arg0.unhealthy_borrow_value_usd, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::decimal::mul(v2, 0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve_config::close_ltv(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::config<T0>(arg1))));
        0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::change_user_reward_manager_share(0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::reserve::deposits_pool_reward_manager_mut<T0>(arg1), 0x1::vector::borrow_mut<0xddb75ad9b792ab740e4dbbfdf69d60613cbf1ba7071757250a3b96983a39d9b6::liquidity_mining::UserRewardManager>(&mut arg0.user_reward_managers, v1.user_reward_manager_index), v1.deposited_ctoken_amount, arg2);
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

    // decompiled from Move bytecode v6
}

