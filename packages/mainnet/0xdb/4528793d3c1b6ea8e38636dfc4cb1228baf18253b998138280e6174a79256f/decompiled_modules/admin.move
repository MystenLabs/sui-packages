module 0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::admin {
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

    public entry fun authorise_account_manager<T0, T1, T2>(arg0: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::VaultCap, arg1: &mut 0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::Vault<T0, T1, T2>, arg2: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::Version, arg3: address) {
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::assert_current_version(arg2);
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::whitelist_address_for_trading<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = AddressWhitelistedForTradingEvent{
            vaultId : 0x2::object::id<0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::Vault<T0, T1, T2>>(arg1),
            address : arg3,
        };
        0x2::event::emit<AddressWhitelistedForTradingEvent>(v0);
    }

    public entry fun create_vault<T0, T1, T2>(arg0: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::app::AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0xdee9::clob_v2::Pool<T0, T1>, arg3: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::assert_current_version(arg3);
        let (v0, v1) = 0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::new_vault<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        let v2 = VaultCreatedEvent{
            vaultId        : v0,
            createdBy      : 0x2::tx_context::sender(arg5),
            typeX          : 0x1::type_name::get<T0>(),
            typeY          : 0x1::type_name::get<T1>(),
            poolId         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg2),
            vaultTokenType : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v2);
        0x2::transfer::public_transfer<0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::VaultCap>(v1, 0x2::tx_context::sender(arg5));
    }

    public entry fun revoke_account_manager<T0, T1, T2>(arg0: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::VaultCap, arg1: &mut 0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::Vault<T0, T1, T2>, arg2: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::Version, arg3: address) {
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::assert_current_version(arg2);
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::revoke_trading_permission<T0, T1, T2>(arg0, arg1, arg3);
    }

    public fun seed<T0, T1, T2>(arg0: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::app::AdminCap, arg1: &mut 0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::Vault<T0, T1, T2>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::version::assert_current_version(arg6);
        0xdb4528793d3c1b6ea8e38636dfc4cb1228baf18253b998138280e6174a79256f::vault::seed_vault<T0, T1, T2>(arg1, arg2, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg3, arg7);
    }

    // decompiled from Move bytecode v6
}

