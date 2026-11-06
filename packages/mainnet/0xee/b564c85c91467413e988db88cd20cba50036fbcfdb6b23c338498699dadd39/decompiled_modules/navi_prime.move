module 0xeeb564c85c91467413e988db88cd20cba50036fbcfdb6b23c338498699dadd39::navi_prime {
    struct NaviPrimeEntity has drop {
        dummy_field: bool,
    }

    struct PrincipalMarket has copy, drop, store {
        storage_id: 0x2::object::ID,
        asset: u8,
    }

    struct BorrowLimitKey has copy, drop, store {
        creditor_entity: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity,
        storage_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
    }

    struct NaviPrime has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
        creditors: 0x2::vec_set::VecSet<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>,
        managers: 0x2::vec_map::VecMap<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x2::vec_set::VecSet<address>>,
        principal_markets: 0x2::vec_map::VecMap<0x1::type_name::TypeName, PrincipalMarket>,
        creditor_account_caps: 0x2::vec_map::VecMap<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>,
        min_health_factor_bps: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        max_borrow_amounts: 0x2::vec_map::VecMap<BorrowLimitKey, u64>,
    }

    struct BorrowCapReceipt {
        creditor_entity: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity,
        account_cap_id: 0x2::object::ID,
    }

    struct LoanDeposit<phantom T0> {
        creditor_entity: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity,
        balance: 0x2::balance::Balance<T0>,
    }

    struct ReturnCapCheck {
        creditor_entity: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity,
        owner_address: address,
        checked_coin_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun add_creditor<T0>(arg0: &mut NaviPrime, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T0>();
        0x2::vec_set::insert<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>(&mut arg0.creditors, v0);
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(&arg0.creditor_account_caps, &v0)) {
            0x2::vec_map::insert<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(&mut arg0.creditor_account_caps, v0, 0x1::option::some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2)));
        };
    }

    public fun add_manager<T0>(arg0: &mut NaviPrime, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T0>();
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x2::vec_set::VecSet<address>>(&arg0.managers, &v0)) {
            0x2::vec_map::insert<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x2::vec_set::VecSet<address>>(&mut arg0.managers, v0, 0x2::vec_set::empty<address>());
        };
        0x2::vec_set::insert<address>(0x2::vec_map::get_mut<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x2::vec_set::VecSet<address>>(&mut arg0.managers, &v0), arg2);
    }

    public fun add_version(arg0: &mut NaviPrime, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg0.versions, arg2);
    }

    fun assert_can_manage<T0>(arg0: &NaviPrime, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        if (!is_creditor<T0>(arg0)) {
            err_creditor_not_whitelisted();
        };
        assert_sender_is_manager<T0>(arg0, arg1);
    }

    fun assert_creditor(arg0: &BorrowCapReceipt, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity) {
        if (arg0.creditor_entity != arg1) {
            err_wrong_creditor();
        };
    }

    fun assert_loans_within_limits(arg0: &NaviPrime, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: address) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg3, arg4);
        let v2 = v1;
        0x1::vector::reverse<u8>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v4 = 0x1::vector::pop_back<u8>(&mut v2);
            assert_within_borrow_limit(arg0, arg1, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg3), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg3, v4), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg2, arg3, v4, arg4, 0, true));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u8>(v2);
    }

    fun assert_market_health(arg0: &NaviPrime, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: address) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        if (0x1::vector::is_empty<u8>(&v2)) {
            return
        };
        if (0x1::vector::is_empty<u8>(&v3)) {
            err_health_below_minimum();
        };
        let v4 = *0x1::vector::borrow<u8>(&v3, 0);
        let v5 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_health_loan_value(arg1, arg2, arg3, arg4, v4, 0, false);
        if (v5 == 0) {
            return
        };
        let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_health_collateral_value(arg1, arg2, arg3, arg4, v4, 0, true);
        if (v6 == 0) {
            err_health_below_minimum();
        };
        assert_min_health(arg0, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg3), v6, v5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_liquidation_threshold(arg1, arg3, arg2, arg4, v4, 0, true));
    }

    fun assert_min_health(arg0: &NaviPrime, arg1: 0x2::object::ID, arg2: u256, arg3: u256, arg4: u256) {
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div(arg2, arg3), arg4) < (min_health_factor_bps(arg0, arg1) as u256) * 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray() / 10000) {
            err_health_below_minimum();
        };
    }

    fun assert_no_debt<T0>(arg0: &NaviPrime) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviPrimeEntity>>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviPrimeEntity>>(&arg0.id, v0);
        let v2 = 0x2::vec_map::keys<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::debts<T0, NaviPrimeEntity>(v1));
        0x1::vector::reverse<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>(&v2)) {
            let v4 = 0x1::vector::pop_back<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>(&mut v2);
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::debt_value<T0>(0x2::vec_map::get<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::debts<T0, NaviPrimeEntity>(v1), &v4)) > 0) {
                err_principal_outstanding();
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>(v2);
    }

    fun assert_principal_held(arg0: u256, arg1: u256) {
        if (arg0 + 1000 < arg1) {
            err_principal_not_in_market();
        };
    }

    fun assert_sender_is_manager<T0>(arg0: &NaviPrime, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        if (!is_manager<T0>(arg0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1))) {
            err_sender_is_not_manager();
        };
    }

    fun assert_valid_package_version(arg0: &NaviPrime) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    fun assert_within_borrow_limit(arg0: &NaviPrime, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u256) {
        if (arg4 > (max_borrow_amount_of(arg0, arg1, arg2, arg3) as u256)) {
            err_borrow_limit_exceeded();
        };
    }

    public fun borrow_account_cap<T0>(arg0: &mut NaviPrime, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, BorrowCapReceipt) {
        assert_valid_package_version(arg0);
        assert_can_manage<T0>(arg0, arg1);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T0>();
        let v1 = extract_account_cap(arg0, v0);
        let v2 = BorrowCapReceipt{
            creditor_entity : v0,
            account_cap_id  : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&v1),
        };
        (v1, v2)
    }

    public fun check_market<T0>(arg0: &NaviPrime, arg1: &mut ReturnCapCheck, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) {
        assert_valid_package_version(arg0);
        let v0 = mark_coin_type_checked<T0>(arg1, arg0, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg4));
        let v1 = arg1.owner_address;
        assert_principal_held(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg2, arg4, v0, v1, 0, true), (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::normal_amount<T0>(arg5, debt_amount_of<T0>(arg0, arg1.creditor_entity)) as u256));
        assert_loans_within_limits(arg0, arg1.creditor_entity, arg2, arg4, v1);
        assert_market_health(arg0, arg2, arg3, arg4, v1);
    }

    public fun claim_surplus<T0, T1>(arg0: &mut NaviPrime, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg0);
        assert_can_manage<T1>(arg0, arg1);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>();
        let v1 = principal_market_of<T0>(arg0, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg3));
        let v2 = v1.asset;
        let v3 = extract_account_cap(arg0, v0);
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v3);
        let v5 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg8, (surplus_of(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg6, arg3, v2, v4, 0, true), (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::normal_amount<T0>(arg8, debt_amount_of<T0>(arg0, v0)) as u256)) as u64));
        if (v5 == 0) {
            fill_account_cap(arg0, v0, v3);
            return 0x2::coin::zero<T0>(arg9)
        };
        let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg6, arg2, arg3, arg8, v2, v5, arg4, arg5, &v3, arg7, arg9);
        fill_account_cap(arg0, v0, v3);
        assert_market_health(arg0, arg6, arg2, arg3, v4);
        0x2::coin::from_balance<T0>(v6, arg9)
    }

    public fun debt_amount<T0, T1>(arg0: &NaviPrime) : u64 {
        debt_amount_of<T0>(arg0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>())
    }

    fun debt_amount_of<T0>(arg0: &NaviPrime, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviPrimeEntity>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviPrimeEntity>>(&arg0.id, v0);
        if (0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::debts<T0, NaviPrimeEntity>(v1), &arg1)) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::debt_value<T0>(0x2::vec_map::get<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::debts<T0, NaviPrimeEntity>(v1), &arg1))
        } else {
            0
        }
    }

    public fun deposit_loan<T0>(arg0: &NaviPrime, arg1: &BorrowCapReceipt, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg3: LoanDeposit<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let (v0, v1) = open_loan_deposit<T0>(arg0, arg1, arg2, arg3, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg4));
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg7, arg4, arg8, v1, 0x2::coin::from_balance<T0>(v0, arg9), arg5, arg6, arg2);
    }

    fun err_account_cap_mismatch() {
        abort 2
    }

    fun err_asset_coin_type_mismatch() {
        abort 8
    }

    fun err_borrow_limit_exceeded() {
        abort 11
    }

    fun err_creditor_not_whitelisted() {
        abort 12
    }

    fun err_health_below_minimum() {
        abort 7
    }

    fun err_invalid_package_version() {
        abort 1
    }

    fun err_market_not_registered() {
        abort 4
    }

    fun err_markets_not_all_checked() {
        abort 5
    }

    fun err_min_health_factor_too_low() {
        abort 13
    }

    fun err_principal_not_in_market() {
        abort 9
    }

    fun err_principal_outstanding() {
        abort 10
    }

    fun err_sender_is_not_manager() {
        abort 6
    }

    fun err_wrong_creditor() {
        abort 3
    }

    fun extract_account_cap(arg0: &mut NaviPrime, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(&arg0.creditor_account_caps, &arg1)) {
            err_creditor_not_whitelisted();
        };
        0x1::option::extract<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x2::vec_map::get_mut<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(&mut arg0.creditor_account_caps, &arg1))
    }

    fun fill_account_cap(arg0: &mut NaviPrime, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0x1::option::fill<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x2::vec_map::get_mut<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(&mut arg0.creditor_account_caps, &arg1), arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviPrime{
            id                    : 0x2::object::new(arg0),
            versions              : 0x2::vec_set::singleton<u16>(package_version()),
            creditors             : 0x2::vec_set::empty<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>(),
            managers              : 0x2::vec_map::empty<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x2::vec_set::VecSet<address>>(),
            principal_markets     : 0x2::vec_map::empty<0x1::type_name::TypeName, PrincipalMarket>(),
            creditor_account_caps : 0x2::vec_map::empty<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(),
            min_health_factor_bps : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            max_borrow_amounts    : 0x2::vec_map::empty<BorrowLimitKey, u64>(),
        };
        0x2::transfer::share_object<NaviPrime>(v0);
    }

    public fun is_creditor<T0>(arg0: &NaviPrime) : bool {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T0>();
        0x2::vec_set::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>(&arg0.creditors, &v0)
    }

    public fun is_manager<T0>(arg0: &NaviPrime, arg1: address) : bool {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T0>();
        0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x2::vec_set::VecSet<address>>(&arg0.managers, &v0) && 0x2::vec_set::contains<address>(0x2::vec_map::get<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x2::vec_set::VecSet<address>>(&arg0.managers, &v0), &arg1)
    }

    fun mark_coin_type_checked<T0>(arg0: &mut ReturnCapCheck, arg1: &NaviPrime, arg2: 0x2::object::ID) : u8 {
        let v0 = principal_market_of<T0>(arg1, arg2);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.checked_coin_types, 0x1::type_name::with_defining_ids<T0>());
        v0.asset
    }

    public fun max_borrow_amount<T0, T1>(arg0: &NaviPrime, arg1: 0x2::object::ID) : u64 {
        max_borrow_amount_of(arg0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>(), arg1, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    fun max_borrow_amount_of(arg0: &NaviPrime, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, arg2: 0x2::object::ID, arg3: 0x1::ascii::String) : u64 {
        let v0 = BorrowLimitKey{
            creditor_entity : arg1,
            storage_id      : arg2,
            coin_type       : arg3,
        };
        if (0x2::vec_map::contains<BorrowLimitKey, u64>(&arg0.max_borrow_amounts, &v0)) {
            *0x2::vec_map::get<BorrowLimitKey, u64>(&arg0.max_borrow_amounts, &v0)
        } else {
            0
        }
    }

    public fun min_health_factor_bps(arg0: &NaviPrime, arg1: 0x2::object::ID) : u64 {
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.min_health_factor_bps, &arg1)) {
            *0x2::vec_map::get<0x2::object::ID, u64>(&arg0.min_health_factor_bps, &arg1)
        } else {
            15000
        }
    }

    fun open_loan_deposit<T0>(arg0: &NaviPrime, arg1: &BorrowCapReceipt, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg3: LoanDeposit<T0>, arg4: 0x2::object::ID) : (0x2::balance::Balance<T0>, u8) {
        let LoanDeposit {
            creditor_entity : v0,
            balance         : v1,
        } = arg3;
        assert_creditor(arg1, v0);
        if (0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg2) != arg1.account_cap_id) {
            err_account_cap_mismatch();
        };
        let v2 = principal_market_of<T0>(arg0, arg4);
        (v1, v2.asset)
    }

    public fun package_version() : u16 {
        1
    }

    fun principal_market_of<T0>(arg0: &NaviPrime, arg1: 0x2::object::ID) : PrincipalMarket {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, PrincipalMarket>(&arg0.principal_markets, &v0)) {
            err_market_not_registered();
        };
        let v1 = *0x2::vec_map::get<0x1::type_name::TypeName, PrincipalMarket>(&arg0.principal_markets, &v0);
        if (v1.storage_id != arg1) {
            err_market_not_registered();
        };
        v1
    }

    public fun principal_markets(arg0: &NaviPrime) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, PrincipalMarket> {
        &arg0.principal_markets
    }

    public fun receive_loan<T0, T1>(arg0: &mut NaviPrime, arg1: &BorrowCapReceipt, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Loan<T0, T1, NaviPrimeEntity>) : LoanDeposit<T0> {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>();
        assert_creditor(arg1, v0);
        LoanDeposit<T0>{
            creditor_entity : v0,
            balance         : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::receive<T0, T1, NaviPrimeEntity>(sheet_mut<T0>(arg0, v0), arg2, stamp()),
        }
    }

    public fun remove_creditor<T0>(arg0: &mut NaviPrime, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T0>();
        0x2::vec_set::remove<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>(&mut arg0.creditors, &v0);
    }

    public fun remove_manager<T0>(arg0: &mut NaviPrime, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T0>();
        0x2::vec_set::remove<address>(0x2::vec_map::get_mut<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x2::vec_set::VecSet<address>>(&mut arg0.managers, &v0), &arg2);
    }

    public fun remove_principal_market<T0>(arg0: &mut NaviPrime, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        assert_no_debt<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, PrincipalMarket>(&mut arg0.principal_markets, &v0);
    }

    public fun remove_version(arg0: &mut NaviPrime, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg0.versions, &arg2);
    }

    public fun repay<T0, T1>(arg0: &mut NaviPrime, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager<T1>(arg0, arg1);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>();
        let v1 = principal_market_of<T0>(arg0, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg3));
        let v2 = v1.asset;
        let v3 = extract_account_cap(arg0, v0);
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v3);
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg6, arg3, v2, v4, 0, true) == 0) {
            fill_account_cap(arg0, v0, v3);
            return
        };
        let v5 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg6, arg2, arg3, arg8, v2, repay_amount<T0, T1>(arg0, arg9), arg4, arg5, &v3, arg7, arg10);
        fill_account_cap(arg0, v0, v3);
        let v6 = sheet_mut<T0>(arg0, v0);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::pay<T0, T1, NaviPrimeEntity>(v6, arg9, v5, stamp());
        assert_market_health(arg0, arg6, arg2, arg3, v4);
    }

    fun repay_amount<T0, T1>(arg0: &NaviPrime, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T0, T1>) : u64 {
        0x1::u64::min(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::shortage<T0, T1>(arg1), debt_amount_of<T0>(arg0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>()))
    }

    public fun repay_with_balance<T0, T1>(arg0: &mut NaviPrime, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T0, T1>, arg3: 0x2::balance::Balance<T0>) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager<T1>(arg0, arg1);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>();
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(&arg0.creditor_account_caps, &v0)) {
            err_creditor_not_whitelisted();
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::pay<T0, T1, NaviPrimeEntity>(sheet_mut<T0>(arg0, v0), arg2, arg3, stamp());
    }

    public fun return_account_cap(arg0: &mut NaviPrime, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: BorrowCapReceipt) : ReturnCapCheck {
        assert_valid_package_version(arg0);
        let BorrowCapReceipt {
            creditor_entity : v0,
            account_cap_id  : v1,
        } = arg2;
        if (0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg1) != v1) {
            err_account_cap_mismatch();
        };
        fill_account_cap(arg0, v0, arg1);
        ReturnCapCheck{
            creditor_entity    : v0,
            owner_address      : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg1),
            checked_coin_types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    fun set_market_min_health_factor_bps(arg0: &mut NaviPrime, arg1: 0x2::object::ID, arg2: u64) {
        if (arg2 < 10000) {
            err_min_health_factor_too_low();
        };
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.min_health_factor_bps, &arg1)) {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.min_health_factor_bps, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.min_health_factor_bps, arg1, arg2);
        };
    }

    public fun set_max_borrow_amount<T0, T1>(arg0: &mut NaviPrime, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u64) {
        set_normal_max_borrow_amount<T0, T1>(arg0, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::normal_amount<T0>(arg3, arg4));
    }

    public fun set_min_health_factor_bps(arg0: &mut NaviPrime, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u64) {
        set_market_min_health_factor_bps(arg0, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2), arg3);
    }

    fun set_normal_max_borrow_amount<T0, T1>(arg0: &mut NaviPrime, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = BorrowLimitKey{
            creditor_entity : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>(),
            storage_id      : arg1,
            coin_type       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        if (0x2::vec_map::contains<BorrowLimitKey, u64>(&arg0.max_borrow_amounts, &v0)) {
            *0x2::vec_map::get_mut<BorrowLimitKey, u64>(&mut arg0.max_borrow_amounts, &v0) = arg2;
        } else {
            0x2::vec_map::insert<BorrowLimitKey, u64>(&mut arg0.max_borrow_amounts, v0, arg2);
        };
    }

    public fun set_principal_market<T0>(arg0: &mut NaviPrime, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8) {
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg2, arg3) != 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) {
            err_asset_coin_type_mismatch();
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, PrincipalMarket>(&arg0.principal_markets, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, PrincipalMarket>(&mut arg0.principal_markets, &v0);
        };
        let v3 = PrincipalMarket{
            storage_id : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2),
            asset      : arg3,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, PrincipalMarket>(&mut arg0.principal_markets, v0, v3);
    }

    public fun settle_return(arg0: &NaviPrime, arg1: ReturnCapCheck) {
        assert_valid_package_version(arg0);
        let ReturnCapCheck {
            creditor_entity    : _,
            owner_address      : _,
            checked_coin_types : v2,
        } = arg1;
        let v3 = v2;
        if (0x2::vec_set::length<0x1::type_name::TypeName>(&v3) != 0x2::vec_map::length<0x1::type_name::TypeName, PrincipalMarket>(&arg0.principal_markets)) {
            err_markets_not_all_checked();
        };
    }

    fun sheet_mut<T0>(arg0: &mut NaviPrime, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity) : &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviPrimeEntity> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviPrimeEntity>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviPrimeEntity>>(&mut arg0.id, v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T0, NaviPrimeEntity>(stamp()));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviPrimeEntity>>(&mut arg0.id, v0);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::add_creditor<T0, NaviPrimeEntity>(v1, arg1, stamp());
        v1
    }

    fun stamp() : NaviPrimeEntity {
        NaviPrimeEntity{dummy_field: false}
    }

    fun surplus_of(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

