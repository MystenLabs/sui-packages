module 0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        funds: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
        fee_bps: u64,
        active_assistant: 0x2::object::ID,
    }

    public fun burn<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::assert_package_version(arg1);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = v0 * 0x2::coin::total_supply<T1>(&arg0.treasury_cap) / 0x2::balance::value<T0>(&arg0.funds);
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, arg2);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v0), arg3);
        let v3 = &mut v2;
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(v3, 0x2::coin::value<T0>(v3) * arg0.fee_bps / 10000, arg3)));
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::events::emit_burned_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v0, v1, v1 - 0x2::coin::value<T0>(&v2));
        v2
    }

    public fun mint<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::assert_package_version(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = v0 * 0x2::balance::value<T0>(&arg0.funds) / 0x2::coin::total_supply<T1>(&arg0.treasury_cap);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg2));
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::events::emit_minted_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v0, v1);
        0x2::coin::mint<T1>(&mut arg0.treasury_cap, v1, arg3)
    }

    public fun total_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.treasury_cap)
    }

    public fun new<T0, T1>(arg0: &0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::Config, arg1: 0x2::coin::TreasuryCap<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, 0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::AuthorityCap<0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::VAULT, 0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::ADMIN>) {
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::assert_package_version(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::assert_is_whitelisted(arg0, &v0);
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::assert_valid_fee_bps(arg0, arg2);
        assert!(0x2::coin::total_supply<T1>(&arg1) == 0, 1);
        let v1 = Vault<T0, T1>{
            id               : 0x2::object::new(arg3),
            treasury_cap     : arg1,
            funds            : 0x2::balance::zero<T0>(),
            fees             : 0x2::balance::zero<T0>(),
            fee_bps          : arg2,
            active_assistant : 0x2::object::id_from_address(@0x0),
        };
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::events::emit_created_vault_event<T0, T1>(0x2::object::uid_to_inner(&v1.id), 0x2::tx_context::sender(arg3));
        (v1, 0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::create_vault_admin_cap(0x2::object::uid_to_inner(&v1.id), arg3))
    }

    public fun add_yield<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::Config, arg2: 0x2::coin::Coin<T0>) {
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::assert_package_version(arg1);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun set_fee_bps<T0, T1, T2>(arg0: &mut Vault<T1, T2>, arg1: &0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::AuthorityCap<0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::VAULT, T0>, arg2: &0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::Config, arg3: u64) {
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::assert_package_version(arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::for<0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::VAULT, T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id) && (0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::is_admin(v0) || 0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::AuthorityCap<0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::VAULT, T0>>(arg1)), 0);
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::assert_valid_fee_bps(arg2, arg3);
        arg0.fee_bps = arg3;
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut Vault<T1, T2>, arg1: &0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::AuthorityCap<0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::VAULT, T0>, arg2: &0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::assert_package_version(arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::for<0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::VAULT, T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id) && (0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::is_admin(v0) || 0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::AuthorityCap<0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::VAULT, T0>>(arg1)), 0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fees, 0x2::balance::value<T1>(&arg0.fees)), arg3)
    }

    // decompiled from Move bytecode v6
}

