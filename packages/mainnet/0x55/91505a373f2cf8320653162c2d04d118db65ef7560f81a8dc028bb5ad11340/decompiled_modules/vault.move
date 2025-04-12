module 0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault {
    struct Vault<phantom T0, phantom T1> has store {
        balance: 0x2::balance::Balance<T0>,
        fees_balance: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        ter: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        checkpoint: u64,
    }

    fun assert_balance_available<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        let v0 = balance_without_fees<T0, T1>(arg0, arg1);
        assert!(v0 >= arg2, 701);
        v0
    }

    public fun balance_without_fees<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::to_int(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::sub(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::sub(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64_denominator(0x2::balance::value<T0>(&arg0.balance), 1), arg0.fees_balance), current_fee_balance<T0, T1>(arg0, arg1)))
    }

    fun current_fee_balance<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        let v0 = current_fee_percentage<T0, T1>(arg0, arg1);
        if (0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::is_zero(v0)) {
            return v0
        };
        0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64_denominator(0x2::balance::value<T0>(&arg0.balance), 1), arg0.ter), v0)
    }

    fun current_fee_percentage<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::div(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64_denominator(0x2::clock::timestamp_ms(arg1) - arg0.checkpoint, 1000), 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u128_denominator(31536000, 1))
    }

    fun deposit_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        arg0.fees_balance = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::add(arg0.fees_balance, current_fee_balance<T0, T1>(arg0, arg2));
        arg0.checkpoint = 0x2::clock::timestamp_ms(arg2);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun deposit_with_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal, arg3: &0x2::clock::Clock) : (u64, 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal) {
        let v0 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64_denominator(0x2::balance::value<T0>(&arg1), 1);
        let v1 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(v0, arg2);
        arg0.fees_balance = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::add(arg0.fees_balance, v1);
        deposit_internal<T0, T1>(arg0, arg1, arg3);
        (0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::to_int(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::sub(v0, v1)), arg2)
    }

    public fun deposit_with_no_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        deposit_internal<T0, T1>(arg0, arg1, arg2);
    }

    public fun fees_balance<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::add(arg0.fees_balance, current_fee_balance<T0, T1>(arg0, arg1))
    }

    public fun new<T0, T1>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::app::VaultAdminCap) : Vault<T0, T1> {
        Vault<T0, T1>{
            balance      : 0x2::balance::zero<T0>(),
            fees_balance : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::zero(),
            ter          : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_percentage(arg0),
            checkpoint   : 0x2::clock::timestamp_ms(arg1),
        }
    }

    public fun withdraw_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::app::VaultAdminCap) : 0x2::balance::Balance<T0> {
        arg0.fees_balance = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::zero();
        arg0.checkpoint = 0x2::clock::timestamp_ms(arg1);
        0x2::balance::split<T0>(&mut arg0.balance, 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::to_u64(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::add(arg0.fees_balance, current_fee_balance<T0, T1>(arg0, arg1)), 0))
    }

    fun withdraw_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        arg0.fees_balance = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::add(arg0.fees_balance, current_fee_balance<T0, T1>(arg0, arg2));
        assert_balance_available<T0, T1>(arg0, arg2, arg1);
        arg0.checkpoint = 0x2::clock::timestamp_ms(arg2);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public fun withdraw_with_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64_denominator(arg1, 1), arg2);
        arg0.fees_balance = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::add(arg0.fees_balance, v0);
        withdraw_internal<T0, T1>(arg0, arg1 - 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::to_u64(v0, 0), arg3)
    }

    public fun withdraw_with_no_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        withdraw_internal<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

