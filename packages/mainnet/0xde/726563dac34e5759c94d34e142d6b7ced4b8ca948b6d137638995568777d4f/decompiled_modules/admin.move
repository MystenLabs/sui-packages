module 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::admin {
    public fun add_farm<T0, T1>(arg0: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::permission::AdminCap, arg1: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg5: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg6: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::assert_version(arg1);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::main::add_farm<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun compound_borrow_reward_end<T0, T1>(arg0: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::permission::AdminCap, arg1: &0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg2: &0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::main::Farm<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::assert_version(arg1);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::main::compound_borrow_reward_end<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun compound_borrow_reward_start<T0, T1, T2>(arg0: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::permission::AdminCap, arg1: &0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg2: &0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::main::Farm<T0, T1>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg5: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg6: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::assert_version(arg1);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::main::compound_borrow_reward_start<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun set_collateral_weight<T0, T1>(arg0: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::permission::AdminCap, arg1: &0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg2: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::main::Farm<T0, T1>, arg3: u64) {
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::assert_version(arg1);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::main::set_collateral_weight<T0, T1>(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

