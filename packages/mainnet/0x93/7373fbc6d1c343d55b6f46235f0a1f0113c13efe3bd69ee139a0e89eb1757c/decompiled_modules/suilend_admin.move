module 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_admin {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        borrow_type: 0x1::type_name::TypeName,
        target_leverage: u64,
    }

    public fun new_vault<T0, T1, T2, T3>(arg0: &0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::admin::AdminCap, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::coin::TreasuryCap<T2>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg10: u8, arg11: u8, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::new<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::config::new<T0, T1, T2>(arg8, arg5, arg6, arg7, arg2, arg13), 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::new<T0, T1, T3>(arg9, arg3, arg4, arg13), arg13);
        0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::deposit<T0, T1, T3>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::protocol_config_mut<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(&mut v0), arg1, arg9, arg12, arg13);
        0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::config::seed_vt<T0, T1, T2>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::config_mut<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(&mut v0), 0x2::coin::into_balance<T2>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::config::mint_vt<T0, T1, T2>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::config_mut<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(&mut v0), 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::utils::safe_mul_div(0x2::balance::value<T0>(&arg1), 0x1::u64::pow(10, arg11), 0x1::u64::pow(10, arg10)), arg13)));
        let v1 = VaultCreatedEvent{
            vault_id        : 0x2::object::id<0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::Vault<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>>(&v0),
            deposit_type    : 0x1::type_name::get<T0>(),
            borrow_type     : 0x1::type_name::get<T1>(),
            target_leverage : arg8,
        };
        0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::event::emit<VaultCreatedEvent>(v1);
        0x2::transfer::public_share_object<0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::Vault<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>>(v0);
    }

    public fun set_is_spring_vault<T0, T1, T2, T3>(arg0: &0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::admin::AdminCap, arg1: &mut 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::Vault<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: bool) {
        if (0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::extra_info_exists<T0, T1, T3, vector<u8>>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::protocol_config<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(arg1), b"is_spring_vault")) {
            0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::remove_extra_info<T0, T1, T3, vector<u8>, bool>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::protocol_config_mut<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(arg1), b"is_spring_vault");
        };
        0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::add_extra_info<T0, T1, T3, vector<u8>, bool>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::protocol_config_mut<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(arg1), b"is_spring_vault", arg2);
    }

    public fun set_pool_id<T0, T1, T2, T3>(arg0: &0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::admin::AdminCap, arg1: &mut 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::Vault<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: 0x2::object::ID) {
        if (0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::extra_info_exists<T0, T1, T3, vector<u8>>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::protocol_config<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(arg1), b"pool_id")) {
            0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::remove_extra_info<T0, T1, T3, vector<u8>, 0x2::object::ID>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::protocol_config_mut<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(arg1), b"pool_id");
        };
        0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::add_extra_info<T0, T1, T3, vector<u8>, 0x2::object::ID>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::protocol_config_mut<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(arg1), b"pool_id", arg2);
    }

    // decompiled from Move bytecode v6
}

