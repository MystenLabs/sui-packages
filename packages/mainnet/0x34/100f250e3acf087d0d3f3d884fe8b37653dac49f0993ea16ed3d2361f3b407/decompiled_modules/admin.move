module 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::admin {
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

    public entry fun authorise_account_manager<T0, T1, T2>(arg0: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::VaultCap, arg1: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg2: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg3: address) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg2);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::whitelist_address_for_trading<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = AddressWhitelistedForTradingEvent{
            vaultId : 0x2::object::id<0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>>(arg1),
            address : arg3,
        };
        0x2::event::emit<AddressWhitelistedForTradingEvent>(v0);
    }

    public entry fun create_vault<T0, T1, T2>(arg0: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::app::AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0xdee9::clob_v2::Pool<T0, T1>, arg3: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg3);
        let (v0, v1) = 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::new_vault<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        let v2 = VaultCreatedEvent{
            vaultId        : v0,
            createdBy      : 0x2::tx_context::sender(arg5),
            typeX          : 0x1::type_name::get<T0>(),
            typeY          : 0x1::type_name::get<T1>(),
            poolId         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg2),
            vaultTokenType : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v2);
        0x2::transfer::public_transfer<0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::VaultCap>(v1, 0x2::tx_context::sender(arg5));
    }

    public entry fun revoke_account_manager<T0, T1, T2>(arg0: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::VaultCap, arg1: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg2: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg3: address) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg2);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::revoke_trading_permission<T0, T1, T2>(arg0, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

