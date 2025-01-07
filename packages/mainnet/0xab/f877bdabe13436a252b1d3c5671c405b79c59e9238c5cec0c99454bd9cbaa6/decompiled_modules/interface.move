module 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::interface {
    struct LeveragedActionCap {
        leveraged_afsui_position_id: 0x2::object::ID,
        action_type: u8,
        initial_base_afsui_collateral: u64,
        initial_total_afsui_collateral: u64,
        initial_total_sui_debt: u64,
    }

    fun afsui_collateral(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : u64 {
        if (0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::contains<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::ObligationCollaterals, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_collaterals::Collateral>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collaterals(arg0), 0x1::type_name::get<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>())) {
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg0, 0x1::type_name::get<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>())
        } else {
            0
        }
    }

    public(friend) fun assert_correct_position(arg0: &0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition, arg1: 0x2::object::ID) {
        assert!(0x2::object::id<0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition>(arg0) == arg1, 0);
    }

    public fun borrow_sui(arg0: &mut LeveragedActionCap, arg1: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition, arg2: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: u64, arg8: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::assert_protocol_version(arg2);
        assert_correct_position(arg1, arg0.leveraged_afsui_position_id);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg4, 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::obligation_key(arg1));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<0x2::sui::SUI>(arg3, arg4, 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::obligation_key_mut(arg1), arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun complete_action(arg0: LeveragedActionCap, arg1: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition, arg2: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg5: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg6: &mut 0x2::tx_context::TxContext) {
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::assert_protocol_version(arg2);
        let LeveragedActionCap {
            leveraged_afsui_position_id    : v0,
            action_type                    : v1,
            initial_base_afsui_collateral  : v2,
            initial_total_afsui_collateral : v3,
            initial_total_sui_debt         : v4,
        } = arg0;
        assert_correct_position(arg1, v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg3, 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::obligation_key(arg1));
        let v5 = afsui_collateral(arg3);
        let v6 = sui_debt(arg3);
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::update_position(arg1, v5, v6);
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::increase_state_counters(arg2, v5, v6);
        if (v1 == 0) {
            0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::events::emit_staked_event(0x2::tx_context::sender(arg6), 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::base_afsui_collateral(arg1) - v2, 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::calculations::leverage_ratio(arg4, arg5, v5, v6));
        } else if (v1 == 1) {
            0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::events::emit_unstaked_event(0x2::tx_context::sender(arg6), v2 - 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::base_afsui_collateral(arg1));
        } else if (v1 == 2) {
            0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::events::emit_changed_leverage_event(0x2::tx_context::sender(arg6), 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::calculations::leverage_ratio(arg4, arg5, v3, v4), 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::calculations::leverage_ratio(arg4, arg5, v5, v6));
        };
    }

    fun create_leveraged_action_cap(arg0: &0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition, arg1: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::LeveragedAfSuiState, arg2: u8) : LeveragedActionCap {
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::assert_protocol_version(arg1);
        let v0 = 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::total_afsui_collateral(arg0);
        let v1 = 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::total_sui_debt(arg0);
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::decrease_state_counters(arg1, v0, v1);
        LeveragedActionCap{
            leveraged_afsui_position_id    : 0x2::object::id<0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition>(arg0),
            action_type                    : arg2,
            initial_base_afsui_collateral  : 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::base_afsui_collateral(arg0),
            initial_total_afsui_collateral : v0,
            initial_total_sui_debt         : v1,
        }
    }

    public fun deposit_afsui_collateral(arg0: &mut LeveragedActionCap, arg1: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition, arg2: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::assert_protocol_version(arg2);
        assert_correct_position(arg1, arg0.leveraged_afsui_position_id);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg4, 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::obligation_key(arg1));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg3, arg4, arg5, arg6, arg7);
    }

    public fun initiate_change_leverage(arg0: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition, arg1: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::LeveragedAfSuiState) : LeveragedActionCap {
        create_leveraged_action_cap(arg0, arg1, 2)
    }

    public fun initiate_leverage_stake(arg0: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition, arg1: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::LeveragedAfSuiState, arg2: &0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>) : LeveragedActionCap {
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::increase_base_afsui_collateral(arg0, 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg2));
        create_leveraged_action_cap(arg0, arg1, 0)
    }

    public fun initiate_leverage_unstake(arg0: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition, arg1: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::LeveragedAfSuiState, arg2: u64) : LeveragedActionCap {
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::decrease_base_afsui_collateral(arg0, arg2);
        create_leveraged_action_cap(arg0, arg1, 1)
    }

    public fun repay_sui(arg0: &mut LeveragedActionCap, arg1: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition, arg2: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::assert_protocol_version(arg2);
        assert_correct_position(arg1, arg0.leveraged_afsui_position_id);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg4, 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::obligation_key(arg1));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun sui_debt(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : u64 {
        if (0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::contains<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::ObligationDebts, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_debts::Debt>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debts(arg0), 0x1::type_name::get<0x2::sui::SUI>())) {
            let (v1, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, 0x1::type_name::get<0x2::sui::SUI>());
            v1
        } else {
            0
        }
    }

    public fun withdraw_afsui_collateral(arg0: &mut LeveragedActionCap, arg1: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::LeveragedAfSuiPosition, arg2: &mut 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: u64, arg8: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state::assert_protocol_version(arg2);
        assert_correct_position(arg1, arg0.leveraged_afsui_position_id);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg4, 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::obligation_key(arg1));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg3, arg4, 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_position::obligation_key_mut(arg1), arg5, arg6, arg7, arg8, arg9, arg10)
    }

    // decompiled from Move bytecode v6
}

