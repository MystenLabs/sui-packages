module 0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct Metadata has store, key {
        id: 0x2::object::UID,
        deposits_supported: bool,
        deposit_cap: u64,
        total_deposits: u64,
        min_fee_bps: u64,
        max_fee_bps: u64,
        priority: u64,
        decimals: u8,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
        funds: 0x2::object_bag::ObjectBag,
        fees: 0x2::object_bag::ObjectBag,
        metadata: 0x2::object_table::ObjectTable<0x1::type_name::TypeName, Metadata>,
        total_deposits: u128,
        total_priorities: u64,
        meta_coin_decimals: u8,
    }

    public fun borrow<T0>(arg0: &Vault<T0>, arg1: 0x1::type_name::TypeName) : &Metadata {
        0x2::object_table::borrow<0x1::type_name::TypeName, Metadata>(&arg0.metadata, arg1)
    }

    fun borrow_mut<T0>(arg0: &mut Vault<T0>, arg1: 0x1::type_name::TypeName) : &mut Metadata {
        0x2::object_table::borrow_mut<0x1::type_name::TypeName, Metadata>(&mut arg0.metadata, arg1)
    }

    public fun add_metadata<T0, T1>(arg0: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::admin::AdminCap, arg1: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::Version, arg2: &mut Vault<T0>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::coin::CoinMetadata<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        add_metadata_unsafe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::get_decimals<T1>(arg8), arg9);
    }

    public fun add_metadata_unsafe<T0, T1>(arg0: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::admin::AdminCap, arg1: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::Version, arg2: &mut Vault<T0>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::object_table::contains<0x1::type_name::TypeName, Metadata>(&arg2.metadata, v0), 9223373857921302535);
        let v1 = Metadata{
            id                 : 0x2::object::new(arg9),
            deposits_supported : arg3,
            deposit_cap        : arg4,
            total_deposits     : 0,
            min_fee_bps        : arg5,
            max_fee_bps        : arg6,
            priority           : arg7,
            decimals           : arg8,
        };
        0x2::object_table::add<0x1::type_name::TypeName, Metadata>(&mut arg2.metadata, v0, v1);
        arg2.total_priorities = arg2.total_priorities + arg7;
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.funds, v0, 0x2::coin::zero<T1>(arg9));
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.fees, v0, 0x2::coin::zero<T1>(arg9));
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::events::emit_support_coin_event<T1>(0x2::object::uid_to_inner(&arg2.id), arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun allow_deposits<T0, T1>(arg0: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::admin::AdminCap, arg1: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::Version, arg2: &mut Vault<T0>) {
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::assert_correct_package(arg1);
        set_deposits_vault<T0, T1>(arg2, true);
    }

    fun burn<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::decrease_supply<T0>(&mut arg0.supply, 0x2::coin::into_balance<T0>(arg1));
    }

    fun calculate_dynamic_fee<T0, T1>(arg0: &Vault<T0>, arg1: &Metadata, arg2: u64, arg3: 0x1::type_name::TypeName) : u64 {
        let v0 = normalize_decimals(0x2::coin::value<T1>(0x2::object_bag::borrow<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&arg0.funds, arg3)), arg1.decimals, arg0.meta_coin_decimals) - arg2;
        let v1 = multiply_and_divide((0x2::balance::supply_value<T0>(&arg0.supply) as u128), (arg1.priority as u128), (arg0.total_priorities as u128));
        let v2 = if (v1 >= v0) {
            arg1.min_fee_bps
        } else {
            arg1.max_fee_bps - multiply_and_divide(((arg1.max_fee_bps - arg1.min_fee_bps) as u128), (v0 as u128), (v1 as u128))
        };
        multiply_and_divide((arg2 as u128), (v2 as u128), 10000)
    }

    public fun create_vault<T0>(arg0: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::admin::AdminCap, arg1: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::Version, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::assert_correct_package(arg1);
        let v0 = 0x2::coin::treasury_into_supply<T0>(arg2);
        assert!(0x2::balance::supply_value<T0>(&v0) == 0, 9223372762704248833);
        let v1 = Vault<T0>{
            id                 : 0x2::object::new(arg4),
            supply             : v0,
            funds              : 0x2::object_bag::new(arg4),
            fees               : 0x2::object_bag::new(arg4),
            metadata           : 0x2::object_table::new<0x1::type_name::TypeName, Metadata>(arg4),
            total_deposits     : (0 as u128),
            total_priorities   : 0,
            meta_coin_decimals : 0x2::coin::get_decimals<T0>(arg3),
        };
        0x2::transfer::share_object<Vault<T0>>(v1);
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::Version, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::assert_correct_package(arg1);
        assert!(0x2::coin::value<T1>(&arg2) != 0, 9223373037582811147);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_table::contains<0x1::type_name::TypeName, Metadata>(&arg0.metadata, v0), 9223373059057123331);
        let v1 = borrow_mut<T0>(arg0, v0);
        assert!(v1.deposits_supported, 9223373076237385737);
        let v2 = v1.deposit_cap;
        let v3 = 0x2::coin::value<T1>(&arg2);
        let v4 = v1.total_deposits + v3;
        assert!(v4 <= v3, 9223373110597779475);
        v1.total_deposits = v4;
        let v5 = normalize_decimals(v3, v1.decimals, arg0.meta_coin_decimals);
        let v6 = mint<T0>(arg0, v5, arg3);
        let v7 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.funds, v0);
        assert!(0x2::coin::value<T1>(v7) + v3 <= v2, 9223373226561634319);
        0x2::coin::join<T1>(v7, arg2);
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::events::emit_deposit_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v3, v5);
        v6
    }

    public fun disallow_deposits<T0, T1>(arg0: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::admin::AdminCap, arg1: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::Version, arg2: &mut Vault<T0>) {
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::assert_correct_package(arg1);
        set_deposits_vault<T0, T1>(arg2, false);
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::admin::AdminCap>(0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::admin::create_admin_cap<VAULT>(&arg0, arg1), v0);
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::create_version<VAULT>(&arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<VAULT>(arg0, arg1), v0);
    }

    fun join_fee<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::join<T1>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.fees, 0x1::type_name::get<T1>()), arg1);
    }

    fun mint<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.supply, arg1), arg2)
    }

    fun multiply_and_divide(arg0: u128, arg1: u128, arg2: u128) : u64 {
        ((arg0 * arg1 / arg2) as u64)
    }

    fun normalize_decimals(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg1 == arg2) {
            arg0
        } else if (arg1 < arg2) {
            arg0 * 0x1::u64::pow(10, arg2 - arg1)
        } else {
            assert!(arg1 > arg2, 9223375000383258641);
            let v1 = arg1 - arg2;
            assert!(arg0 >= 0x1::u64::pow(10, v1), 9223374983203127309);
            arg0 / 0x1::u64::pow(10, v1)
        }
    }

    fun set_deposits_vault<T0, T1>(arg0: &mut Vault<T0>, arg1: bool) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_table::contains<0x1::type_name::TypeName, Metadata>(&arg0.metadata, v0), 9223374824288681987);
        borrow_mut<T0>(arg0, v0).deposits_supported = arg1;
    }

    fun take_fee<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        join_fee<T0, T1>(arg0, 0x2::coin::split<T1>(arg1, arg2, arg3));
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::Version, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::assert_correct_package(arg1);
        assert!(0x2::coin::value<T0>(&arg2) != 0, 9223373372590260235);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = borrow<T0>(arg0, v0);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let v3 = calculate_dynamic_fee<T0, T1>(arg0, v1, v2, v0);
        let v4 = normalize_decimals(v2, arg0.meta_coin_decimals, v1.decimals);
        let v5 = borrow_mut<T0>(arg0, v0);
        v5.total_deposits = v5.total_deposits - v4;
        burn<T0>(arg0, arg2);
        let v6 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.funds, v0);
        assert!(v4 <= 0x2::coin::value<T1>(v6), 9223373522913722373);
        let v7 = 0x2::coin::split<T1>(v6, v4, arg3);
        let v8 = &mut v7;
        take_fee<T0, T1>(arg0, v8, v3, arg3);
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::events::emit_withdraw_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v4, v2);
        v7
    }

    public fun withdraw_fees<T0, T1>(arg0: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::admin::AdminCap, arg1: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::Version, arg2: &mut Vault<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_table::contains<0x1::type_name::TypeName, Metadata>(&arg2.metadata, v0), 9223374124209012739);
        let v1 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.fees, v0);
        0x2::coin::split<T1>(v1, 0x2::coin::value<T1>(v1), arg3)
    }

    // decompiled from Move bytecode v6
}

