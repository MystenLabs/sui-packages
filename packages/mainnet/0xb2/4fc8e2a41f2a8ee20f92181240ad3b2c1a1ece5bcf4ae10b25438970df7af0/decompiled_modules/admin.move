module 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::admin {
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

    public entry fun authorise_account_manager<T0, T1, T2>(arg0: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::VaultCap, arg1: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg3: address) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg2);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::whitelist_address_for_trading<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = AddressWhitelistedForTradingEvent{
            vaultId : 0x2::object::id<0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>>(arg1),
            address : arg3,
        };
        0x2::event::emit<AddressWhitelistedForTradingEvent>(v0);
    }

    public entry fun create_vault<T0, T1, T2>(arg0: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::app::AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0xdee9::clob_v2::Pool<T0, T1>, arg3: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg3);
        let (v0, v1) = 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::new_vault<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        let v2 = VaultCreatedEvent{
            vaultId        : v0,
            createdBy      : 0x2::tx_context::sender(arg5),
            typeX          : 0x1::type_name::get<T0>(),
            typeY          : 0x1::type_name::get<T1>(),
            poolId         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg2),
            vaultTokenType : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v2);
        0x2::transfer::public_transfer<0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::VaultCap>(v1, 0x2::tx_context::sender(arg5));
    }

    public entry fun revoke_account_manager<T0, T1, T2>(arg0: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::VaultCap, arg1: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg3: address) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg2);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::revoke_trading_permission<T0, T1, T2>(arg0, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

