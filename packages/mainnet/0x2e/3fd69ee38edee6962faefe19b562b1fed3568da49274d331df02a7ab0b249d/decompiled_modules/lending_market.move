module 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::lending_market {
    struct DepositReserveAndObligationEvent has copy, drop {
        obligation_owner: address,
        reserve: address,
        deposit_amount: u64,
        mint_collateral_amount: u64,
        deposited_collateral_amount_obligation: u64,
        total_reserve_supplied: u128,
        total_reserve_mint_collateral: u64,
        new_cumulative_borrow_rate_sf: u256,
        has_debt: bool,
    }

    struct WithdrawObligationCollateralEvent has copy, drop {
        obligation_owner: address,
        reserve: 0x2::object::ID,
        market_type: 0x1::string::String,
        withdraw_amount: u64,
        burn_collateral_amount: u64,
        remaining_deposited_amount_obligation: u64,
        remaining_reserve_supplied_sf: u256,
        remaining_reserve_mint_collateral: u64,
        new_cumulative_borrow_rate_sf: u256,
        has_debt: bool,
    }

    struct BorrowObligationLiquidityEvent has copy, drop {
        obligation_owner: address,
        reserve: 0x2::object::ID,
        market_type: 0x1::string::String,
        borrow_amount: u64,
        total_reserve_borrowed_sf: u256,
        borrowed_amount_obligation_sf: u256,
        new_cumulative_borrow_rate_sf: u256,
        has_debt: bool,
    }

    struct RepayObligationLiquidityEvent has copy, drop {
        obligation_owner: address,
        reserve: 0x2::object::ID,
        market_type: 0x1::string::String,
        repay_amount: u64,
        total_reserve_supplied_sf: u256,
        total_reserve_borrowed_sf: u256,
        remaining_borrowed_amount_obligation_sf: u256,
        new_cumulative_borrow_rate_sf: u256,
        has_debt: bool,
    }

    struct LockReserveEvent has copy, drop {
        owner: address,
        obligation: address,
    }

    struct LiquidationEvent has copy, drop {
        obligation_owner: address,
        liquidate_reserve: address,
        repay_reserve: address,
        repay_liquidity_amount: u64,
        withdraw_liquidity_amount: u64,
        burn_collateral_amount: u64,
        remaining_deposited_amount_obligation: u64,
        remaining_borrowed_amount_obligation_sf: u256,
        total_withdraw_reserve_supplied_sf: u256,
        total_withdraw_reserve_mint_collateral: u64,
        total_repay_reserve_supplied_sf: u256,
        total_repay_reserve_borrowed_sf: u256,
        new_repay_reserve_cumulative_borrow_rate_sf: u256,
        new_withdraw_reserve_cumulative_borrow_rate_sf: u256,
        has_debt: bool,
    }

    public fun add_reward_token_treasury<T0>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::operator::OperatorCap, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::token_reward_state::TokenRewardState, arg3: 0x2::coin::TreasuryCap<T0>) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::token_reward_state::add_reward_token_treasury<T0>(arg2, arg3);
    }

    public fun borrow_obligation_liquidity<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::ObligationOwnerCap<T0>, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::check_obligation_with_obligation_owner_cap<T0>(arg3, arg0);
        let (v0, v1, v2) = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::borrow_request<T0, T1>(arg3, arg2, arg4, arg5, arg6);
        let v3 = BorrowObligationLiquidityEvent{
            obligation_owner              : 0x2::tx_context::sender(arg6),
            reserve                       : 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>>(arg2),
            market_type                   : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::utils::get_type<T0>(),
            borrow_amount                 : arg4,
            total_reserve_borrowed_sf     : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::borrowed_amount<T0, T1>(arg2)),
            borrowed_amount_obligation_sf : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(v2),
            new_cumulative_borrow_rate_sf : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::cumulative_borrow_rate<T0, T1>(arg2)),
            has_debt                      : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::has_debt<T0>(arg3),
        };
        0x2::event::emit<BorrowObligationLiquidityEvent>(v3);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::get_coin_borrow_liquidity<T0, T1>(arg2, 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::available_amount<T0, T1>(arg2), v0, v1, arg5, arg6)
    }

    public fun calculate_liquidate<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::operator::OperatorCap, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::calculate_liquidate<T0, T1>(arg3, arg2, arg4)
    }

    public fun change_reward_config<T0, T1, T2>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::operator::OperatorCap, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: u64, arg4: u8, arg5: u64, arg6: u64) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reward_config::change_reward_config<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6);
    }

    public fun claim_reward<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg1: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::token_reward_state::TokenRewardState, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>, arg3: address, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg0);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::user_reward::claim_reward<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun deposit_ctokens_into_obligation<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::ObligationOwnerCap<T0>, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>, arg4: 0x2::coin::Coin<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::CToken<T0, T1>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::check_obligation_with_obligation_owner_cap<T0>(arg3, arg0);
        let (v0, v1, v2) = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::deposit_ctokens_into_obligation<T0, T1>(arg3, arg2, arg4, arg5, arg6);
        let v3 = 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>>(arg2);
        let v4 = DepositReserveAndObligationEvent{
            obligation_owner                       : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::owner<T0>(arg3),
            reserve                                : 0x2::object::id_to_address(&v3),
            deposit_amount                         : v0,
            mint_collateral_amount                 : v1,
            deposited_collateral_amount_obligation : v2,
            total_reserve_supplied                 : (0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::total_supply<T0, T1>(arg2)) as u128),
            total_reserve_mint_collateral          : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::mint_total_amount<T0, T1>(arg2),
            new_cumulative_borrow_rate_sf          : (0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::cumulative_borrow_rate<T0, T1>(arg2)) as u256),
            has_debt                               : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::has_debt<T0>(arg3),
        };
        0x2::event::emit<DepositReserveAndObligationEvent>(v4);
    }

    public fun deposit_reserve_liquidity_and_mint_ctokens<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg1: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::CToken<T0, T1>> {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg0);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::refresh_reserve<T0, T1>(arg1, arg3, arg4);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::deposit_reserve_liquidity_and_mint_ctokens<T0, T1>(arg1, arg2, arg4, arg5)
    }

    public fun init_market<T0>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::operator::OperatorCap, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market_registry::MarketRegistry, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        let v0 = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market::new<T0>(arg3, arg4);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market_registry::add_market<T0>(arg2, &v0);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market::public_share<T0>(v0);
    }

    public fun init_obligation<T0>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg1: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market::Market<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::ObligationOwnerCap<T0>, 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg0);
        let (v0, v1) = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::new<T0>(arg2, arg3, arg4);
        let v2 = v0;
        let v3 = 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>>(&v2);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market::add_user_obligation<T0>(arg1, arg2, 0x2::object::id_to_address(&v3));
        (v1, v2)
    }

    public fun init_reserve<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::operator::OperatorCap, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market::Market<T0>, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u16, arg8: u16, arg9: u16, arg10: u16, arg11: u16, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u16, arg18: u16, arg19: u128, arg20: u16, arg21: 0x1::string::String, arg22: u8, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: 0x1::option::Option<0x1::string::String>, arg30: 0x1::option::Option<0x1::string::String>, arg31: &0x2::clock::Clock, arg32: &mut 0x2::tx_context::TxContext) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        let v0 = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::new<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::market::add_reserve<T0, T1>(arg2, &v0);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::share_object<T0, T1>(v0);
    }

    public fun init_reward_config<T0, T1, T2>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::operator::OperatorCap, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reward_config::new<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun init_user_reward<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg1: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>, arg2: address, arg3: u8, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg0);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::user_reward::new<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun lock_to_liquidate<T0>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::operator::OperatorCap, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::lock_to_liquidate<T0>(arg2);
        let v0 = 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>>(arg2);
        let v1 = LockReserveEvent{
            owner      : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::owner<T0>(arg2),
            obligation : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<LockReserveEvent>(v1);
    }

    public fun refresh_obligation<T0, T1, T2, T3, T4>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg1: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>, arg2: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T2>, arg4: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T3>, arg5: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T4>, arg6: &0x2::clock::Clock) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg0);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::refresh_obligation<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun refresh_reserve<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg1: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg0);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::refresh_reserve<T0, T1>(arg1, arg2, arg3);
    }

    public fun repay_liquidate_reserve<T0, T1, T2>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::operator::OperatorCap, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T2>, arg4: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::repay_liquidate_reserve<T0, T2>(arg4, arg3, arg5, arg8, arg9);
        let v0 = 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>>(arg2);
        let v1 = 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T2>>(arg3);
        let v2 = 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>>(arg2);
        let v3 = 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T2>>(arg3);
        let v4 = LiquidationEvent{
            obligation_owner                               : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::owner<T0>(arg4),
            liquidate_reserve                              : 0x2::object::id_to_address(&v0),
            repay_reserve                                  : 0x2::object::id_to_address(&v1),
            repay_liquidity_amount                         : 0x2::coin::value<T2>(&arg5),
            withdraw_liquidity_amount                      : arg6,
            burn_collateral_amount                         : arg7,
            remaining_deposited_amount_obligation          : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::deposited_amount<T0>(arg4, 0x2::object::id_to_address(&v2)),
            remaining_borrowed_amount_obligation_sf        : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::borrowed_amount<T0>(arg4, 0x2::object::id_to_address(&v3))),
            total_withdraw_reserve_supplied_sf             : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::total_supply<T0, T1>(arg2)),
            total_withdraw_reserve_mint_collateral         : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::mint_total_amount<T0, T1>(arg2),
            total_repay_reserve_supplied_sf                : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::total_supply<T0, T2>(arg3)),
            total_repay_reserve_borrowed_sf                : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::borrowed_amount<T0, T2>(arg3)),
            new_repay_reserve_cumulative_borrow_rate_sf    : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::cumulative_borrow_rate<T0, T2>(arg3)),
            new_withdraw_reserve_cumulative_borrow_rate_sf : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::cumulative_borrow_rate<T0, T1>(arg2)),
            has_debt                                       : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::has_debt<T0>(arg4),
        };
        0x2::event::emit<LiquidationEvent>(v4);
    }

    public fun repay_obligation_liquidity<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::ObligationOwnerCap<T0>, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::check_obligation_with_obligation_owner_cap<T0>(arg3, arg0);
        let (v0, v1, v2) = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::repay_request<T0, T1>(arg3, arg2, arg4, arg5, arg6);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::repay_coin_liquidity<T0, T1>(arg2, 0x2::coin::split<T1>(arg4, 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::ceil(v0), arg7), 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::available_amount<T0, T1>(arg2), arg6);
        let v3 = RepayObligationLiquidityEvent{
            obligation_owner                        : 0x2::tx_context::sender(arg7),
            reserve                                 : 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>>(arg2),
            market_type                             : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::utils::get_type<T0>(),
            repay_amount                            : v1,
            total_reserve_supplied_sf               : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::total_supply<T0, T1>(arg2)),
            total_reserve_borrowed_sf               : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::borrowed_amount<T0, T1>(arg2)),
            remaining_borrowed_amount_obligation_sf : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(v2),
            new_cumulative_borrow_rate_sf           : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::cumulative_borrow_rate<T0, T1>(arg2)),
            has_debt                                : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::has_debt<T0>(arg3),
        };
        0x2::event::emit<RepayObligationLiquidityEvent>(v3);
    }

    public fun share_obligation<T0>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg1: 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg0);
        0x2::transfer::public_share_object<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>>(arg1);
    }

    public fun update_reserve_config<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::operator::OperatorCap, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: 0x1::option::Option<u16>, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<u16>, arg6: 0x1::option::Option<u16>, arg7: 0x1::option::Option<u16>, arg8: 0x1::option::Option<u16>, arg9: 0x1::option::Option<u16>, arg10: 0x1::option::Option<u16>, arg11: 0x1::option::Option<u16>, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<u64>, arg14: 0x1::option::Option<u64>, arg15: 0x1::option::Option<u64>, arg16: 0x1::option::Option<u64>, arg17: 0x1::option::Option<u16>, arg18: 0x1::option::Option<u16>, arg19: 0x1::option::Option<u128>, arg20: 0x1::option::Option<u16>, arg21: 0x1::option::Option<u64>, arg22: 0x1::option::Option<u64>, arg23: 0x1::option::Option<u64>, arg24: 0x1::option::Option<u64>, arg25: 0x1::option::Option<u64>, arg26: 0x1::option::Option<u64>, arg27: 0x1::option::Option<0x1::string::String>, arg28: 0x1::option::Option<0x1::string::String>) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::update_reserve_config<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28);
    }

    public fun update_reward_config<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg1: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg0);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reward_config::update_reward_config<T0, T1>(arg1, arg2, arg3);
    }

    public fun update_user_reward<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg1: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>, arg2: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg0);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::user_reward::update_user_reward<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun withdraw_ctoken_and_redeem_liquidity<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::ObligationOwnerCap<T0>, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::Obligation<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::check_obligation_with_obligation_owner_cap<T0>(arg3, arg0);
        let (v0, v1) = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::withdraw_ctoken_from_obligation<T0, T1>(arg3, arg2, arg4, arg5);
        let (v2, v3) = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::burn_ctokens_and_redeem_liquidity<T0, T1>(arg2, v0, arg5, arg6);
        let v4 = WithdrawObligationCollateralEvent{
            obligation_owner                      : 0x2::tx_context::sender(arg6),
            reserve                               : 0x2::object::id<0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>>(arg2),
            market_type                           : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::utils::get_type<T0>(),
            withdraw_amount                       : v3,
            burn_collateral_amount                : v0,
            remaining_deposited_amount_obligation : v1,
            remaining_reserve_supplied_sf         : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::total_supply<T0, T1>(arg2)),
            remaining_reserve_mint_collateral     : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::total_reserve_mint_collateral<T0, T1>(arg2),
            new_cumulative_borrow_rate_sf         : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::to_scaled_val(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::cumulative_borrow_rate<T0, T1>(arg2)),
            has_debt                              : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::obligation::has_debt<T0>(arg3),
        };
        0x2::event::emit<WithdrawObligationCollateralEvent>(v4);
        v2
    }

    public fun withdraw_protocol_fee<T0, T1>(arg0: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::operator::OperatorCap, arg1: &0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::Version, arg2: &mut 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::Reserve<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::version::assert_current_version(arg1);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::reserve::withdraw_protocol_fee<T0, T1>(arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

