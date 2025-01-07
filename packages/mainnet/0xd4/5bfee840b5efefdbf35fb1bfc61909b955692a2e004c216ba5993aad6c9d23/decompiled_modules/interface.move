module 0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::interface {
    struct LeveragedAfSuiState has store, key {
        id: 0x2::object::UID,
        total_afsui_collateral: u64,
        total_sui_debt: u64,
        protocol_version: u64,
    }

    struct LeveragedAfSuiObligationKey has store, key {
        id: 0x2::object::UID,
        obligation_key: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey,
        base_afsui_collateral: u64,
        afsui_collateral: u64,
        sui_debt: u64,
    }

    struct StakeCap {
        afsui_collateral: u64,
        sui_debt: u64,
    }

    struct UnstakeCap {
        afsui_collateral: u64,
        sui_debt: u64,
    }

    public fun afsui_collateral(arg0: &LeveragedAfSuiObligationKey) : u64 {
        arg0.afsui_collateral
    }

    fun assert_protocol_version(arg0: &LeveragedAfSuiState) {
        assert!(arg0.protocol_version == 1, 0);
    }

    public fun base_afsui_collateral(arg0: &LeveragedAfSuiObligationKey) : u64 {
        arg0.base_afsui_collateral
    }

    public fun borrow_sui(arg0: &mut StakeCap, arg1: &mut LeveragedAfSuiObligationKey, arg2: &mut LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: u64, arg8: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_protocol_version(arg2);
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<0x2::sui::SUI>(arg3, arg4, &arg1.obligation_key, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        arg0.sui_debt = arg0.sui_debt + v1;
        arg1.sui_debt = arg1.sui_debt + v1;
        arg2.total_sui_debt = arg2.total_sui_debt + v1;
        v0
    }

    public fun complete_leverage_stake(arg0: StakeCap, arg1: &mut LeveragedAfSuiObligationKey, arg2: &mut LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_protocol_version(arg2);
        let v0 = &mut arg0;
        deposit_afsui_collateral(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let StakeCap {
            afsui_collateral : v1,
            sui_debt         : v2,
        } = arg0;
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::events::emit_staked_event(0x2::tx_context::sender(arg7), v1, v2);
    }

    public fun complete_stake_and_return_obligation(arg0: StakeCap, arg1: LeveragedAfSuiObligationKey, arg2: &mut LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg7: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::ObligationHotPotato, arg8: &mut 0x2::tx_context::TxContext) {
        assert_protocol_version(arg2);
        let v0 = &mut arg1;
        let v1 = &mut arg4;
        complete_leverage_stake(arg0, v0, arg2, arg3, v1, arg5, arg6, arg8);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg3, arg4, arg7);
        0x2::transfer::public_transfer<LeveragedAfSuiObligationKey>(arg1, 0x2::tx_context::sender(arg8));
    }

    public fun complete_unstake(arg0: UnstakeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let UnstakeCap {
            afsui_collateral : v0,
            sui_debt         : v1,
        } = arg0;
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::events::emit_unstaked_event(0x2::tx_context::sender(arg1), v0, v1);
    }

    public fun deposit_afsui_collateral(arg0: &mut StakeCap, arg1: &mut LeveragedAfSuiObligationKey, arg2: &mut LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_protocol_version(arg2);
        let v0 = 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&arg6);
        arg0.afsui_collateral = arg0.afsui_collateral + v0;
        arg1.afsui_collateral = arg1.afsui_collateral + v0;
        arg2.total_afsui_collateral = arg2.total_afsui_collateral + v0;
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg3, arg4, arg5, arg6, arg7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LeveragedAfSuiState{
            id                     : 0x2::object::new(arg0),
            total_afsui_collateral : 0,
            total_sui_debt         : 0,
            protocol_version       : 1,
        };
        0x2::transfer::share_object<LeveragedAfSuiState>(v0);
    }

    public fun initiate_stake(arg0: &mut LeveragedAfSuiObligationKey, arg1: &0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>) : StakeCap {
        arg0.base_afsui_collateral = arg0.base_afsui_collateral + 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg1);
        StakeCap{
            afsui_collateral : 0,
            sui_debt         : 0,
        }
    }

    public fun initiate_stake_and_open_obligation(arg0: &0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0x2::tx_context::TxContext) : (StakeCap, LeveragedAfSuiObligationKey, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::ObligationHotPotato) {
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg1, arg2);
        let v3 = LeveragedAfSuiObligationKey{
            id                    : 0x2::object::new(arg2),
            obligation_key        : v1,
            base_afsui_collateral : 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0),
            afsui_collateral      : 0,
            sui_debt              : 0,
        };
        let v4 = StakeCap{
            afsui_collateral : 0,
            sui_debt         : 0,
        };
        (v4, v3, v0, v2)
    }

    public fun initiate_unstake() : UnstakeCap {
        UnstakeCap{
            afsui_collateral : 0,
            sui_debt         : 0,
        }
    }

    public fun obligation_key(arg0: &LeveragedAfSuiObligationKey) : &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey {
        &arg0.obligation_key
    }

    public fun repay_sui(arg0: &mut UnstakeCap, arg1: &mut LeveragedAfSuiObligationKey, arg2: &mut LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        arg0.sui_debt = arg0.sui_debt - v0;
        arg1.sui_debt = arg1.sui_debt - v0;
        arg2.total_sui_debt = arg2.total_sui_debt - v0;
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun sui_debt(arg0: &LeveragedAfSuiObligationKey) : u64 {
        arg0.sui_debt
    }

    public fun total_afsui_collateral(arg0: &LeveragedAfSuiState) : u64 {
        arg0.total_afsui_collateral
    }

    public fun total_sui_debt(arg0: &LeveragedAfSuiState) : u64 {
        arg0.total_sui_debt
    }

    public fun withdraw_afsui_collateral(arg0: &mut UnstakeCap, arg1: &mut LeveragedAfSuiObligationKey, arg2: &mut LeveragedAfSuiState, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: u64, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&v0);
        arg0.afsui_collateral = arg0.afsui_collateral - v1;
        arg1.afsui_collateral = arg1.afsui_collateral - v1;
        arg2.total_afsui_collateral = arg2.total_afsui_collateral - v1;
        v0
    }

    // decompiled from Move bytecode v6
}

