module 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::interface {
    struct LeveragedActionCap {
        leveraged_afsui_position: 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::LeveragedAfSuiPosition,
        end_position_metadata: 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::PositionMetadata,
    }

    public fun borrow_sui(arg0: &mut LeveragedActionCap, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: u64, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::assert_protocol_version(arg1);
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<0x2::sui::SUI>(arg2, arg3, 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::obligation_key_mut(&mut arg0.leveraged_afsui_position), arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::increase_total_sui_debt(&mut arg0.end_position_metadata, v1);
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::increase_total_sui_debt(arg1, v1);
        v0
    }

    public fun complete_change_leverage(arg0: LeveragedActionCap, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState, arg2: &mut 0x2::tx_context::TxContext) {
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::assert_protocol_version(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let LeveragedActionCap {
            leveraged_afsui_position : v1,
            end_position_metadata    : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::events::emit_changed_leverage_event(v0, 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::leverage_ratio(&v4), 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::leverage_ratio(&v3));
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::set_position_metadata(&mut v4, v3);
        0x2::transfer::public_transfer<0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::LeveragedAfSuiPosition>(v4, v0);
    }

    public fun complete_leverage_stake(arg0: LeveragedActionCap, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState, arg2: &mut 0x2::tx_context::TxContext) {
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::assert_protocol_version(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let LeveragedActionCap {
            leveraged_afsui_position : v1,
            end_position_metadata    : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::events::emit_staked_event(v0, 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::base_afsui_collateral(&v3) - 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::base_afsui_collateral(&v4), 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::utils::calc_leverage_ratio(0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::afsui_collateral(&v3) - 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::afsui_collateral(&v4), 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::sui_debt(&v3) - 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::sui_debt(&v4)));
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::set_position_metadata(&mut v4, v3);
        0x2::transfer::public_transfer<0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::LeveragedAfSuiPosition>(v4, v0);
    }

    public fun complete_leverage_unstake(arg0: LeveragedActionCap, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState, arg2: &mut 0x2::tx_context::TxContext) {
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::assert_protocol_version(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let LeveragedActionCap {
            leveraged_afsui_position : v1,
            end_position_metadata    : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::events::emit_unstaked_event(v0, 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::base_afsui_collateral(&v4) - 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::base_afsui_collateral(&v3));
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::set_position_metadata(&mut v4, v3);
        0x2::transfer::public_transfer<0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::LeveragedAfSuiPosition>(v4, v0);
    }

    fun create_leveraged_action_cap(arg0: 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::LeveragedAfSuiPosition, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState) : LeveragedActionCap {
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::assert_protocol_version(arg1);
        LeveragedActionCap{
            leveraged_afsui_position : arg0,
            end_position_metadata    : 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::position_metadata(&arg0),
        }
    }

    public fun deposit_afsui_collateral(arg0: &mut LeveragedActionCap, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::assert_protocol_version(arg1);
        let v0 = 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&arg5);
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::increase_total_afsui_collateral(&mut arg0.end_position_metadata, v0);
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::increase_total_afsui_collateral(arg1, v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg2, arg3, arg4, arg5, arg6);
    }

    public fun initiate_change_leverage(arg0: 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::LeveragedAfSuiPosition, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState) : LeveragedActionCap {
        create_leveraged_action_cap(arg0, arg1)
    }

    public fun initiate_leverage_stake(arg0: 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::LeveragedAfSuiPosition, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg6: &mut 0x2::tx_context::TxContext) : LeveragedActionCap {
        let v0 = create_leveraged_action_cap(arg0, arg1);
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::increase_base_afsui_collateral(&mut v0.end_position_metadata, 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&arg5));
        let v1 = &mut v0;
        deposit_afsui_collateral(v1, arg1, arg2, arg3, arg4, arg5, arg6);
        v0
    }

    public fun initiate_leverage_unstake(arg0: 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::LeveragedAfSuiPosition, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState, arg2: u64) : LeveragedActionCap {
        let v0 = create_leveraged_action_cap(arg0, arg1);
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::decrease_base_afsui_collateral(&mut v0.end_position_metadata, arg2);
        v0
    }

    public fun repay_sui(arg0: &mut LeveragedActionCap, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::assert_protocol_version(arg1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::decrease_total_sui_debt(&mut arg0.end_position_metadata, v0);
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::decrease_total_sui_debt(arg1, v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun withdraw_afsui_collateral(arg0: &mut LeveragedActionCap, arg1: &mut 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::LeveragedAfSuiState, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: u64, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg2, arg3, 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_position::obligation_key_mut(&mut arg0.leveraged_afsui_position), arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&v0);
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::position_metadata::decrease_total_afsui_collateral(&mut arg0.end_position_metadata, v1);
        0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state::decrease_total_afsui_collateral(arg1, v1);
        v0
    }

    // decompiled from Move bytecode v6
}

