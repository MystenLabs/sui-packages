module 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager {
    struct PoolManagerReserveInformation has key {
        id: 0x2::object::UID,
        initialized: bool,
        users: 0x2::table_vec::TableVec<address>,
        user_amount: u128,
        total_collateral: u128,
        total_debt: u128,
        total_claimable_collateral: u128,
        protocol_profit_accumulate: u128,
        protocol_profit_unclaimed: u128,
        liquidation_bonus_unclaimed: u128,
        total_bad_debt: u128,
        interest_update_information: 0x2::table_vec::TableVec<InterestUpdateInformation>,
        liquidate_information: 0x2::table_vec::TableVec<LiquidateInformation>,
    }

    struct PoolManagerReserveBalance<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        usdt: 0x2::balance::Balance<T1>,
        collateral: 0x2::balance::Balance<T0>,
    }

    struct LiquidateInformation has copy, drop, store {
        active: bool,
        user: address,
        collateral_price: u128,
        collateral_price_decimal: u8,
        liquidate_debt: u128,
        liquidate_collateral: u128,
    }

    struct InterestUpdateInformation has copy, store {
        base_interest_update: u128,
        timestamp: u64,
    }

    struct PoolManagerReserveInformationView has copy, drop {
        user_amount: u128,
        total_collateral: u128,
        total_debt: u128,
        total_claimable_collateral: u128,
    }

    struct UserPoolReserveInformationView has copy, drop {
        timestamp_index: u64,
        collateral: u128,
        debt: u128,
        accumulated_interest: u128,
        claimable_collateral: u128,
    }

    struct UserLiquidationStatusView has copy, drop {
        premium_interest_rate: u128,
        ltv: u128,
        liquidation_threshold: u128,
        recovery_ltv: u128,
        liquidate_buffer: u128,
        can_liquidate: bool,
        liquidate_usdt: u128,
        liquidate_price: u128,
        oracle_decimal: u8,
    }

    struct LoanTokenDeposit has copy, drop {
        user: address,
        amount: u64,
        pending_loan_deposit: u128,
    }

    struct PendingLoanDepositCancelled has copy, drop {
        user: address,
        amount: u128,
        user_total_debt: u128,
        pending_loan_deposit: u128,
    }

    struct Supply has copy, drop {
        user: address,
        amount: u64,
        user_total_supply: u128,
        protocol_total_supply: u128,
    }

    struct Borrow has copy, drop {
        user: address,
        amount: u64,
        user_total_debt: u128,
        protocol_total_debt: u128,
    }

    struct Repay has copy, drop {
        user: address,
        amount: u64,
        user_total_debt: u128,
        protocol_total_debt: u128,
    }

    struct Withdraw has copy, drop {
        user: address,
        amount: u64,
        user_total_supply: u128,
        protocol_total_supply: u128,
        timestamp: u64,
    }

    struct ClaimCollateral has copy, drop {
        user: address,
        amount: u64,
        user_pool_claimable_BTC: u128,
        timestamp: u64,
    }

    struct Liquidation has copy, drop {
        user: address,
        collateral_decrease: u128,
        debt_decrease: u128,
    }

    struct Liquidate has copy, drop {
        user: address,
        liquidate_usdt: u128,
        liquidate_collateral: u128,
        liquidate_price: u128,
        liquidation_uid: u64,
    }

    struct UpdateLiquidateResult has copy, drop {
        target_uid: u64,
        liquidator: address,
        liquidate_price: u128,
        actual_liquidate_collateral: u128,
        bonus: u128,
    }

    struct BadDebt has copy, drop {
        user: address,
        target_uid: u64,
        amount: u128,
    }

    struct LiquidationBonusClaimed has copy, drop {
        account: address,
        claim_amount: u64,
    }

    struct ProtocolEarningsClaimed has copy, drop {
        account: address,
        claim_amount: u64,
    }

    struct CollateralPrepared has copy, drop {
        amount: u64,
        timestamp: u64,
    }

    public entry fun borrow(arg0: u64, arg1: &mut PoolManagerReserveInformation, arg2: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg5: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg6: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::OracleConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg4);
        let v0 = 0x2::tx_context::sender(arg8);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::assert_pool_initialized(v0, arg2);
        assert_valid_amount(arg0);
        update_state(v0, arg1, arg2, arg7);
        assert!(calculate_max_borrow_amount(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::ltv(v0, arg2), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_collateral(v0, arg2), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(v0, arg2), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_price(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg5), arg3, arg6, arg7), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::usdt_decimal(arg5), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_decimal(arg5), (0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_decimal(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg5), arg3, arg6, arg7) as u8)) >= (arg0 as u128), 2);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_debt(v0, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(v0, arg2) + (arg0 as u128), arg2);
        arg1.total_debt = arg1.total_debt + (arg0 as u128);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_pending_loan_deposit(v0, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_pending_loan_deposit(v0, arg2) + (arg0 as u128), arg2);
        let v1 = Borrow{
            user                : v0,
            amount              : arg0,
            user_total_debt     : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(v0, arg2),
            protocol_total_debt : arg1.total_debt,
        };
        0x2::event::emit<Borrow>(v1);
    }

    public entry fun set_user_pool_config(arg0: address, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: &mut PoolManagerReserveInformation, arg6: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg7: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_admin_role(0x2::tx_context::sender(arg9), arg7);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg7);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::assert_pool_initialized(arg0, arg6);
        update_state(arg0, arg5, arg6, arg8);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::set_user_pool_config(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    fun assert_real_collateral<T0>(arg0: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig) {
        assert!(0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))) == 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg0), 1);
    }

    fun assert_real_usdt<T0>(arg0: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig) {
        assert!(0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))) == 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::usdt_name(arg0), 1);
    }

    fun assert_valid_amount(arg0: u64) {
        assert!(arg0 > 0, 3);
    }

    public fun calculate_accumulated_debt(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast_2((arg0 as u256) * 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::calculate_compounded_interest(((arg1 + arg2) as u256) * 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::wad_ray_math::ray() / (10000 as u256), arg3, arg4) / 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::wad_ray_math::ray()) - arg0
    }

    public fun calculate_liquidate_amount(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u8, arg6: u8, arg7: u8) : (u128, u128) {
        let v0 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast_2(((arg3 as u256) - ((arg2 * arg4 * arg0) as u256) * 0x1::u256::pow(10, arg5) / 0x1::u256::pow(10, arg6 + arg7) * (10000 as u256)) * ((10000 - arg1) as u256) / ((10000 - arg1 - arg0) as u256));
        let v1 = v0;
        if (v0 > arg3) {
            v1 = arg3;
        };
        let v2 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast_2(((v1 * 10000) as u256) * 0x1::u256::pow(10, arg6 + arg7) / ((arg4 * (10000 - arg1)) as u256) * 0x1::u256::pow(10, arg5));
        let v3 = v2;
        if (v2 > arg2) {
            v3 = arg2;
        };
        (v1, v3)
    }

    public fun calculate_max_borrow_amount(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u8, arg5: u8, arg6: u8) : u128 {
        let v0 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast_2(((arg1 * arg3) as u256) * 0x1::u256::pow(10, arg4) / 0x1::u256::pow(10, arg5) * 0x1::u256::pow(10, arg6) * (arg0 as u256) / (10000 as u256));
        if (v0 > arg2) {
            v0 - arg2
        } else {
            0
        }
    }

    public fun calculate_max_withdraw_amount(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u8, arg5: u8, arg6: u8) : u128 {
        if (arg2 == 0) {
            arg1
        } else {
            let v1 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast_2((arg2 as u256) * 0x1::u256::pow(10, arg6 + arg5) * (10000 as u256) / ((arg3 * arg0) as u256) * 0x1::u256::pow(10, arg4));
            if (arg1 > v1) {
                arg1 - v1
            } else {
                0
            }
        }
    }

    public entry fun cancel_loan_token_deposit<T0>(arg0: address, arg1: u128, arg2: &mut PoolManagerReserveInformation, arg3: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg4: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg5: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg5);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_admin_role(0x2::tx_context::sender(arg7), arg5);
        assert_real_usdt<T0>(arg4);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::assert_pool_initialized(arg0, arg3);
        update_state(arg0, arg2, arg3, arg6);
        assert!(arg1 > 0, 3);
        assert!(arg1 <= 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_pending_loan_deposit(arg0, arg3), 9);
        cancel_pending_loan_deposit(arg0, arg1, arg2, arg3);
    }

    fun cancel_pending_loan_deposit(arg0: address, arg1: u128, arg2: &mut PoolManagerReserveInformation, arg3: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian) {
        let v0 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_pending_loan_deposit(arg0, arg3) - arg1;
        let v1 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(arg0, arg3) - arg1;
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_pending_loan_deposit(arg0, v0, arg3);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_debt(arg0, v1, arg3);
        arg2.total_debt = arg2.total_debt - arg1;
        let v2 = PendingLoanDepositCancelled{
            user                 : arg0,
            amount               : arg1,
            user_total_debt      : v1,
            pending_loan_deposit : v0,
        };
        0x2::event::emit<PendingLoanDepositCancelled>(v2);
    }

    public fun check_liquidate_condition(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u8, arg5: u8, arg6: u8) : bool {
        arg1 < 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast_2((arg2 as u256) * 0x1::u256::pow(10, arg6 + arg5) * (10000 as u256) / ((arg3 * arg0) as u256) * 0x1::u256::pow(10, arg4))
    }

    public entry fun claim_collateral<T0, T1>(arg0: u64, arg1: &mut PoolManagerReserveInformation, arg2: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg3: &mut PoolManagerReserveBalance<T0, T1>, arg4: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg4);
        let v0 = 0x2::tx_context::sender(arg6);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::assert_pool_initialized(v0, arg2);
        assert_valid_amount(arg0);
        let v1 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_claimable_collateral(v0, arg2);
        assert!(v1 >= (arg0 as u128), 4);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_claimable_collateral(v0, v1 - (arg0 as u128), arg2);
        arg1.total_claimable_collateral = arg1.total_claimable_collateral - (arg0 as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.collateral, arg0), arg6), v0);
        let v2 = ClaimCollateral{
            user                    : v0,
            amount                  : arg0,
            user_pool_claimable_BTC : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_claimable_collateral(v0, arg2),
            timestamp               : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<ClaimCollateral>(v2);
    }

    public entry fun claim_liquidation_bonus<T0, T1>(arg0: &mut PoolManagerReserveInformation, arg1: &mut PoolManagerReserveBalance<T0, T1>, arg2: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_admin_role(v0, arg2);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg2);
        let v1 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast(arg0.liquidation_bonus_unclaimed);
        assert_valid_amount(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral, v1), arg3), v0);
        arg0.liquidation_bonus_unclaimed = 0;
        let v2 = LiquidationBonusClaimed{
            account      : v0,
            claim_amount : v1,
        };
        0x2::event::emit<LiquidationBonusClaimed>(v2);
    }

    public entry fun claim_protocol_earnings<T0, T1>(arg0: &mut PoolManagerReserveInformation, arg1: &mut PoolManagerReserveBalance<T0, T1>, arg2: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_admin_role(v0, arg2);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg2);
        let v1 = 0x2::balance::value<T1>(&arg1.usdt);
        let v2 = v1;
        assert_valid_amount(v1);
        if (v1 > 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast(arg0.protocol_profit_unclaimed)) {
            v2 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast(arg0.protocol_profit_unclaimed);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.usdt, v2), arg3), v0);
        arg0.protocol_profit_unclaimed = arg0.protocol_profit_unclaimed - (v2 as u128);
        let v3 = ProtocolEarningsClaimed{
            account      : v0,
            claim_amount : v2,
        };
        0x2::event::emit<ProtocolEarningsClaimed>(v3);
    }

    public entry fun create_pool(arg0: address, arg1: &mut PoolManagerReserveInformation, arg2: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg3: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg4: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_admin_role(0x2::tx_context::sender(arg6), arg4);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg4);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::create_account(arg0, arg3, arg2, arg5);
        arg1.user_amount = arg1.user_amount + 1;
        0x2::table_vec::push_back<address>(&mut arg1.users, arg0);
    }

    public fun get_accumulate_user_debt_by_page(arg0: u64, arg1: u64, arg2: &PoolManagerReserveInformation, arg3: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg4: &0x2::clock::Clock) : u128 {
        let v0 = 0;
        while (arg0 < arg1 + 1) {
            let v1 = get_user_pool_reserve_information(*0x2::table_vec::borrow<address>(&arg2.users, arg0), arg2, arg3, arg4);
            v0 = v0 + v1.debt;
            arg0 = arg0 + 1;
        };
        v0
    }

    public fun get_interest_update_information(arg0: &PoolManagerReserveInformation) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x2::table_vec::length<InterestUpdateInformation>(&arg0.interest_update_information)) {
            let v2 = 0x2::table_vec::borrow<InterestUpdateInformation>(&arg0.interest_update_information, v1);
            let v3 = 0x1::string::utf8(0x1::bcs::to_bytes<u128>(&v2.base_interest_update));
            0x1::string::append_utf8(&mut v3, 0x1::bcs::to_bytes<u64>(&v2.timestamp));
            0x1::vector::push_back<0x1::string::String>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_liquidate_information(arg0: u64, arg1: &PoolManagerReserveInformation) : LiquidateInformation {
        *0x2::table_vec::borrow<LiquidateInformation>(&arg1.liquidate_information, arg0)
    }

    public fun get_pool_liquidation_bonus(arg0: &PoolManagerReserveInformation) : u128 {
        arg0.liquidation_bonus_unclaimed
    }

    public fun get_pool_manager_reserve_information(arg0: &PoolManagerReserveInformation, arg1: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg2: &0x2::clock::Clock) : PoolManagerReserveInformationView {
        let v0 = arg0.user_amount;
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = get_user_pool_reserve_information(*0x2::table_vec::borrow<address>(&arg0.users, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast(v2)), arg0, arg1, arg2);
            v1 = v1 + v3.debt;
            v2 = v2 + 1;
        };
        PoolManagerReserveInformationView{
            user_amount                : v0,
            total_collateral           : arg0.total_collateral,
            total_debt                 : v1,
            total_claimable_collateral : arg0.total_claimable_collateral,
        }
    }

    public fun get_total_bad_debt(arg0: &PoolManagerReserveInformation) : u128 {
        arg0.total_bad_debt
    }

    public fun get_user_max_borrow_amount(arg0: address, arg1: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg2: &PoolManagerReserveInformation, arg3: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::OracleConfig, arg6: &0x2::clock::Clock) : u128 {
        let v0 = get_user_pool_reserve_information(arg0, arg2, arg1, arg6);
        calculate_max_borrow_amount(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::ltv(arg0, arg1), v0.collateral, v0.debt, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_price(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg3), arg4, arg5, arg6), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::usdt_decimal(arg3), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_decimal(arg3), (0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_decimal(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg3), arg4, arg5, arg6) as u8))
    }

    public fun get_user_max_withdraw_amount(arg0: address, arg1: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg2: &PoolManagerReserveInformation, arg3: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::OracleConfig, arg6: &0x2::clock::Clock) : u128 {
        let v0 = get_user_pool_reserve_information(arg0, arg2, arg1, arg6);
        calculate_max_withdraw_amount(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::ltv(arg0, arg1), v0.collateral, v0.debt, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_price(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg3), arg4, arg5, arg6), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::usdt_decimal(arg3), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_decimal(arg3), (0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_decimal(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg3), arg4, arg5, arg6) as u8))
    }

    public fun get_user_pool_reserve_information(arg0: address, arg1: &PoolManagerReserveInformation, arg2: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg3: &0x2::clock::Clock) : UserPoolReserveInformationView {
        let v0 = 0x2::table_vec::length<InterestUpdateInformation>(&arg1.interest_update_information);
        let v1 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(arg0, arg2);
        let v2 = 0;
        let v3 = v0;
        let v4 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_reserve_timestamp(arg0, arg2);
        while (v3 > 0) {
            if (v4 >= 0x2::table_vec::borrow<InterestUpdateInformation>(&arg1.interest_update_information, v3 - 1).timestamp) {
                v2 = v3 - 1;
                break
            };
            v3 = v3 - 1;
        };
        let v5 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_accumulated_interest(arg0, arg2);
        v3 = v2;
        while (v3 < v0) {
            let v6 = if (v3 + 1 == v0) {
                0x2::clock::timestamp_ms(arg3) / 1000
            } else {
                0x2::table_vec::borrow<InterestUpdateInformation>(&arg1.interest_update_information, v3 + 1).timestamp
            };
            let v7 = calculate_accumulated_debt(v1, 0x2::table_vec::borrow<InterestUpdateInformation>(&arg1.interest_update_information, v3).base_interest_update, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::premium_interest_rate(arg0, arg2), v4, v6);
            v5 = v5 + v7;
            v1 = v1 + v7;
            v3 = v3 + 1;
        };
        UserPoolReserveInformationView{
            timestamp_index      : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_reserve_timestamp(arg0, arg2),
            collateral           : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_collateral(arg0, arg2),
            debt                 : v1,
            accumulated_interest : v5,
            claimable_collateral : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_claimable_collateral(arg0, arg2),
        }
    }

    public fun get_user_reserve_and_liquidation_status(arg0: address, arg1: &PoolManagerReserveInformation, arg2: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::OracleConfig, arg5: &0x2::clock::Clock, arg6: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig) : (UserPoolReserveInformationView, UserLiquidationStatusView) {
        let v0 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_price(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg6), arg3, arg4, arg5);
        let v1 = (0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_decimal(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg6), arg3, arg4, arg5) as u8);
        let v2 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_collateral(arg0, arg2);
        let v3 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(arg0, arg2);
        let v4 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::usdt_decimal(arg6);
        let v5 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_decimal(arg6);
        let v6 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::liquidation_threshold(arg0, arg2);
        let v7 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::recovery_ltv(arg0, arg2);
        let v8 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::buffer(arg0, arg2);
        let v9 = check_liquidate_condition(v6, v2, v3, v0, v4, v5, v1);
        let v10 = 0;
        if (v9) {
            let (v11, _) = calculate_liquidate_amount(v7, v8, v2, v3, v0, v4, v5, v1);
            v10 = v11;
        };
        let v13 = UserLiquidationStatusView{
            premium_interest_rate : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::premium_interest_rate(arg0, arg2),
            ltv                   : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::ltv(arg0, arg2),
            liquidation_threshold : v6,
            recovery_ltv          : v7,
            liquidate_buffer      : v8,
            can_liquidate         : v9,
            liquidate_usdt        : v10,
            liquidate_price       : v0,
            oracle_decimal        : v1,
        };
        (get_user_pool_reserve_information(arg0, arg1, arg2, arg5), v13)
    }

    public fun get_users(arg0: &PoolManagerReserveInformation) : vector<address> {
        let v0 = 0;
        let v1 = vector[];
        while (v0 < 0x2::table_vec::length<address>(&arg0.users)) {
            0x1::vector::push_back<address>(&mut v1, *0x2::table_vec::borrow<address>(&arg0.users, v0));
            v0 = v0 + 1;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InterestUpdateInformation{
            base_interest_update : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::initial_base_interest_rate(),
            timestamp            : 0,
        };
        let v1 = 0x2::table_vec::empty<InterestUpdateInformation>(arg0);
        0x2::table_vec::push_back<InterestUpdateInformation>(&mut v1, v0);
        let v2 = PoolManagerReserveInformation{
            id                          : 0x2::object::new(arg0),
            initialized                 : false,
            users                       : 0x2::table_vec::empty<address>(arg0),
            user_amount                 : 0,
            total_collateral            : 0,
            total_debt                  : 0,
            total_claimable_collateral  : 0,
            protocol_profit_accumulate  : 0,
            protocol_profit_unclaimed   : 0,
            liquidation_bonus_unclaimed : 0,
            total_bad_debt              : 0,
            interest_update_information : v1,
            liquidate_information       : 0x2::table_vec::empty<LiquidateInformation>(arg0),
        };
        0x2::transfer::share_object<PoolManagerReserveInformation>(v2);
    }

    public fun initiallize<T0, T1>(arg0: &0x2::coin::CoinMetadata<T1>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: vector<u8>, arg3: &mut PoolManagerReserveInformation, arg4: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg5: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg6: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::OracleConfig, arg7: &0x2::clock::Clock, arg8: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::DefaultAdminCap, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.initialized, 0);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::set_usdt<T1>(arg0, arg4, arg5, arg9);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::set_collateral<T0>(arg1, arg4, arg5, arg9);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::set_pyth_oracle<T0>(arg2, arg4, arg5, arg1, arg6, arg7, arg9);
        let v0 = PoolManagerReserveBalance<T0, T1>{
            id         : 0x2::object::new(arg9),
            usdt       : 0x2::balance::zero<T1>(),
            collateral : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<PoolManagerReserveBalance<T0, T1>>(v0);
        arg3.initialized = true;
    }

    public entry fun liquidate(arg0: address, arg1: &mut PoolManagerReserveInformation, arg2: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::OracleConfig, arg5: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg6: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg6);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_liquidator(0x2::tx_context::sender(arg8), arg6);
        update_state(arg0, arg1, arg2, arg7);
        let v0 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_collateral(arg0, arg2);
        let v1 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(arg0, arg2);
        let v2 = v1;
        let v3 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_price(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg5), arg3, arg4, arg7);
        let v4 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::usdt_decimal(arg5);
        let v5 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_decimal(arg5);
        let v6 = (0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_decimal(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg5), arg3, arg4, arg7) as u8);
        assert!(check_liquidate_condition(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::liquidation_threshold(arg0, arg2), v0, v1, v3, v4, v5, v6), 8);
        let v7 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_pending_loan_deposit(arg0, arg2);
        if (v7 > 0) {
            cancel_pending_loan_deposit(arg0, v7, arg1, arg2);
            let v8 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(arg0, arg2);
            v2 = v8;
            if (!check_liquidate_condition(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::liquidation_threshold(arg0, arg2), v0, v8, v3, v4, v5, v6)) {
                return
            };
        };
        let (v9, v10) = calculate_liquidate_amount(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::recovery_ltv(arg0, arg2), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::buffer(arg0, arg2), v0, v2, v3, v4, v5, v6);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_collateral(arg0, v0 - v10, arg2);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_debt(arg0, v2 - v9, arg2);
        let v11 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_accumulated_interest(arg0, arg2);
        let v12 = if (v11 > v9) {
            v9
        } else {
            v11
        };
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_accumulated_interest(arg0, v11 - v12, arg2);
        arg1.total_collateral = arg1.total_collateral - v10;
        arg1.total_debt = arg1.total_debt - v9;
        let v13 = LiquidateInformation{
            active                   : true,
            user                     : arg0,
            collateral_price         : v3,
            collateral_price_decimal : (v6 as u8),
            liquidate_debt           : v9,
            liquidate_collateral     : v10,
        };
        0x2::table_vec::push_back<LiquidateInformation>(&mut arg1.liquidate_information, v13);
        let v14 = Liquidate{
            user                 : arg0,
            liquidate_usdt       : v9,
            liquidate_collateral : v10,
            liquidate_price      : v3,
            liquidation_uid      : 0x2::table_vec::length<LiquidateInformation>(&arg1.liquidate_information) - 1,
        };
        0x2::event::emit<Liquidate>(v14);
    }

    public entry fun liquidate_legacy(arg0: address, arg1: u128, arg2: u128, arg3: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg4: &mut PoolManagerReserveInformation, arg5: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_admin_role(0x2::tx_context::sender(arg7), arg5);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg5);
        update_state(arg0, arg4, arg3, arg6);
        let v0 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_pending_loan_deposit(arg0, arg3);
        if (v0 > 0) {
            cancel_pending_loan_deposit(arg0, v0, arg4, arg3);
        };
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_collateral(arg0, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_collateral(arg0, arg3) - arg1, arg3);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_debt(arg0, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(arg0, arg3) - arg2, arg3);
        arg4.total_collateral = arg4.total_collateral - arg1;
        arg4.total_debt = arg4.total_debt - arg2;
        let v1 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_accumulated_interest(arg0, arg3);
        let v2 = if (v1 > arg2) {
            arg2
        } else {
            v1
        };
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_accumulated_interest(arg0, v1 - v2, arg3);
        let v3 = Liquidation{
            user                : arg0,
            collateral_decrease : arg1,
            debt_decrease       : arg2,
        };
        0x2::event::emit<Liquidation>(v3);
    }

    public entry fun loan_token_deposit<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg3: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg4: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg5: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg4);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_admin_role(0x2::tx_context::sender(arg5), arg4);
        assert_real_usdt<T0>(arg3);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::assert_pool_initialized(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert_valid_amount(v0);
        let v1 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_pending_loan_deposit(arg0, arg2);
        assert!((v0 as u128) <= v1, 9);
        let v2 = v1 - (v0 as u128);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_pending_loan_deposit(arg0, v2, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0);
        let v3 = LoanTokenDeposit{
            user                 : arg0,
            amount               : v0,
            pending_loan_deposit : v2,
        };
        0x2::event::emit<LoanTokenDeposit>(v3);
    }

    public entry fun prepare_collateral<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut PoolManagerReserveBalance<T0, T1>, arg2: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_treasury(0x2::tx_context::sender(arg4), arg2);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg2);
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert_valid_amount(v0);
        0x2::balance::join<T0>(&mut arg1.collateral, 0x2::coin::into_balance<T0>(arg0));
        let v1 = CollateralPrepared{
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<CollateralPrepared>(v1);
    }

    public fun repay<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut PoolManagerReserveInformation, arg2: &mut PoolManagerReserveBalance<T0, T1>, arg3: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg4: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg5: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg4);
        let v0 = 0x2::tx_context::sender(arg7);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::assert_pool_initialized(v0, arg3);
        update_state(v0, arg1, arg3, arg6);
        let v1 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(v0, arg3);
        let v2 = 0x2::coin::value<T1>(&arg0);
        let v3 = v2;
        assert_valid_amount(v2);
        assert_real_usdt<T1>(arg5);
        if ((v2 as u128) > v1) {
            v3 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast(v1);
        };
        let v4 = 0x2::coin::into_balance<T1>(arg0);
        let v5 = 0x2::balance::split<T1>(&mut v4, v3);
        let v6 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_accumulated_interest(v0, arg3);
        let v7 = if (0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast(v6) >= v3) {
            v6 - (v3 as u128)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v3 - 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast(v6)), arg7), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::get_treasury(arg4));
            0
        };
        0x2::balance::join<T1>(&mut arg2.usdt, v5);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_accumulated_interest(v0, v7, arg3);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_debt(v0, v1 - (v3 as u128), arg3);
        arg1.total_debt = arg1.total_debt - (v3 as u128);
        let v8 = v1 - (v3 as u128);
        if (0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_pending_loan_deposit(v0, arg3) > v8) {
            0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_pending_loan_deposit(v0, v8, arg3);
        };
        let v9 = Repay{
            user                : v0,
            amount              : v3,
            user_total_debt     : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(v0, arg3),
            protocol_total_debt : arg1.total_debt,
        };
        0x2::event::emit<Repay>(v9);
        0x2::coin::from_balance<T1>(v4, arg7)
    }

    public entry fun set_base_interest_rate(arg0: u128, arg1: &mut PoolManagerReserveInformation, arg2: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg3: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_admin_role(0x2::tx_context::sender(arg5), arg3);
        let v0 = InterestUpdateInformation{
            base_interest_update : arg0,
            timestamp            : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::table_vec::push_back<InterestUpdateInformation>(&mut arg1.interest_update_information, v0);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::set_base_interest_rate(arg0, arg2);
    }

    public entry fun supply<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut PoolManagerReserveInformation, arg2: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg3: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg4: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg5: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::assert_pool_initialized(v0, arg2);
        assert_real_collateral<T0>(arg3);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert_valid_amount(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::get_treasury(arg4));
        arg1.total_collateral = arg1.total_collateral + (v1 as u128);
        let v2 = Supply{
            user                  : v0,
            amount                : v1,
            user_total_supply     : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_collateral(v0, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_collateral(v0, arg2) + (v1 as u128), arg2),
            protocol_total_supply : arg1.total_collateral,
        };
        0x2::event::emit<Supply>(v2);
    }

    public entry fun update_liquidate_result<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: u128, arg3: &mut PoolManagerReserveInformation, arg4: &mut PoolManagerReserveBalance<T0, T1>, arg5: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::OracleConfig, arg8: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg9: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg9);
        let v0 = 0x2::tx_context::sender(arg11);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_liquidator(v0, arg9);
        assert_real_usdt<T1>(arg8);
        assert!(arg1 < 0x2::table_vec::length<LiquidateInformation>(&arg3.liquidate_information), 5);
        let v1 = 0x2::table_vec::borrow_mut<LiquidateInformation>(&mut arg3.liquidate_information, arg1);
        let v2 = v1.user;
        assert!(v1.active, 6);
        assert!(arg2 >= 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_price(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg8), arg6, arg7, arg10) * (10000 - 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::buffer(v2, arg5)) / 10000, 7);
        let v3 = v1.liquidate_debt * 0x1::u128::pow(10, v1.collateral_price_decimal + 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_decimal(arg8)) / arg2 * 0x1::u128::pow(10, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::usdt_decimal(arg8));
        let v4 = v3;
        let v5 = v1.liquidate_debt;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::liquidation_bonus_rate(arg8);
        if (v3 > v1.liquidate_collateral) {
            let v10 = v1.liquidate_collateral;
            v4 = v10;
            let v11 = v10 * arg2 * 0x1::u128::pow(10, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::usdt_decimal(arg8)) / 0x1::u128::pow(10, v1.collateral_price_decimal + 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_decimal(arg8));
            v5 = v11;
            v6 = v1.liquidate_debt - v11;
        } else if (v1.liquidate_collateral > v3 * (10000 + v9) / 10000) {
            v8 = v1.liquidate_collateral - v3 * (10000 + v9) / 10000;
            v7 = v3 * v9 / 10000;
        } else {
            v7 = v1.liquidate_collateral - v3;
        };
        arg3.liquidation_bonus_unclaimed = arg3.liquidation_bonus_unclaimed + v7;
        arg3.total_bad_debt = arg3.total_bad_debt + v6;
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_collateral(v2, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_collateral(v2, arg5) + v8, arg5);
        arg3.total_collateral = arg3.total_collateral + v8;
        v1.active = false;
        assert!(0x2::coin::value<T1>(&arg0) == 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast(v5), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg0, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::get_treasury(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg4.collateral, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::math_utils::safe_cast(v4)), arg11), v0);
        if (v6 > 0) {
            let v12 = BadDebt{
                user       : v2,
                target_uid : arg1,
                amount     : v6,
            };
            0x2::event::emit<BadDebt>(v12);
        };
        let v13 = UpdateLiquidateResult{
            target_uid                  : arg1,
            liquidator                  : v0,
            liquidate_price             : arg2,
            actual_liquidate_collateral : v4,
            bonus                       : v7,
        };
        0x2::event::emit<UpdateLiquidateResult>(v13);
    }

    fun update_state(arg0: address, arg1: &mut PoolManagerReserveInformation, arg2: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::table_vec::length<InterestUpdateInformation>(&arg1.interest_update_information);
        let v1 = 0;
        let v2 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_reserve_timestamp(arg0, arg2);
        let v3 = v0;
        while (v3 > 0) {
            if (v2 >= 0x2::table_vec::borrow<InterestUpdateInformation>(&arg1.interest_update_information, v3 - 1).timestamp) {
                v1 = v3 - 1;
                break
            };
            v3 = v3 - 1;
        };
        let v4 = 0;
        let v5 = 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(arg0, arg2);
        v3 = v1;
        while (v3 < v0) {
            let v6 = if (v3 + 1 == v0) {
                0x2::clock::timestamp_ms(arg3) / 1000
            } else {
                0x2::table_vec::borrow<InterestUpdateInformation>(&arg1.interest_update_information, v3 + 1).timestamp
            };
            let v7 = calculate_accumulated_debt(v5, 0x2::table_vec::borrow<InterestUpdateInformation>(&arg1.interest_update_information, v3).base_interest_update, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::premium_interest_rate(arg0, arg2), v2, v6);
            v4 = v4 + v7;
            v5 = v5 + v7;
            v3 = v3 + 1;
        };
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_reserve(arg0, v4, v5, arg2, arg3);
        arg1.total_debt = arg1.total_debt + v4;
        arg1.protocol_profit_accumulate = arg1.protocol_profit_accumulate + v4;
        arg1.protocol_profit_unclaimed = arg1.protocol_profit_unclaimed + v4;
    }

    public entry fun withdraw(arg0: u64, arg1: &mut PoolManagerReserveInformation, arg2: &mut 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::Custodian, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::OracleConfig, arg5: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::PoolManagerConfig, arg6: &0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::AccessConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::access_control::assert_not_paused(arg6);
        let v0 = 0x2::tx_context::sender(arg8);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::assert_pool_initialized(v0, arg2);
        assert_valid_amount(arg0);
        update_state(v0, arg1, arg2, arg7);
        assert!(calculate_max_withdraw_amount(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::ltv(v0, arg2), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_collateral(v0, arg2), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_debt(v0, arg2), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_price(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg5), arg3, arg4, arg7), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::usdt_decimal(arg5), 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_decimal(arg5), (0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::oracle::get_decimal(0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::pool_manager_config::collateral_name(arg5), arg3, arg4, arg7) as u8)) >= (arg0 as u128), 2);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_collateral(v0, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_collateral(v0, arg2) - (arg0 as u128), arg2);
        0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::update_user_claimable_collateral(v0, 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_claimable_collateral(v0, arg2) + (arg0 as u128), arg2);
        arg1.total_collateral = arg1.total_collateral - (arg0 as u128);
        arg1.total_claimable_collateral = arg1.total_claimable_collateral + (arg0 as u128);
        let v1 = Withdraw{
            user                  : v0,
            amount                : arg0,
            user_total_supply     : 0x5437d5b6941be58032c79f8741c5ba920ea62f278d5032fa8dcc541d259a365c::custodian_wrapper::get_user_collateral(v0, arg2),
            protocol_total_supply : arg1.total_collateral,
            timestamp             : 0x2::clock::timestamp_ms(arg7) / 1000,
        };
        0x2::event::emit<Withdraw>(v1);
    }

    // decompiled from Move bytecode v7
}

