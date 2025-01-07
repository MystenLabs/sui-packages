module 0xa61e1817a0c75affdf2ecbbe046e7b17f5292f1ca8abbf7c9473e99c52769aff::referral_vault {
    struct ReferralVault<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        version: u64,
        referrer_addresses: 0x2::table::Table<address, address>,
        rebates: 0x2::table::Table<address, 0x2::bag::Bag>,
    }

    public fun assert_version<T0: drop>(arg0: &ReferralVault<T0>) {
        assert!(arg0.version == 1, 0);
    }

    public fun balance_of<T0: drop, T1>(arg0: &ReferralVault<T0>, arg1: address) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        if (!referrer_has_rebate<T0>(arg0, arg1)) {
            return 0
        };
        let v1 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.rebates, arg1);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            return 0
        };
        0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v1, v0))
    }

    public fun create_referral_vault<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : ReferralVault<T0> {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 3);
        let v0 = ReferralVault<T0>{
            id                 : 0x2::object::new(arg1),
            version            : 1,
            referrer_addresses : 0x2::table::new<address, address>(arg1),
            rebates            : 0x2::table::new<address, 0x2::bag::Bag>(arg1),
        };
        let v1 = 0x1::type_name::get<T0>();
        0xa61e1817a0c75affdf2ecbbe046e7b17f5292f1ca8abbf7c9473e99c52769aff::events::emit_created_referral_vault_event(0x2::object::id<ReferralVault<T0>>(&v0), *0x1::type_name::borrow_string(&v1));
        v0
    }

    public fun deposit_rebate<T0: drop, T1>(arg0: &mut ReferralVault<T0>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x1::type_name::get<T1>();
        if (!referrer_has_rebate<T0>(arg0, arg2)) {
            0x2::table::add<address, 0x2::bag::Bag>(&mut arg0.rebates, arg2, 0x2::bag::new(arg3));
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.rebates, arg2);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v1, v0, 0x2::coin::into_balance<T1>(arg1));
        } else {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v1, v0), 0x2::coin::into_balance<T1>(arg1));
        };
    }

    public fun has_referrer<T0: drop>(arg0: &ReferralVault<T0>, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.referrer_addresses, arg1)
    }

    public fun referrer_for<T0: drop>(arg0: &ReferralVault<T0>, arg1: address) : 0x1::option::Option<address> {
        if (has_referrer<T0>(arg0, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referrer_addresses, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun referrer_has_rebate<T0: drop>(arg0: &ReferralVault<T0>, arg1: address) : bool {
        0x2::table::contains<address, 0x2::bag::Bag>(&arg0.rebates, arg1)
    }

    public fun referrer_has_rebate_with_type<T0: drop, T1>(arg0: &ReferralVault<T0>, arg1: address) : bool {
        referrer_has_rebate<T0>(arg0, arg1) && 0x2::bag::contains<0x1::type_name::TypeName>(0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.rebates, arg1), 0x1::type_name::get<T1>())
    }

    public fun referrer_has_rebate_with_type_name<T0: drop>(arg0: &ReferralVault<T0>, arg1: address, arg2: 0x1::type_name::TypeName) : bool {
        referrer_has_rebate<T0>(arg0, arg1) && 0x2::bag::contains<0x1::type_name::TypeName>(0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.rebates, arg1), arg2)
    }

    public fun update_referrer_address<T0: drop>(arg0: &mut ReferralVault<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 2);
        if (!has_referrer<T0>(arg0, v0)) {
            0x2::table::add<address, address>(&mut arg0.referrer_addresses, v0, arg1);
        } else if (*0x2::table::borrow<address, address>(&arg0.referrer_addresses, v0) != arg1) {
            *0x2::table::borrow_mut<address, address>(&mut arg0.referrer_addresses, v0) = arg1;
        };
    }

    public fun withdraw_rebate<T0: drop, T1>(arg0: &mut ReferralVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0>(arg0);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::tx_context::sender(arg1);
        assert!(referrer_has_rebate_with_type_name<T0>(arg0, v1, v0), 1);
        0x2::coin::from_balance<T1>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.rebates, v1), v0), arg1)
    }

    public fun withdraw_rebate_and_keep<T0: drop, T1>(arg0: &mut ReferralVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_rebate<T0, T1>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

