module 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::admin {
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

    public entry fun authorise_account_manager<T0, T1, T2>(arg0: &0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::VaultCap, arg1: &mut 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::Vault<T0, T1, T2>, arg2: address) {
        0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::whitelist_address_for_trading<T0, T1, T2>(arg0, arg1, arg2);
        let v0 = AddressWhitelistedForTradingEvent{
            vaultId : 0x2::object::id<0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::Vault<T0, T1, T2>>(arg1),
            address : arg2,
        };
        0x2::event::emit<AddressWhitelistedForTradingEvent>(v0);
    }

    public entry fun create_vault<T0, T1, T2>(arg0: &0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::app::AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0xdee9::clob_v2::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::new_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        let v2 = VaultCreatedEvent{
            vaultId        : v0,
            createdBy      : 0x2::tx_context::sender(arg4),
            typeX          : 0x1::type_name::get<T0>(),
            typeY          : 0x1::type_name::get<T1>(),
            poolId         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg2),
            vaultTokenType : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v2);
        0x2::transfer::public_transfer<0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::VaultCap>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun revoke_account_manager<T0, T1, T2>(arg0: &0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::VaultCap, arg1: &mut 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::Vault<T0, T1, T2>, arg2: address) {
        0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::vault::revoke_trading_permission<T0, T1, T2>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

