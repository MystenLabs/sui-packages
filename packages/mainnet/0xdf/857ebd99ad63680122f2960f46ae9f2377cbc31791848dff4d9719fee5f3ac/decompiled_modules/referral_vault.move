module 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault {
    struct ReferralVault has key {
        id: 0x2::object::UID,
        version: u64,
        referrer_addresses: 0x2::table::Table<address, address>,
        rebates: 0x2::table::Table<address, 0x2::bag::Bag>,
    }

    public fun assert_version(arg0: &ReferralVault) {
        assert!(arg0.version == 1, 0);
    }

    public fun balance_of<T0>(arg0: &ReferralVault, arg1: address) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!referrer_has_rebate(arg0, arg1)) {
            return 0
        };
        let v1 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.rebates, arg1);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0))
    }

    public fun deposit_rebate<T0>(arg0: &mut ReferralVault, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (!referrer_has_rebate(arg0, arg2)) {
            0x2::table::add<address, 0x2::bag::Bag>(&mut arg0.rebates, arg2, 0x2::bag::new(arg3));
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.rebates, arg2);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0, 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0), 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun has_referrer(arg0: &ReferralVault, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.referrer_addresses, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralVault{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            referrer_addresses : 0x2::table::new<address, address>(arg0),
            rebates            : 0x2::table::new<address, 0x2::bag::Bag>(arg0),
        };
        0x2::transfer::share_object<ReferralVault>(v0);
    }

    public fun referrer_for(arg0: &ReferralVault, arg1: address) : 0x1::option::Option<address> {
        if (has_referrer(arg0, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referrer_addresses, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun referrer_has_rebate(arg0: &ReferralVault, arg1: address) : bool {
        0x2::table::contains<address, 0x2::bag::Bag>(&arg0.rebates, arg1)
    }

    public fun referrer_has_rebate_with_type<T0>(arg0: &ReferralVault, arg1: address) : bool {
        referrer_has_rebate(arg0, arg1) && 0x2::bag::contains<0x1::type_name::TypeName>(0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.rebates, arg1), 0x1::type_name::get<T0>())
    }

    public fun update_referrer_address(arg0: &mut ReferralVault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 2);
        if (!has_referrer(arg0, v0)) {
            0x2::table::add<address, address>(&mut arg0.referrer_addresses, v0, arg1);
        } else if (*0x2::table::borrow<address, address>(&arg0.referrer_addresses, v0) != arg1) {
            *0x2::table::borrow_mut<address, address>(&mut arg0.referrer_addresses, v0) = arg1;
        };
    }

    public fun withdraw_and_transfer<T0>(arg0: &mut ReferralVault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_rebate<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun withdraw_rebate<T0>(arg0: &mut ReferralVault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(referrer_has_rebate_with_type<T0>(arg0, v0), 1);
        0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.rebates, v0), 0x1::type_name::get<T0>()), arg1)
    }

    // decompiled from Move bytecode v6
}

