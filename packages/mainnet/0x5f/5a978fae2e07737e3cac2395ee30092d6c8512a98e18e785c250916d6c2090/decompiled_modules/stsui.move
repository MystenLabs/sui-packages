module 0x5f5a978fae2e07737e3cac2395ee30092d6c8512a98e18e785c250916d6c2090::stsui {
    struct StsuiVaultLstKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StsuiVaultPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StsuiPosition has store {
        deposited_value: u64,
    }

    struct StsuiInvested has copy, drop {
        object_id: 0x2::object::ID,
        amount: u64,
    }

    struct StsuiReturned has copy, drop {
        object_id: 0x2::object::ID,
        gross: u64,
        yield_fee: u64,
        net: u64,
    }

    public(friend) fun compute_yield_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        let v1 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v0, arg2, 10000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u64>(&v1)) {
            return 0x1::option::destroy_some<u64>(v1)
        } else {
            0x1::option::destroy_none<u64>(v1);
            abort 13906834831473836040
        };
    }

    public fun vault_invest_stsui(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"stsui");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg4, &v0), 13906834496466124804);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg6), 13906834500760961026);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<0x2::sui::SUI>(arg0, arg1);
        let v2 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<0x2::sui::SUI>(v1, arg4);
        let v3 = StsuiVaultLstKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists<StsuiVaultLstKey>(v2, v3)) {
            let v4 = StsuiVaultLstKey{dummy_field: false};
            0x2::coin::join<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(0x2::dynamic_object_field::borrow_mut<StsuiVaultLstKey, 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(v2, v4), 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::split_bucket_for_invest<0x2::sui::SUI>(v1, arg5), arg6), arg6));
        } else {
            let v5 = StsuiVaultLstKey{dummy_field: false};
            0x2::dynamic_object_field::add<StsuiVaultLstKey, 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(v2, v5, 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::split_bucket_for_invest<0x2::sui::SUI>(v1, arg5), arg6), arg6));
        };
        let v6 = StsuiVaultPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<StsuiVaultPositionKey>(v2, v6)) {
            let v7 = StsuiVaultPositionKey{dummy_field: false};
            let v8 = 0x2::dynamic_field::borrow_mut<StsuiVaultPositionKey, StsuiPosition>(v2, v7);
            v8.deposited_value = v8.deposited_value + arg5;
        } else {
            let v9 = StsuiVaultPositionKey{dummy_field: false};
            let v10 = StsuiPosition{deposited_value: arg5};
            0x2::dynamic_field::add<StsuiVaultPositionKey, StsuiPosition>(v2, v9, v10);
        };
        let v11 = StsuiInvested{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg6)),
            amount    : arg5,
        };
        0x2::event::emit<StsuiInvested>(v11);
    }

    public fun vault_withdraw_stsui(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg5: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"stsui");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg5, &v0), 13906834672559783940);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg6), 13906834676854620162);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<0x2::sui::SUI>(arg0, arg1);
        let v2 = StsuiVaultLstKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<StsuiVaultLstKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<0x2::sui::SUI>(v1, arg5), v2), 13906834694034751494);
        let v3 = StsuiVaultLstKey{dummy_field: false};
        let v4 = StsuiVaultPositionKey{dummy_field: false};
        let v5 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>(arg2, 0x2::dynamic_object_field::remove<StsuiVaultLstKey, 0x2::coin::Coin<0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<0x2::sui::SUI>(v1, arg5), v3), arg3, arg6);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v7 = compute_yield_fee(v6, 0x2::dynamic_field::borrow<StsuiVaultPositionKey, StsuiPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<0x2::sui::SUI>(v1, arg5), v4).deposited_value, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::vault_yield_fee_bps(arg4));
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v7, arg6), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg4));
        };
        0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::merge_bucket_from_yield<0x2::sui::SUI>(v1, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
        let v8 = StsuiVaultPositionKey{dummy_field: false};
        let StsuiPosition {  } = 0x2::dynamic_field::remove<StsuiVaultPositionKey, StsuiPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<0x2::sui::SUI>(v1, arg5), v8);
        let v9 = StsuiReturned{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg6)),
            gross     : v6,
            yield_fee : v7,
            net       : v6 - v7,
        };
        0x2::event::emit<StsuiReturned>(v9);
    }

    // decompiled from Move bytecode v7
}

