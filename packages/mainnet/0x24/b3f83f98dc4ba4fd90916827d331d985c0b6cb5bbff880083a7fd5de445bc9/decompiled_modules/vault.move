module 0x24b3f83f98dc4ba4fd90916827d331d985c0b6cb5bbff880083a7fd5de445bc9::vault {
    struct Vault<phantom T0, phantom T1> has store {
        balance: 0x2::balance::Balance<T0>,
        fees_balance: 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::Decimal,
        ter: 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::Decimal,
        checkpoint: u64,
    }

    fun assert_balance_available<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        let v0 = balance_without_fees<T0, T1>(arg0, arg1);
        assert!(v0 >= arg2, 701);
        v0
    }

    public fun balance_without_fees<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::to_int(0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::sub(0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::sub(0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::from_u64_denominator(0x2::balance::value<T0>(&arg0.balance), 1), arg0.fees_balance), current_fee_balance<T0, T1>(arg0, arg1)))
    }

    fun current_fee_balance<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::Decimal {
        let v0 = current_fee_percentage<T0, T1>(arg0, arg1);
        if (0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::is_zero(v0)) {
            return v0
        };
        0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::mul(0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::mul(0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::from_u64_denominator(0x2::balance::value<T0>(&arg0.balance), 1), arg0.ter), v0)
    }

    fun current_fee_percentage<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::Decimal {
        0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::div(0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::from_u64_denominator(0x2::clock::timestamp_ms(arg1) - arg0.checkpoint, 1000), 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::from_u128_denominator(31536000, 1))
    }

    fun deposit_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        arg0.fees_balance = 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::add(arg0.fees_balance, current_fee_balance<T0, T1>(arg0, arg2));
        arg0.checkpoint = 0x2::clock::timestamp_ms(arg2);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun deposit_with_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::Decimal, arg3: &0x2::clock::Clock) : (u64, 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::Decimal) {
        let v0 = 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::from_u64_denominator(0x2::balance::value<T0>(&arg1), 1);
        let v1 = 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::mul(v0, arg2);
        arg0.fees_balance = 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::add(arg0.fees_balance, v1);
        deposit_internal<T0, T1>(arg0, arg1, arg3);
        (0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::to_int(0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::sub(v0, v1)), arg2)
    }

    public fun deposit_with_no_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        deposit_internal<T0, T1>(arg0, arg1, arg2);
    }

    public fun fees_balance<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::Decimal {
        0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::add(arg0.fees_balance, current_fee_balance<T0, T1>(arg0, arg1))
    }

    public fun new<T0, T1>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &0x24b3f83f98dc4ba4fd90916827d331d985c0b6cb5bbff880083a7fd5de445bc9::app::VaultAdminCap) : Vault<T0, T1> {
        Vault<T0, T1>{
            balance      : 0x2::balance::zero<T0>(),
            fees_balance : 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::zero(),
            ter          : 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::from_percentage(arg0),
            checkpoint   : 0x2::clock::timestamp_ms(arg1),
        }
    }

    public fun withdraw_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x24b3f83f98dc4ba4fd90916827d331d985c0b6cb5bbff880083a7fd5de445bc9::app::VaultAdminCap) : 0x2::balance::Balance<T0> {
        arg0.fees_balance = 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::zero();
        arg0.checkpoint = 0x2::clock::timestamp_ms(arg1);
        0x2::balance::split<T0>(&mut arg0.balance, 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::to_u64(0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::add(arg0.fees_balance, current_fee_balance<T0, T1>(arg0, arg1)), 0))
    }

    fun withdraw_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        arg0.fees_balance = 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::add(arg0.fees_balance, current_fee_balance<T0, T1>(arg0, arg2));
        assert_balance_available<T0, T1>(arg0, arg2, arg1);
        arg0.checkpoint = 0x2::clock::timestamp_ms(arg2);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public fun withdraw_with_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::Decimal, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::mul(0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::from_u64_denominator(arg1, 1), arg2);
        arg0.fees_balance = 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::add(arg0.fees_balance, v0);
        withdraw_internal<T0, T1>(arg0, arg1 - 0x1ad46303d653a4cfe7ed9a939567f78a2fd1b96d8423a8ded9b2415fdd1ee31f::decimals::to_u64(v0, 0), arg3)
    }

    public fun withdraw_with_no_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        withdraw_internal<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

