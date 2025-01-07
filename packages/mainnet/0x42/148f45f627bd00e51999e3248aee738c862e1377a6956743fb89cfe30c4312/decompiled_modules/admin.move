module 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::admin {
    struct VaultCreatedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        createdBy: address,
        typeX: 0x1::type_name::TypeName,
        typeY: 0x1::type_name::TypeName,
        poolId: 0x2::object::ID,
        vaultTokenType: 0x1::type_name::TypeName,
    }

    struct AddressWhitelistedForTradingEvent has copy, drop {
        vaultId: 0x2::object::ID,
        address: address,
    }

    public entry fun authorise_for_trading<T0, T1, T2>(arg0: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::VaultCap, arg1: &mut 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::Vault<T0, T1, T2>, arg2: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::Version, arg3: address) {
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::assert_current_version(arg2);
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::whitelist_address_for_trading<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = AddressWhitelistedForTradingEvent{
            vaultId : 0x2::object::id<0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::Vault<T0, T1, T2>>(arg1),
            address : arg3,
        };
        0x2::event::emit<AddressWhitelistedForTradingEvent>(v0);
    }

    public entry fun create_and_seed_vault<T0, T1, T2>(arg0: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::app::AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::assert_current_version(arg7);
        let (v0, v1) = 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::new_vault<T0, T1, T2>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg5, arg6, arg8);
        let v2 = VaultCreatedEvent{
            vaultId        : v0,
            createdBy      : 0x2::tx_context::sender(arg8),
            typeX          : 0x1::type_name::get<T0>(),
            typeY          : 0x1::type_name::get<T1>(),
            poolId         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg2),
            vaultTokenType : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v2);
        0x2::transfer::public_transfer<0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::VaultCap>(v1, 0x2::tx_context::sender(arg8));
    }

    public entry fun revoke_for_trading<T0, T1, T2>(arg0: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::VaultCap, arg1: &mut 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::Vault<T0, T1, T2>, arg2: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::Version, arg3: address) {
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::assert_current_version(arg2);
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::revoke_trading_permission<T0, T1, T2>(arg0, arg1, arg3);
    }

    public entry fun withdraw_fees<T0, T1, T2>(arg0: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::VaultCap, arg1: &mut 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::Vault<T0, T1, T2>, arg2: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::assert_current_version(arg2);
        let (v0, v1) = withdraw_fees_<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_fees_<T0, T1, T2>(arg0: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::VaultCap, arg1: &mut 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::Vault<T0, T1, T2>, arg2: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::assert_current_version(arg2);
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::withdraw_fees<T0, T1, T2>(arg0, arg1, arg3)
    }

    // decompiled from Move bytecode v6
}

