module 0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::alphafi_navi_sui_stsui_investor {
    struct Investor<phantom T0> has store, key {
        id: 0x2::object::UID,
        navi_acc_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        free_rewards: 0x2::bag::Bag,
        tokensDeposited: u64,
        minimum_swap_amount: u64,
        loops: u64,
        current_debt_to_supply_ratio: u256,
        safe_borrow_percentage: u64,
        performance_fee: u64,
        max_cap_performance_fee: u64,
    }

    struct RewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        location: u64,
    }

    struct CheckRatio has copy, drop {
        ratio: u256,
    }

    struct AutoCompoundingEvent has copy, drop {
        investor_id: 0x2::object::ID,
        compound_amount: u64,
        total_amount: u64,
        cur_total_debt: u64,
        accrued_interest: u64,
        fee_collected: u64,
        location: u64,
    }

    struct StsuiSuiPriceChangeEvent has copy, drop {
        stsui_price: u64,
        sui_price: u64,
    }

    struct DebugNewEvent has copy, drop {
        a: u256,
        b: u256,
        location: u64,
    }

    fun borrow(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg4 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) as u128);
        let v1 = (v0 * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) as u128) + ((0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) - 1) as u128)) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) as u128);
        let v2 = (v1 as u64) + ((((v1 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::flash_stake_fee_bps(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::fee_config<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2)) as u128) + 9999) / 10000) as u64);
        if (v0 > 0 && v2 > 0) {
            let (v3, v4) = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::flash_stake_start<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg3, (v0 as u64), arg6);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), 2, v3, arg5, arg6);
            let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::flash_stake_conclude<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow<0x2::sui::SUI>(arg1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), 1, (v2 as u64), arg5, arg6), arg3, arg5, arg6), v4, arg6));
            update_free_rewards<0x2::sui::SUI>(arg0, v5);
        };
    }

    public fun admin_borrow(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::assert_current_version(arg1);
        autocompound(arg2, arg4, arg5, arg6, arg7, arg8, arg9);
        borrow(arg2, arg5, arg6, arg7, arg3, arg8, arg9);
        let v0 = get_total_invested(arg2, arg5, arg8);
        arg2.tokensDeposited = v0;
        let v1 = get_total_borrowed(arg2, arg5, arg8);
        update_debt_in_df(arg2, (v1 as u256));
        let v2 = (v1 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg6) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg6) as u128);
        let (_, v4) = get_borrow_percentage(arg2, arg5, arg8);
        assert!((v2 as u256) < v4, 0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::error::high_debt());
        arg2.current_debt_to_supply_ratio = (((v2 as u256) * 100000000000000000000 / (v0 as u256)) as u256);
        let v5 = DebugNewEvent{
            a        : (arg2.current_debt_to_supply_ratio as u256),
            b        : (v0 as u256),
            location : 50,
        };
        0x2::event::emit<DebugNewEvent>(v5);
    }

    public fun admin_repay<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg16: &mut 0x3::sui_system::SuiSystemState, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg19: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun admin_repay_v2(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun admin_repay_v3(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::assert_current_version(arg1);
        let v0 = get_total_borrowed(arg2, arg5, arg8);
        assert!(arg3 <= v0, 0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::error::repay_amount_more_than_debt());
        autocompound(arg2, arg4, arg5, arg6, arg7, arg8, arg9);
        repay_to_alphalend(arg2, arg5, arg6, arg7, arg3, arg8, arg9);
        let v1 = get_total_invested(arg2, arg5, arg8);
        assert!(v1 > 0, 999999999);
        arg2.tokensDeposited = v1;
        let v2 = get_total_borrowed(arg2, arg5, arg8);
        update_debt_in_df(arg2, (v2 as u256));
        if (v2 == 0) {
            arg2.loops = 0;
        };
        arg2.current_debt_to_supply_ratio = (((v2 as u256) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg6) as u256) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg6) as u256) * 100000000000000000000 / (v1 as u256)) as u256);
        let v3 = DebugNewEvent{
            a        : (arg2.current_debt_to_supply_ratio as u256),
            b        : (v1 as u256),
            location : 50,
        };
        0x2::event::emit<DebugNewEvent>(v3);
    }

    public(friend) fun autocompound(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested(arg0, arg2, arg5);
        if (v0 == 0) {
            return
        };
        let v1 = v0 - arg0.tokensDeposited;
        let v2 = 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>();
        if (v1 > 0) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v2, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), 2, v1, arg5), arg5, arg6)));
        };
        let v3 = RewardEvent{
            coin_type : 0x1::type_name::get<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
            amount    : v1,
            location  : 30,
        };
        0x2::event::emit<RewardEvent>(v3);
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<0x2::sui::SUI>(arg2, 2, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), arg5, arg6);
        let v6 = v4;
        0x2::coin::join<0x2::sui::SUI>(&mut v6, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, v5, arg4, arg5, arg6));
        let (v7, v8) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<0x2::sui::SUI>(arg2, 1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), arg5, arg6);
        0x2::coin::join<0x2::sui::SUI>(&mut v6, v7);
        0x2::coin::join<0x2::sui::SUI>(&mut v6, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, v8, arg4, arg5, arg6));
        if (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::sui_to_lst_mint_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg3, 0x2::coin::value<0x2::sui::SUI>(&v6)) > 0) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v2, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg3, arg4, v6, arg6)));
        } else {
            update_free_rewards<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v6));
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>()) == true) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v2, 0x2::balance::withdraw_all<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>())));
        };
        let v9 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"debt") == true) {
            *0x2::dynamic_field::borrow<vector<u8>, u256>(&arg0.id, b"debt")
        } else {
            0
        };
        let v10 = get_total_borrowed(arg0, arg2, arg5);
        let v11 = 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v2);
        let v12 = (((v10 as u64) - (v9 as u64)) as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg3) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg3) as u128);
        let v13 = if (v11 > (v12 as u64)) {
            ((v11 - (v12 as u64)) as u128) * (arg0.performance_fee as u128) / 10000
        } else {
            0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::balance::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v2, (v13 as u64)), arg6), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg1));
        let v14 = get_total_invested(arg0, arg2, arg5);
        let v15 = AutoCompoundingEvent{
            investor_id      : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount  : v11,
            total_amount     : v14,
            cur_total_debt   : (((v9 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg3) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg3) as u128)) as u64),
            accrued_interest : (v12 as u64),
            fee_collected    : (v13 as u64),
            location         : 1,
        };
        0x2::event::emit<AutoCompoundingEvent>(v15);
        if (0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v2) > 0) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), 2, 0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v2, arg6), arg5, arg6);
        } else {
            0x2::balance::destroy_zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v2);
        };
        arg0.tokensDeposited = get_total_invested(arg0, arg2, arg5);
    }

    public(friend) fun autocompound_old(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg2, arg4, 20, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>()) == true) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v1, 0x2::balance::withdraw_all<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>())));
        };
        let v2 = v0 - arg0.tokensDeposited;
        if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg5, v2) > 0) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg3, arg4, arg5, 20, v2, arg7, arg6, &arg0.navi_acc_cap));
        };
        let v3 = RewardEvent{
            coin_type : 0x1::type_name::get<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(),
            amount    : v2,
            location  : 30,
        };
        0x2::event::emit<RewardEvent>(v3);
        let v4 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"debt") == true) {
            *0x2::dynamic_field::borrow<vector<u8>, u256>(&arg0.id, b"debt")
        } else {
            0
        };
        let v5 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg2, arg4, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
        let v6 = 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v1);
        let v7 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::sui_to_lst_mint_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8, (v5 as u64) - (v4 as u64));
        let v8 = if (v6 > v7) {
            ((v6 - v7) as u128) * (arg0.performance_fee as u128) / 10000
        } else {
            0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::balance::split<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v1, (v8 as u64)), arg9), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::get_fee_wallet_address(arg1));
        let v9 = AutoCompoundingEvent{
            investor_id      : 0x2::object::uid_to_inner(&arg0.id),
            compound_amount  : 0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v1),
            total_amount     : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg2, arg4, 20, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64),
            cur_total_debt   : (((v5 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg8) as u128)) as u64),
            accrued_interest : v7,
            fee_collected    : (v8 as u64),
            location         : 1,
        };
        0x2::event::emit<AutoCompoundingEvent>(v9);
        if (0x2::balance::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v1) > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg4, arg5, 20, 0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v1, arg9), arg7, arg6, &arg0.navi_acc_cap);
        } else {
            0x2::balance::destroy_zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v1);
        };
        arg0.tokensDeposited = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg2, arg4, 20, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64);
    }

    public fun change_loops_and_autocompound<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg16: &mut 0x3::sui_system::SuiSystemState, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg19: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun change_loops_and_autocompound_V2(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun change_safe_borrow(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64) {
        0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::assert_current_version(arg1);
        assert!(arg3 <= 9500, 0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::error::high_safe_borrow());
        arg2.safe_borrow_percentage = arg3;
    }

    public fun change_safe_borrow_and_autocompound<T0>(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg16: &mut 0x3::sui_system::SuiSystemState, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg19: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg20: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun change_safe_borrow_and_autocompound_v2(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::AdminCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64, arg4: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun check_and_set_asset_ltv(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol) {
        let v0 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg1, 2) as u256);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, u256>(&mut arg0.id, b"asset_ltv");
        if (v0 != *v1) {
            let v2 = DebugNewEvent{
                a        : (v0 as u256),
                b        : (*v1 as u256),
                location : 38888,
            };
            0x2::event::emit<DebugNewEvent>(v2);
            *v1 = v0;
        };
    }

    public(friend) fun check_price_and_fix_health(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg1, 2);
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg1, 1);
        let v2 = DebugNewEvent{
            a        : (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u128(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(10000))) as u256),
            b        : (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u128(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(10000))) as u256),
            location : 10,
        };
        0x2::event::emit<DebugNewEvent>(v2);
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::lt(v0, v1)) {
            let v3 = StsuiSuiPriceChangeEvent{
                stsui_price : (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u128(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(10000))) as u64),
                sui_price   : (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u128(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(10000))) as u64),
            };
            0x2::event::emit<StsuiSuiPriceChangeEvent>(v3);
            let v4 = get_total_borrowed(arg0, arg1, arg4);
            let (_, v6) = get_borrow_percentage(arg0, arg1, arg4);
            if (!0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::le(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v4), v1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128((v6 as u128)), v1))) {
                repay_to_alphalend(arg0, arg1, arg2, arg3, v4, arg4, arg5);
            };
        };
    }

    public(friend) fun collect_reward_with_no_swap(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested(arg0, arg1, arg2);
        if (v0 == 0) {
            return
        };
        let (v1, v2) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, 2, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), arg2, arg3);
        let v3 = v1;
        0x2::coin::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, v2, arg2, arg3));
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, 1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), arg2, arg3);
        0x2::coin::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v3, v4);
        0x2::coin::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, v5, arg2, arg3));
        update_free_rewards<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg0, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v3));
    }

    public(friend) fun collect_reward_with_no_swap_old(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>) {
        if ((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg1, arg2, 20, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64) == 0) {
            return
        };
        let (v0, v1, _, _, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg1, arg2, arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap)));
        let v5 = v4;
        let v6 = v1;
        let v7 = v0;
        let v8 = 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            if (*0x1::vector::borrow<0x1::ascii::String>(&v6, v9) == 0x1::type_name::into_string(0x1::type_name::get<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>())) {
                let v10 = 0x1::vector::empty<0x1::ascii::String>();
                0x1::vector::push_back<0x1::ascii::String>(&mut v10, *0x1::vector::borrow<0x1::ascii::String>(&v7, v9));
                0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v8, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, arg3, arg2, arg4, v10, *0x1::vector::borrow<vector<address>>(&v5, v9), &arg0.navi_acc_cap));
            };
            v9 = v9 + 1;
        };
        update_free_rewards<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg0, v8);
    }

    public(friend) fun collect_reward_with_one_swap_bluefin<T0>(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested(arg0, arg1, arg4);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>();
        let v2 = 0x2::balance::zero<T0>();
        let (v3, v4) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg1, 2, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), arg4, arg5);
        let v5 = v3;
        0x2::coin::join<T0>(&mut v5, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, v4, arg4, arg5));
        let (v6, v7) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg1, 1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), arg4, arg5);
        0x2::coin::join<T0>(&mut v5, v6);
        0x2::coin::join<T0>(&mut v5, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, v7, arg4, arg5));
        0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v5));
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(&mut v2, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>())));
        };
        let v8 = 0x2::balance::value<T0>(&v2);
        if (v8 >= arg0.minimum_swap_amount) {
            let (v9, _) = get_bluefin_sqrt_price_limits<T0, 0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2);
            let (v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg4, arg3, arg2, v2, 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(), true, true, v8, 0, v9);
            0x2::balance::destroy_zero<T0>(v11);
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v1, v12);
        } else {
            update_free_rewards<T0>(arg0, v2);
        };
        update_free_rewards<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg0, v1);
    }

    public(friend) fun collect_reward_with_two_swaps<T0>(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested(arg0, arg1, arg6);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>();
        let v2 = 0x2::balance::zero<T0>();
        let (v3, v4) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg1, 2, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), arg6, arg7);
        let v5 = v3;
        0x2::coin::join<T0>(&mut v5, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, v4, arg6, arg7));
        let (v6, v7) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg1, 1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), arg6, arg7);
        0x2::coin::join<T0>(&mut v5, v6);
        0x2::coin::join<T0>(&mut v5, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg1, v7, arg6, arg7));
        0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v5));
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(&mut v2, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>())));
        };
        let v8 = 0x2::balance::zero<0x2::sui::SUI>();
        let v9 = 0x2::balance::value<T0>(&v2);
        if (v9 >= arg0.minimum_swap_amount) {
            let (v10, v11) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_a2b<T0, 0x2::sui::SUI>(arg5, arg4, 0x2::coin::from_balance<T0>(v2, arg7), true, v9, arg6, arg7);
            0x2::coin::destroy_zero<T0>(v10);
            0x2::balance::join<0x2::sui::SUI>(&mut v8, 0x2::coin::into_balance<0x2::sui::SUI>(v11));
        } else {
            update_free_rewards<T0>(arg0, v2);
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>()) == true) {
            0x2::balance::join<0x2::sui::SUI>(&mut v8, 0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>())));
        };
        if (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::sui_to_lst_mint_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, 0x2::balance::value<0x2::sui::SUI>(&v8)) > 0) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v1, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v8, arg7), arg7)));
        } else {
            update_free_rewards<0x2::sui::SUI>(arg0, v8);
        };
        update_free_rewards<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg0, v1);
    }

    public(friend) fun collect_reward_with_two_swaps_old<T0>(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x2::tx_context::TxContext) {
        if ((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg1, arg2, 20, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64) == 0) {
            return
        };
        let v0 = 0x2::balance::zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>();
        let v1 = 0x2::balance::zero<T0>();
        let (v2, v3, _, _, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg1, arg2, arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap)));
        let v7 = v6;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0;
        let v11 = 0x1::vector::empty<0x1::ascii::String>();
        let v12 = vector[];
        while (v10 < 0x1::vector::length<0x1::ascii::String>(&v8)) {
            if (*0x1::vector::borrow<0x1::ascii::String>(&v8, v10) == 0x1::type_name::into_string(0x1::type_name::get<T0>())) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v11, *0x1::vector::borrow<0x1::ascii::String>(&v9, v10));
                0x1::vector::append<address>(&mut v12, *0x1::vector::borrow<vector<address>>(&v7, v10));
            };
            v10 = v10 + 1;
        };
        0x2::balance::join<T0>(&mut v1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg1, arg3, arg2, arg4, v11, v12, &arg0.navi_acc_cap));
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(&mut v1, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>())));
        };
        let v13 = 0x2::balance::zero<0x2::sui::SUI>();
        let v14 = 0x2::balance::value<T0>(&v1);
        if (v14 >= arg0.minimum_swap_amount) {
            let (v15, v16) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_a2b<T0, 0x2::sui::SUI>(arg8, arg7, 0x2::coin::from_balance<T0>(v1, arg9), true, v14, arg1, arg9);
            0x2::coin::destroy_zero<T0>(v15);
            0x2::balance::join<0x2::sui::SUI>(&mut v13, 0x2::coin::into_balance<0x2::sui::SUI>(v16));
        } else {
            update_free_rewards<T0>(arg0, v1);
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>()) == true) {
            0x2::balance::join<0x2::sui::SUI>(&mut v13, 0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0x2::sui::SUI>())));
        };
        if (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::sui_to_lst_mint_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg5, 0x2::balance::value<0x2::sui::SUI>(&v13)) > 0) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v0, 0x2::coin::into_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg5, arg6, 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg9), arg9)));
        } else {
            update_free_rewards<0x2::sui::SUI>(arg0, v13);
        };
        update_free_rewards<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg0, v0);
    }

    public fun create_investor(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: u64, arg3: u64, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0x2::tx_context::TxContext) {
        0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::assert_current_version(arg1);
        let v0 = Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>{
            id                           : 0x2::object::new(arg5),
            navi_acc_cap                 : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg5),
            free_rewards                 : 0x2::bag::new(arg5),
            tokensDeposited              : 0,
            minimum_swap_amount          : 1000,
            loops                        : arg2,
            current_debt_to_supply_ratio : 0,
            safe_borrow_percentage       : arg3,
            performance_fee              : 2000,
            max_cap_performance_fee      : 5000,
        };
        0x2::dynamic_field::add<vector<u8>, u256>(&mut v0.id, b"asset_ltv", 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg4, 20));
        0x2::transfer::public_share_object<Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(v0);
    }

    public(friend) fun deposit(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"position_cap"), 293929);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), 2, arg4, arg5, arg6);
        let v0 = (((((0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&arg4) as u256) * arg0.current_debt_to_supply_ratio / (100000000000000000000 - arg0.current_debt_to_supply_ratio)) as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) as u128)) as u64);
        borrow(arg0, arg1, arg2, arg3, v0, arg5, arg6);
        let v1 = get_total_invested(arg0, arg1, arg5);
        arg0.tokensDeposited = v1;
        let v2 = (get_total_borrowed(arg0, arg1, arg5) as u256);
        update_debt_in_df(arg0, v2);
    }

    public(friend) fun deposit_sui(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg3, arg4, arg6);
        if (0x2::coin::value<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&v0) > 0) {
            deposit(arg0, arg1, arg2, arg3, v0, arg5, arg6);
        } else {
            0x2::coin::destroy_zero<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v0);
        };
    }

    public fun emergency_repay(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::EmergencyCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u256, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::assert_current_version(arg1);
        let v0 = get_total_invested(arg2, arg4, arg7);
        let v1 = get_total_borrowed(arg2, arg4, arg7);
        if (v0 == 0 || v1 == 0) {
            return
        };
        let v2 = (((v1 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg5) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg5) as u128)) as u256);
        let (v3, v4) = get_borrow_percentage(arg2, arg4, arg7);
        let v5 = DebugNewEvent{
            a        : v3 - arg3 * 1000000 / 10000,
            b        : v3,
            location : 99,
        };
        0x2::event::emit<DebugNewEvent>(v5);
        if (v2 >= v4) {
            let v6 = (v3 - arg3 * 1000000 / 10000) * 100000000000000;
            if (v6 * (v0 as u256) < v2 * 100000000000000000000) {
                let v7 = (((((v2 * 100000000000000000000 - v6 * (v0 as u256)) / (100000000000000000000 - v6)) as u256) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg5) as u256) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg5) as u256)) as u64);
                repay_to_alphalend(arg2, arg4, arg5, arg6, v7, arg7, arg8);
                let v8 = get_total_invested(arg2, arg4, arg7);
                arg2.tokensDeposited = v8;
                let v9 = get_total_borrowed(arg2, arg4, arg7);
                update_debt_in_df(arg2, (v9 as u256));
                arg2.current_debt_to_supply_ratio = ((((((v9 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg5) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg5) as u128)) as u64) as u256) * 100000000000000000000 / (arg2.tokensDeposited as u256)) as u256);
            };
        };
    }

    public(friend) fun fix_ratio(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &0x2::clock::Clock) {
        let v0 = get_total_invested(arg0, arg1, arg3);
        arg0.tokensDeposited = v0;
        if ((arg0.tokensDeposited as u64) == 0) {
            return
        };
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, 1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap")), arg3);
        update_debt_in_df(arg0, (v1 as u256));
        let v2 = (v1 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) as u128);
        arg0.current_debt_to_supply_ratio = (((v2 as u256) * 100000000000000000000 / (arg0.tokensDeposited as u256)) as u256);
        let v3 = CheckRatio{ratio: (((v2 as u256) * 100000000000000000000 / (arg0.tokensDeposited as u256)) as u256)};
        0x2::event::emit<CheckRatio>(v3);
    }

    fun get_bluefin_sqrt_price_limits<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u128, u128) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = if (v0 >= 100 && v0 <= 500) {
            v1 * 999499874 / 1000000000
        } else if (v0 > 500 && v0 <= 2500) {
            v1 * 997496867 / 1000000000
        } else if (v0 > 2500 && v0 <= 10000) {
            v1 * 992471662 / 1000000000
        } else {
            v1 * 987420882 / 1000000000
        };
        let v3 = if (v0 >= 100 && v0 <= 500) {
            v1 * 1000499875 / 1000000000
        } else if (v0 > 500 && v0 <= 2500) {
            v1 * 1002496882 / 1000000000
        } else if (v0 > 2500 && v0 <= 10000) {
            v1 * 1007472083 / 1000000000
        } else {
            v1 * 1012422836 / 1000000000
        };
        (v2, v3)
    }

    public(friend) fun get_borrow_percentage(arg0: &Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : (u256, u256) {
        let v0 = get_total_invested(arg0, arg1, arg2);
        let v1 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg1, 2) as u256) * (arg0.safe_borrow_percentage as u256);
        (v1, (v0 as u256) * v1 / 1000000)
    }

    public(friend) fun get_total_borrowed(arg0: &Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : u64 {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, 1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap")), arg2)
    }

    public(friend) fun get_total_invested(arg0: &Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : u64 {
        (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg1, 2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap")), arg2) as u64)
    }

    public(friend) fun has_unclaimed_rewards(arg0: &Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_claimable_rewards(arg1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), arg2);
        0x1::vector::length<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward>(&v0) > 0
    }

    public(friend) fun migrate_to_alphalend(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"position_cap"), 87878787);
        let v0 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg10, arg5, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64);
        repay_to_navi(arg0, arg10, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg2, arg3, arg11);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg10, arg4, arg5, arg6, 20, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg10, arg5, 20, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u64), arg9, arg8, &arg0.navi_acc_cap);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>()) == true) {
            0x2::balance::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(&mut v1, 0x2::balance::withdraw_all<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(&mut arg0.free_rewards, 0x1::type_name::get<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>())));
        };
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"asset_ltv"), 9898111);
        *0x2::dynamic_field::borrow_mut<vector<u8>, u256>(&mut arg0.id, b"asset_ltv") = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg1, 2) as u256);
        0x2::dynamic_field::add<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&mut arg0.id, b"position_cap", 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg1, arg11));
        let v2 = 0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v1, arg11);
        deposit(arg0, arg1, arg2, arg3, v2, arg10, arg11);
    }

    public(friend) fun repay_to_alphalend(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4 == 0) {
            return
        };
        let v0 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_safe_collateral_ratio(arg1, 2) as u256) * 9500;
        while (arg4 > 0) {
            let v1 = get_total_borrowed(arg0, arg1, arg5);
            let v2 = get_total_invested(arg0, arg1, arg5);
            let v3 = (v2 as u256) * v0 / 1000000 - (v1 as u256);
            let v4 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::lst_to_sui_redemption_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, (v3 as u64));
            let v5 = if (v4 <= arg4) {
                0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), 2, (v3 as u64), arg5), arg5, arg6)
            } else {
                let v6 = ((arg4 as u128) * (v3 as u128) + ((v4 - 1) as u128)) / (v4 as u128);
                let v7 = v6;
                let v8 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::lst_to_sui_redemption_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, (v6 as u64));
                if (arg4 >= v8) {
                    v7 = v6 + ((arg4 - v8 + 2) as u128);
                };
                0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), 2, (v7 as u64), arg5), arg5, arg6)
            };
            let v9 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, v5, arg3, arg6);
            let v10 = DebugNewEvent{
                a        : (v4 as u256),
                b        : (0x2::coin::value<0x2::sui::SUI>(&v9) as u256),
                location : 235478,
            };
            0x2::event::emit<DebugNewEvent>(v10);
            let v11 = 0x1::u64::min(arg4, 0x2::coin::value<0x2::sui::SUI>(&v9));
            arg4 = arg4 - v11;
            let v12 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::repay<0x2::sui::SUI>(arg1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), 1, v9, arg5, arg6);
            if (0x2::coin::value<0x2::sui::SUI>(&v12) > 0) {
                update_free_rewards<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v12));
                continue
            };
            0x2::coin::destroy_zero<0x2::sui::SUI>(v12);
        };
    }

    public(friend) fun repay_to_navi(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg6 == 0) {
            return
        };
        while (arg6 > 0) {
            let v0 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_collateral_balance(arg1, arg3, 20, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true) as u256) * (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg3, 20) as u256) * 9500 / 10000000000000000000000000000000 - 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_user_loan_balance(arg1, arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc_cap), 0, true);
            let v1 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::lst_to_sui_redemption_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9, (v0 as u64));
            let v2 = if (v1 <= arg6) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, arg2, arg3, arg4, 20, (v0 as u64), arg8, arg7, &arg0.navi_acc_cap)
            } else {
                let v3 = ((arg6 as u128) * (v0 as u128) + ((v1 - 1) as u128)) / (v1 as u128);
                let v4 = v3;
                let v5 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::lst_to_sui_redemption_price<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9, (v3 as u64));
                if (arg6 >= v5) {
                    v4 = v3 + ((arg6 - v5 + 2) as u128);
                };
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, arg2, arg3, arg4, 20, (v4 as u64), arg8, arg7, &arg0.navi_acc_cap)
            };
            let v6 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg9, 0x2::coin::from_balance<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(v2, arg11), arg10, arg11);
            let v7 = 0x1::u64::min(arg6, 0x2::coin::value<0x2::sui::SUI>(&v6));
            arg6 = arg6 - v7;
            let v8 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<0x2::sui::SUI>(arg1, arg2, arg3, arg5, 0, v6, arg8, arg7, &arg0.navi_acc_cap);
            if (0x2::balance::value<0x2::sui::SUI>(&v8) > 0) {
                update_free_rewards<0x2::sui::SUI>(arg0, v8);
                continue
            };
            0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        };
    }

    entry fun set_minimum_swap_amount(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64) {
        0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::assert_current_version(arg1);
        arg2.minimum_swap_amount = arg3;
    }

    entry fun set_performance_fee(arg0: &0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::distributor::DevCap, arg1: &0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::Version, arg2: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: u64) {
        0xe516e0c12e56619c196fa0ee28d57e5e4ca532bd39df79bee9dcd1e3946119ec::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.max_cap_performance_fee, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg2.performance_fee = arg3;
    }

    public(friend) fun total_supplied_without_debt(arg0: &Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = get_total_invested(arg0, arg1, arg3);
        let v1 = (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, 1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap")), arg3) as u64);
        let v2 = (v0 as u128) * (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) as u128) / (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2) as u128);
        let v3 = DebugNewEvent{
            a        : (v2 as u256),
            b        : (v1 as u256),
            location : 71,
        };
        0x2::event::emit<DebugNewEvent>(v3);
        (v2 as u64) - v1
    }

    fun update_debt_in_df(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: u256) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"debt") == true) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u256>(&mut arg0.id, b"debt") = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u256>(&mut arg0.id, b"debt", arg1);
        };
    }

    public(friend) fun update_free_rewards<T0>(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::get<T0>()) == true) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_rewards, 0x1::type_name::get<T0>(), arg1);
        };
    }

    public(friend) fun withdraw_from_alphalend(arg0: &mut Investor<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_total_invested(arg0, arg1, arg6);
        let v1 = (arg4 as u256) * (v0 as u256) / (arg5 as u256);
        let v2 = get_total_borrowed(arg0, arg1, arg6);
        let v3 = DebugNewEvent{
            a        : (arg4 as u256),
            b        : (arg5 as u256),
            location : 38,
        };
        0x2::event::emit<DebugNewEvent>(v3);
        repay_to_alphalend(arg0, arg1, arg2, arg3, (((arg4 as u256) * (v2 as u256) / (arg5 as u256)) as u64), arg6, arg7);
        let v4 = get_total_invested(arg0, arg1, arg6);
        let v5 = (v1 as u64) - v0 - v4;
        let v6 = DebugNewEvent{
            a        : (v1 as u256),
            b        : (v5 as u256),
            location : 40,
        };
        0x2::event::emit<DebugNewEvent>(v6);
        let v7 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg1, 0x2::dynamic_field::borrow<vector<u8>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.id, b"position_cap"), 2, (v5 as u64), arg6), arg6, arg7);
        let v8 = get_total_invested(arg0, arg1, arg6);
        arg0.tokensDeposited = v8;
        let v9 = (get_total_borrowed(arg0, arg1, arg6) as u256);
        update_debt_in_df(arg0, v9);
        0x2::coin::into_balance<0x2::sui::SUI>(0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, v7, arg3, arg7))
    }

    // decompiled from Move bytecode v6
}

