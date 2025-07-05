module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        product_balances: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
        fee_balances: 0x2::table::Table<address, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>,
    }

    struct VaultCreated<phantom T0> has copy, drop {
        id: address,
    }

    public fun new<T0>(arg0: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id               : 0x2::object::new(arg1),
            product_balances : 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg1),
            fee_balances     : 0x2::table::new<address, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(arg1),
        };
        let v1 = 0x2::object::id<Vault<T0>>(&v0);
        let v2 = VaultCreated<T0>{id: 0x2::object::id_to_address(&v1)};
        0x2::event::emit<VaultCreated<T0>>(v2);
        0x2::transfer::public_share_object<Vault<T0>>(v0);
    }

    public(friend) fun add_fee_balance<T0>(arg0: &mut Vault<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: address, arg4: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal) {
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_int(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::round_u64(arg4, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg1))));
        if (!0x2::table::contains<address, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&arg0.fee_balances, arg3)) {
            0x2::table::add<address, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&mut arg0.fee_balances, arg3, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero());
        };
        let v1 = 0x2::table::borrow_mut<address, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&mut arg0.fee_balances, arg3);
        *v1 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::add(*v1, v0);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::add_fee<T0>(arg2, arg1, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_int(v0), arg3);
    }

    public(friend) fun assert_fee_balance<T0>(arg0: &Vault<T0>, arg1: address) {
        assert!(0x2::table::contains<address, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&arg0.fee_balances, arg1), 1800);
    }

    public(friend) fun assert_product_balance<T0>(arg0: &Vault<T0>, arg1: address) {
        assert!(0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.product_balances, arg1), 1800);
    }

    public(friend) fun assert_product_category(arg0: u64) {
        let v0 = vector[0, 1];
        assert!(0x1::vector::contains<u64>(&v0, &arg0), 1802);
    }

    public fun balance_amount<T0>(arg0: &Vault<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: address) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        if (!0x2::table::contains<address, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&arg0.fee_balances, arg2) || !0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.product_balances, arg2)) {
            return 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero()
        };
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg1);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(0x2::balance::value<T0>(0x2::table::borrow<address, 0x2::balance::Balance<T0>>(&arg0.product_balances, arg2)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(v0)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_int(*0x2::table::borrow<address, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&arg0.fee_balances, arg2)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(v0)))
    }

    public(friend) fun deposit_product_balance<T0>(arg0: &mut Vault<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: address, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.product_balances, arg3)) {
            0x2::balance::join<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.product_balances, arg3), arg4)
        } else {
            0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.product_balances, arg3, arg4);
            0x2::balance::value<T0>(&arg4)
        };
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::set_balance<T0>(arg2, arg1, v0, arg3, arg5, arg6, arg7);
    }

    public fun fee_amount<T0>(arg0: &Vault<T0>, arg1: address) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        *0x2::table::borrow<address, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&arg0.fee_balances, arg1)
    }

    public fun index_product() : u64 {
        0
    }

    public fun lp_product() : u64 {
        1
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: address, arg4: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::ge(balance_amount<T0>(arg0, arg1, arg3), arg4), 1801);
        withdraw_internal<T0>(arg0, arg1, arg2, arg3, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_u64(arg4, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg1))), arg5, arg6, arg7)
    }

    public(friend) fun withdraw_all<T0>(arg0: &mut Vault<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::set_balance<T0>(arg2, arg1, 0, arg3, arg4, arg5, arg6);
        0x2::balance::split<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.product_balances, arg3), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_u64(balance_amount<T0>(arg0, arg1, arg3), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg1))))
    }

    public(friend) fun withdraw_fee<T0>(arg0: &mut Vault<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = fee_amount<T0>(arg0, arg3);
        *0x2::table::borrow_mut<address, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&mut arg0.fee_balances, arg3) = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero();
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::reset_fee<T0>(arg2, arg1, arg3);
        let v1 = 0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.product_balances, arg3);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::set_balance<T0>(arg2, arg1, 0x2::balance::value<T0>(v1) - 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_int(v0), arg3, arg4, arg5, arg6);
        0x2::balance::split<T0>(v1, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::to_int(v0))
    }

    fun withdraw_internal<T0>(arg0: &mut Vault<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.product_balances, arg3);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::set_balance<T0>(arg2, arg1, 0x2::balance::value<T0>(v0) - arg4, arg3, arg5, arg6, arg7);
        0x2::balance::split<T0>(v0, arg4)
    }

    public(friend) fun withdraw_with_round<T0>(arg0: &mut Vault<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: address, arg4: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::ge(balance_amount<T0>(arg0, arg1, arg3), arg4), 1801);
        withdraw_internal<T0>(arg0, arg1, arg2, arg3, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::round_u64(arg4, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T0>(arg1))), arg5, arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

