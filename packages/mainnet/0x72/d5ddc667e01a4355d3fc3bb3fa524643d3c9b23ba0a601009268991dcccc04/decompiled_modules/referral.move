module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::referral {
    struct OpenFeeSplit has copy, drop {
        charged: u64,
        direct: address,
        direct_amt: u64,
        second: address,
        second_amt: u64,
    }

    public fun bind_referrer<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg4: address) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0));
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_unpaused(arg1, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_referrals());
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_exchange<T0>(arg2, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg0));
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_cap<T0>(arg2, arg3);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::owner<T0>(arg2);
        assert!(v1 != arg4, 13835058312980201473);
        assert!(arg4 != @0x0, 13836465692159377419);
        assert!(!0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::is_bound(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), v1), 13835339796546977795);
        let v2 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::cycle_status(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), v1, arg4);
        assert!(v2 != 2, 13835621280113754117);
        assert!(v2 != 3, 13835902759385563143);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::insert_bind<T0>(&v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(&v0, arg0), arg2, arg4);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_bind_referrer_event(&v0, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2), v1, arg4);
    }

    public(friend) fun charged(arg0: &OpenFeeSplit) : u64 {
        arg0.charged
    }

    fun credit_reward<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0));
        if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::account_exists(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)) {
            let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::held_account(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1);
            settle_pending<T0>(arg0, arg1, v1);
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::credit_account_free<T0>(&v0, arg0, v1, arg2);
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_referral_payout_event(&v0, arg1, arg2, 0x1::option::some<0x2::object::ID>(v1));
        } else {
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::add_pending(&v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(&v0, arg0), arg1, arg2);
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::accrue_referral_owed<T0>(&v0, arg0, arg2);
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_referral_payout_event(&v0, arg1, arg2, 0x1::option::none<0x2::object::ID>());
        };
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::add_earned(&v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(&v0, arg0), arg1, arg2);
    }

    public(friend) fun pay_open_rewards<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: OpenFeeSplit) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0));
        let v1 = arg1.direct_amt;
        let v2 = arg1.second_amt;
        let v3 = v1 + v2;
        if (v3 == 0) {
            return
        };
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::debit_fee_lp<T0>(&v0, arg0, v3);
        if (v1 > 0) {
            credit_reward<T0>(arg0, arg1.direct, v1);
        };
        if (v2 > 0) {
            credit_reward<T0>(arg0, arg1.second, v2);
        };
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_identity<T0>(arg0);
    }

    public fun pending_referral<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::pending(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public(friend) fun protocol_remainder(arg0: &OpenFeeSplit) : u64 {
        arg0.charged - arg0.direct_amt - arg0.second_amt
    }

    public(friend) fun quote<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u64) : OpenFeeSplit {
        let (v0, v1, v2, v3) = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::payout_targets(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1);
        let v4 = arg3 && v0;
        let (v5, _, v7, v8) = split_amounts(arg2, v4, v2, arg4, arg5, arg6);
        let v9 = if (v4) {
            v7
        } else {
            0
        };
        let v10 = if (v4) {
            v8
        } else {
            0
        };
        OpenFeeSplit{
            charged    : v5,
            direct     : v1,
            direct_amt : v9,
            second     : v3,
            second_amt : v10,
        }
    }

    public fun referee_count<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::referee_count(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun referrer_of<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : 0x1::option::Option<address> {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::referrer_of(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    fun settle_pending<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: 0x2::object::ID) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0));
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::take_pending(&v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(&v0, arg0), arg1);
        if (v1 == 0) {
            return
        };
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::release_referral_owed<T0>(&v0, arg0, v1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::credit_account_free<T0>(&v0, arg0, arg2, v1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_referral_settled_event(&v0, arg1, arg2, v1);
    }

    fun share(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun split_amounts(arg0: u64, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        if (!arg1 || arg0 == 0) {
            return (arg0, arg0, 0, 0)
        };
        let v0 = share(arg0, arg4);
        let v1 = arg0 - share(arg0, arg3);
        let v2 = if (arg2) {
            share(arg0, arg5)
        } else {
            0
        };
        assert!((v0 as u128) + (v2 as u128) <= (v1 as u128), 13836184410456064009);
        (v1, v1 - v0 - v2, v0, v2)
    }

    public fun total_referral_earned<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::total_earned(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v7
}

