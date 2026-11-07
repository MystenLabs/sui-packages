module 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::payout {
    struct VestingTerms has copy, drop, store {
        cliff_delay_ms: u64,
        period_duration_ms: u64,
        periods: u64,
    }

    struct Recipient has copy, drop, store {
        destination: address,
        vesting_terms: 0x1::option::Option<VestingTerms>,
    }

    public fun cliff_delay_ms(arg0: &VestingTerms) : u64 {
        arg0.cliff_delay_ms
    }

    public fun destination(arg0: &Recipient) : address {
        arg0.destination
    }

    public fun pay<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg3), arg2);
    }

    public fun pay_all<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        pay<T0>(v0, 0x2::balance::value<T0>(&arg0), arg1, arg2);
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun pay_or_vest<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &Recipient, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::object::ID> {
        if (0x1::option::is_none<VestingTerms>(&arg2.vesting_terms) || arg1 == 0) {
            pay<T0>(arg0, arg1, arg2.destination, arg4);
            return 0x1::option::none<0x2::object::ID>()
        };
        let v0 = 0x1::option::destroy_some<VestingTerms>(arg2.vesting_terms);
        let v1 = 0x85fdb7e3d28162b99e0df758069a3d23cff874c400b2160fc0d4618aefd3ec5c::blast_fun_linear_vesting::new_irrevocable<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg4), arg2.destination, 0x2::clock::timestamp_ms(arg3), v0.cliff_delay_ms, v0.period_duration_ms, v0.periods, arg3, arg4);
        0x85fdb7e3d28162b99e0df758069a3d23cff874c400b2160fc0d4618aefd3ec5c::blast_fun_linear_vesting::share<T0>(v1);
        0x1::option::some<0x2::object::ID>(0x2::object::id<0x85fdb7e3d28162b99e0df758069a3d23cff874c400b2160fc0d4618aefd3ec5c::blast_fun_linear_vesting::Vesting<T0>>(&v1))
    }

    public fun period_duration_ms(arg0: &VestingTerms) : u64 {
        arg0.period_duration_ms
    }

    public fun periods(arg0: &VestingTerms) : u64 {
        arg0.periods
    }

    public fun recipient(arg0: address, arg1: 0x1::option::Option<VestingTerms>) : Recipient {
        assert!(arg0 != @0x0, 12);
        Recipient{
            destination   : arg0,
            vesting_terms : arg1,
        }
    }

    public fun recipient_vesting_terms(arg0: &Recipient) : 0x1::option::Option<VestingTerms> {
        arg0.vesting_terms
    }

    public fun vesting_terms(arg0: u64, arg1: u64, arg2: u64) : VestingTerms {
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                if (arg1 <= 9223372036854775808 / arg2) {
                    arg0 <= arg1 * arg2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        VestingTerms{
            cliff_delay_ms     : arg0,
            period_duration_ms : arg1,
            periods            : arg2,
        }
    }

    // decompiled from Move bytecode v7
}

