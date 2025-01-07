module 0xc2db3a934e4198d8cb403f80c174dc61a01b520e244fa3163b508f2e4f28c43a::leveraged_afsui_position {
    struct LeveragedAfSuiPosition has store, key {
        id: 0x2::object::UID,
        obligation_key: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey,
        base_afsui_collateral: u64,
        total_afsui_collateral: u64,
        total_sui_debt: u64,
    }

    public fun leverage_ratio(arg0: &LeveragedAfSuiPosition, arg1: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) : u64 {
        0xc2db3a934e4198d8cb403f80c174dc61a01b520e244fa3163b508f2e4f28c43a::calculations::leverage_ratio(arg1, arg2, arg0.total_afsui_collateral, arg0.total_sui_debt)
    }

    public fun loan_to_value(arg0: &LeveragedAfSuiPosition, arg1: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) : u64 {
        0xc2db3a934e4198d8cb403f80c174dc61a01b520e244fa3163b508f2e4f28c43a::calculations::loan_to_value(arg1, arg2, arg0.total_afsui_collateral, arg0.total_sui_debt)
    }

    public fun base_afsui_collateral(arg0: &LeveragedAfSuiPosition) : u64 {
        arg0.base_afsui_collateral
    }

    public(friend) fun decrease_base_afsui_collateral(arg0: &mut LeveragedAfSuiPosition, arg1: u64) {
        arg0.base_afsui_collateral = arg0.base_afsui_collateral - arg1;
    }

    public(friend) fun increase_base_afsui_collateral(arg0: &mut LeveragedAfSuiPosition, arg1: u64) {
        arg0.base_afsui_collateral = arg0.base_afsui_collateral + arg1;
    }

    public fun new_leveraged_afsui_position(arg0: &mut 0xc2db3a934e4198d8cb403f80c174dc61a01b520e244fa3163b508f2e4f28c43a::leveraged_afsui_state::LeveragedAfSuiState, arg1: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg2: &mut 0x2::tx_context::TxContext) : LeveragedAfSuiPosition {
        0xc2db3a934e4198d8cb403f80c174dc61a01b520e244fa3163b508f2e4f28c43a::leveraged_afsui_state::assert_protocol_version(arg0);
        LeveragedAfSuiPosition{
            id                     : 0x2::object::new(arg2),
            obligation_key         : arg1,
            base_afsui_collateral  : 0,
            total_afsui_collateral : 0,
            total_sui_debt         : 0,
        }
    }

    public fun obligation_key(arg0: &LeveragedAfSuiPosition) : &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey {
        &arg0.obligation_key
    }

    public fun obligation_key_mut(arg0: &mut LeveragedAfSuiPosition) : &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey {
        &mut arg0.obligation_key
    }

    public fun total_afsui_collateral(arg0: &LeveragedAfSuiPosition) : u64 {
        arg0.total_afsui_collateral
    }

    public fun total_sui_debt(arg0: &LeveragedAfSuiPosition) : u64 {
        arg0.total_sui_debt
    }

    public(friend) fun update_position(arg0: &mut LeveragedAfSuiPosition, arg1: u64, arg2: u64) {
        arg0.total_afsui_collateral = arg1;
        arg0.total_sui_debt = arg2;
    }

    // decompiled from Move bytecode v6
}

