module 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::sui_staking_smart_contract {
    struct SUI_STAKING_SMART_CONTRACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_STAKING_SMART_CONTRACT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SUI_STAKING_SMART_CONTRACT>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::create_and_share_staking_contract(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::admin_cap::create_and_transfer_admin_cap(0x2::tx_context::sender(arg1), arg1), arg1);
    }

    entry fun migrate_staking_contract(arg0: &mut 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::StakingContract, arg1: &0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::admin_cap::AdminCap) {
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::get_staking_contract_admin(arg0) == 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::admin_cap::get_admin_cap_id(arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_ENotAdmin());
        let v0 = 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::get_staking_contract_version_mut(arg0);
        assert!(*v0 < 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_VERSION(), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_ENotUpgrade());
        *v0 = 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_VERSION();
    }

    public fun mint_admin_cap(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::admin_cap::AdminCap {
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::admin_cap::new_admin_cap(arg1)
    }

    // decompiled from Move bytecode v6
}

